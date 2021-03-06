//
//  LoginViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestSmsCodeAction.h"
#import "VerifySmsCodeAction.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UIScrollViewDelegate>
{
    CustomTextField *_phoneTf;
    CustomTextField *_yzmTf;
    NSTimer *_timer;
    NSInteger _time;//倒计时
    UIButton *_getYZM;//获取验证码的按钮
    UIScrollView *_mainScrollView;
}
@end

@implementation LoginViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:UIKeyboardDidHideNotification object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
    
}

-(void)configNavBar
{
    self.midTitle = @"登录";
    self.midTitelColor = [UIColor whiteColor];
//    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.hidden = YES;
}

-(void)createContentView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight)];
    _mainScrollView.delegate = self;
    _mainScrollView.contentSize = CGSizeMake(ScreenW, ScreenH-TopHeight+1);
    [self.view addSubview:_mainScrollView];
    CGFloat viewHight = 90;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW-176/2.0)/2.0, 15, 176/2.0, 159/2.0)];
    imgV.image = [UIImage imageNamed:@"huangua"];
    [_mainScrollView addSubview:imgV];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(imgV.frame)+25, ScreenW-2*leftSpace, viewHight)];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.layer.cornerRadius = 5.0;
    bgview.layer.masksToBounds = YES;
    bgview.layer.borderWidth = bordWidth;
    bgview.layer.borderColor = color_line2.CGColor;
    [_mainScrollView addSubview:bgview];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenW-2*leftSpace, 0.5)];
    line.backgroundColor = color_line2;
    [bgview addSubview:line];
    
    NSArray *arr = @[@"请输入您的手机号",@"请输入验证码"];
    for (int i=0; i<2; i++) {
        CustomTextField *tf = [[CustomTextField alloc] initWithFrame:CGRectMake(10, 45.5*i, ScreenW-2*leftSpace-20, 45)];
        tf.font = [UIFont systemFontOfSize:size_font2];
        tf.placeholder = arr[i];
        tf.placeholderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        if (i==0) {
            [tf LimitWithMaxLength:11];
            _phoneTf = tf;
        }
        else
        {
            [tf LimitWithMaxLength:6];
            _yzmTf = tf;
        }
        
        [bgview addSubview:tf];
    } 
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getYZM = btn;
    btn.frame = CGRectMake(ScreenW-2*leftSpace-110, 9, 100, 27);
    btn.layer.cornerRadius = 5.0;
    btn.backgroundColor = color_btn_green;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    btn.tag = 0;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake((ScreenW-193)/2.0, CGRectGetMaxY(bgview.frame)+22, 193, 38);
    loginBtn.layer.cornerRadius = 5.0;
    loginBtn.tag = 1;
    loginBtn.backgroundColor = color_btn_green;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:size_font1];
    [loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:loginBtn];
}

-(void)login
{
    if (_phoneTf.text.length!=11) {
        [LUnity showErrorHUDViewAtView:self.view WithTitle:@"请输入正确的手机号"];
        return;
    }
    if (_yzmTf.text.length==0) {
        [LUnity showErrorHUDViewAtView:self.view WithTitle:@"请输入验证码"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    VerifySmsCodeAction *act = [[VerifySmsCodeAction alloc]initWithMobile:_phoneTf.text andCode:_yzmTf.text];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSDictionary *resultDic = [result try_get_data_with_dict];
            if (resultDic) {
                NSString *access_token = resultDic[@"access_token"];
                if (access_token) {
                    [[NSUserDefaults standardUserDefaults]setObject:access_token forKey:My_token];
                    [[NSUserDefaults standardUserDefaults]setObject:_phoneTf.text forKey:My_phone];
                    [self getMyInfo:access_token];
                }
            }

        }
        else
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];


    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}

-(void)getMyInfo:(NSString *)access_token
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:access_token forHTTPHeaderField:@"access-token"];
    [manager GET:[NSString stringWithFormat:@"/customers/%@.json",_phoneTf.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        NSLog(@"%@",responseObject);
        if ([result get_error_code]==kServerErrorCode_OK){
            MyInfo *m = [MyInfo defaultMyInfo];
            [m initWithModel:[result try_get_data_with_dict]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateMyInfo object:nil];
            [LUnity showErrorHUDViewAtView:self.view WithTitle:@"登陆成功"];
            
            AppDelegate * app  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app pushTabBarVC];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 0) {
        //获取验证码
        [self getSMSCode];
    }
    if (btn.tag == 1) {
        //登录
        [self login];
    }

}
-(void)getSMSCode
{
  
    if (_phoneTf.text.length!=11) {
        [LUnity showErrorHUDViewAtView:self.view WithTitle:@"请输入正确的手机号"];
        return;
    }
    RequestSmsCodeAction *act = [[RequestSmsCodeAction alloc]initWithMobilePhoneNum:_phoneTf.text];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        NSLog(@"request:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject;
            if (dic[@"smsId"]) {
                [LUnity showErrorHUDViewAtView:self.view WithTitle:@"验证码发送成功"];
                [self daojishi];
            }
            else
            {
                [LUnity showErrorHUDViewAtView:self.view WithTitle:@"系统繁忙，请稍后再试"];

            }
        }
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        
    }];

}
-(void)daojishi
{
    _getYZM.userInteractionEnabled = NO;
    _getYZM.backgroundColor = color_font_gray2;
    _time = 60;
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
}
- (void)timerFireMethod:(NSTimer *)timer{
    if (_time>1) {
        _time -= 1;
        NSString *string = [NSString stringWithFormat:@"%d",_time];
        [_getYZM setTitle:string forState:UIControlStateNormal];
        
    }else{
        _getYZM.userInteractionEnabled = YES;
        _getYZM.backgroundColor = color_btn_green;
        [_getYZM setTitle:@"获取验证码" forState:UIControlStateNormal];

        [timer invalidate];
        timer = nil;
    }
}
//键盘弹起
-(void)showKeyboard:(NSNotification *)not{
    CGSize size = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat queBtnMaxY = 250.0;
    CGFloat maxJipanY = ScreenH-TopHeight-size.height;
    if (queBtnMaxY-maxJipanY>0) {
        _mainScrollView.contentOffset = CGPointMake(0, queBtnMaxY-maxJipanY);

    }
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}


//键盘隐藏
-(void)hideKeyboard{
    _mainScrollView.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
