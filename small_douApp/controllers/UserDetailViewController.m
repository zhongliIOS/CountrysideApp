//
//  UserDetailViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{

    UIImageView *_iconImageV;
    UIPickerView *_pickView;
    UIView *_cancelAndCompleteView;
    ObjArea *_currentArea;
    UILabel *_areaDetailLabel;
    UITextField *_nickNameTf;
    ObjectList *_areaList;
    NSString *_currentPhoto;
    MyInfo *_user;
}
@end

@implementation UserDetailViewController

-(void)initData
{
    AreaInfo *area = [AreaInfo areaInfo];
    _areaList = area.dataList;
    _user = [MyInfo defaultMyInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
    [self createPickView];
}
-(void)createPickView
{
    CGFloat height = ISiPhone4?130.0:150;
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,ScreenH-height, ScreenW, height)];
    _pickView.delegate = self;
    _pickView.backgroundColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    _pickView.showsSelectionIndicator = YES;
    _pickView.dataSource = self;
    _pickView.hidden = YES;
    _currentArea = (ObjArea *)[_areaList Find:[NSNumber numberWithInteger:[_user.areaId integerValue]]];
    [_pickView selectRow:[_areaList GetIndexByGuId:_user.areaId] inComponent:0 animated:NO];
    [self.view addSubview:_pickView];
    
    _cancelAndCompleteView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-height-40, ScreenW, 40)];
    _cancelAndCompleteView.backgroundColor = [UIColor whiteColor];
    _cancelAndCompleteView.hidden = YES;
    [self.view addSubview:_cancelAndCompleteView];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((ScreenW-60)*i, 0, 60, 40);
        [btn setTitle:@[@"取消",@"完成"][i] forState:UIControlStateNormal];
        [btn setTitleColor:color_font_black forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font1];
        btn.tag = i;
        [btn addTarget:self action:@selector(pickCancelSureClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelAndCompleteView addSubview:btn];
    }
}
-(void)configNavBar
{
    self.midTitle = @"个人信息";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
}

-(void)createContentView
{
    CGFloat viewH = 55.0;
    NSArray *arr = @[@"我的头像",@"用户名",@"默认小区"];
    for (int i=0; i<3; i++) {
        UIButton *bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        bgView.frame = CGRectMake(0, TopHeight+10+(viewH+10)*i, ScreenW, viewH);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.tag = i;
        [bgView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, 100, viewH)];
        label.textColor = color_font_black;
        label.font = [UIFont systemFontOfSize:size_font2];
        label.text = arr[i];
        [bgView addSubview:label];
        if (i==2) {
            UIImageView *nextImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-28, 20.5, 20, 14)];
            nextImgV.image = [UIImage imageNamed:@"xiala"];
            [bgView addSubview:nextImgV];
        }
       
        if (i==0) {
            _iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-82, 2.5, 50, 50)];
            _iconImageV.layer.cornerRadius = 25.0;
            _iconImageV.layer.masksToBounds = YES;
            _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
            _iconImageV.backgroundColor = color_bg;
            [_iconImageV sd_setImageWithURL:[NSURL URLWithString:_user.photo] placeholderImage:nil];
            [bgView addSubview:_iconImageV];
        }
        else if(i==1)
        {
            _nickNameTf = [[UITextField alloc] initWithFrame:CGRectMake(ScreenW-250, 0, 218, viewH)];
            _nickNameTf.textColor = color_font_gray2;
            _nickNameTf.text = _user.name;
            _nickNameTf.placeholder = @"暂无";
            _nickNameTf.font = [UIFont systemFontOfSize:size_font2];
            _nickNameTf.textAlignment = NSTextAlignmentRight;
            _nickNameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
            [bgView addSubview:_nickNameTf];
        }
        else
        {
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-200, 0, 168, viewH)];
            detailLabel.textColor = color_font_gray2;
            detailLabel.text = [[AreaInfo areaInfo] searchAreaNameWithId:_user.areaId];
            detailLabel.font = [UIFont systemFontOfSize:size_font2];
            detailLabel.textAlignment = NSTextAlignmentRight;
            _areaDetailLabel = detailLabel;
            [bgView addSubview:detailLabel];
        }
    }

}

-(void)rightButItemClick
{
    NSString *newName = _nickNameTf.text;
    ObjArea *area = _currentArea;
    NSMutableDictionary *paramets = [NSMutableDictionary dictionary];
    if (![_user.name isEqualToString:newName]) {
        [paramets setObject:newName forKey:@"name"];
    }
    if (!([_user.areaId integerValue]== [area.guid integerValue])) {
        [paramets setObject:area.guid forKey:@"areaId"];
    }
    if (_currentPhoto) {
        [paramets setObject:_currentPhoto forKey:@"photo"];

    }
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:My_token];
    NSString *phoneNum = [[MyInfo defaultMyInfo] tel];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    [manager POST:[NSString stringWithFormat:@"/customers/%@/edit",phoneNum] parameters:paramets success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        if ([result get_error_code]==kServerErrorCode_OK) {
            MyInfo *myinfo = [MyInfo defaultMyInfo];
            [myinfo initWithModel:[result try_get_data_with_dict]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateMyInfo object:nil];
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

-(void)upLoadImageWithImage:(UIImage *)image
{
    if (!image) {
        return;
    }
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:My_token];
    NSString *phoneNum = [[MyInfo defaultMyInfo] tel];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:phoneNum forHTTPHeaderField:@"tel-no"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    [manager POST:@"/files/photo/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
         [formData appendPartWithFileData:imageData name:@"image" fileName:@"testImage" mimeType:@"image"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        if ([dic[@"errcode"] integerValue]==0) {
            _currentPhoto = [LUnity ReadField_String:dic WithFieldName:@"data"];
            [[SDImageCache sharedImageCache] removeImageForKey:_currentPhoto withCompletion:^{
                [_iconImageV sd_setImageWithURL:[NSURL URLWithString:_currentPhoto] placeholderImage:nil];
            }];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

-(void)btnClick:(UIButton *)btn
{
    [self.view endEditing:YES];

    if (btn.tag==0) {
        //选择头像
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        [action showInView:self.view];
    }
    if (btn.tag==1) {
        //修改用户名
        
    }
    if (btn.tag==2) {
        //修改默认小区
        _pickView.hidden = NO;
        _cancelAndCompleteView.hidden = NO;
    }


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

#pragma mark---ActionsheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //相机
            //判断是否能使用相机或者相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
            }
            else
            {
                NSLog(@"不支持相机");
            }
        }
            break;
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            else
            {
                NSLog(@"不支持相册");
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)pickImageWithType:(UIImagePickerControllerSourceType)type
{
    //图片选取器
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    //代理
    picker.delegate = self;
    //设置图片来源
    picker.sourceType = type;
    //能否编辑
    //YES:出现编辑区域,进行截取,一般用于头像选择
    //NO:直接选择图片
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImage *fixOrientationImage = [image fixOrientation];
    UIImage *newImage = [LUnity ReduceToDefaultSize:fixOrientationImage];
    NSLog(@"NewimageDataLength%ld",[UIImageJPEGRepresentation(newImage, 1.0) length]);
    NSLog(@"Newheight:%lf==width:%lf",newImage.size.height,newImage.size.width);
    [self upLoadImageWithImage:newImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消的时候,调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"选择取消");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark------pickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_areaList GetCount];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [(ObjArea *)[_areaList GetIndexAt:row WithIsDESC:YES] name];
    NSString *string = [[NSString alloc]initWithFormat:@"%@",title];
    return string;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _currentArea = (ObjArea *)[_areaList GetIndexAt:row WithIsDESC:YES] ;
}

-(void)pickCancelSureClick:(UIButton *)btn
{

    _pickView.hidden = YES;
    _cancelAndCompleteView.hidden = YES;
    if (btn.tag==1) {
        _areaDetailLabel.text = _currentArea.name;
    }


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
