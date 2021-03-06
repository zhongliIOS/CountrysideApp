//
//  LBaseViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LBaseViewController.h"

@interface LBaseViewController ()
{
    UILabel *_midMaxLabel;
   
}
@end

@implementation LBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = color_bg;

}

-(void)createNavBar
{
    _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, TopHeight)];
    _navBar.userInteractionEnabled = YES;
    self.navTintColor = color_green;

    [self.view addSubview:_navBar];
    _midMaxLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-150)/2, 20, 150, 44)];
    _midMaxLabel.font = [UIFont systemFontOfSize:size_title2];
    _midMaxLabel.textAlignment = NSTextAlignmentCenter;
    [_navBar addSubview:_midMaxLabel];
    //左右边按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:size_font1];
    _leftBtn.frame = CGRectMake(0, 20, 50, 44);
    [_leftBtn addTarget:self action:@selector(leftButItemClick) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.hidden = YES;
    [_leftBtn setTintColor:[UIColor whiteColor]];

    [_navBar addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.frame = CGRectMake(ScreenW-50, 20, 40, 44);
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(rightButItemClick) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:size_font1];
    [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_rightBtn setTintColor:[UIColor whiteColor]];

    [_navBar addSubview:_rightBtn];
}


-(void)leftButItemClick
{

    [self.navigationController popViewControllerAnimated:YES];


}
-(void)rightButItemClick
{
    [self.navigationController popViewControllerAnimated:YES];


}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    
    return UIStatusBarStyleLightContent;
    
}
-(void)setNavTintColor:(UIColor *)navTintColor
{
    _navBar.backgroundColor = navTintColor;

}
-(void)setMidTitelColor:(UIColor *)midTitelColor
{

    _midMaxLabel.textColor = midTitelColor;

}
-(void)setMidTitle:(NSString *)midTitle
{
    _midTitle = midTitle;
    _midMaxLabel.text = midTitle;

}
-(void)postWithBodyDic:(NSDictionary *)dic andUrl:(NSString *)url success:(Sussess)success fail:(Failure)fail;
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,url]]];
    [request setHTTPMethod:@"POST"];
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:jsonData];
    
    //post
    [request setHTTPBody:postBody];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
        NSData *data = responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(dic,operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
        fail(error,operation);
    }];
    [operation start];
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
