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
    NSArray *_areaArray;
    UIPickerView *_pickView;
    UIView *_cancelAndCompleteView;
    NSString *_currentArea;
    UILabel *_areaDetailLabel;
}
@end

@implementation UserDetailViewController

-(void)initData
{

    _areaArray=@[@"汤臣花园一期",@"碧桂园",@"山水龙城",@"鞍山新村",@"雨山湖小区",@"工大东区"];

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
        if (i!=2) {
            UIImageView *nextImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 17.5, 14, 20)];
            nextImgV.image = [UIImage imageNamed:@"jinru"];
            [bgView addSubview:nextImgV];
        }
        else
        {
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
            [bgView addSubview:_iconImageV];
        }
        else
        {
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-200, 0, 168, viewH)];
            detailLabel.textColor = color_font_gray2;
            detailLabel.text = @"ihanqi";
            detailLabel.font = [UIFont systemFontOfSize:size_font2];
            detailLabel.textAlignment = NSTextAlignmentRight;
            if (i==2) {
                _areaDetailLabel = detailLabel;

            }
            [bgView addSubview:detailLabel];
        
        }
    }

}

-(void)btnClick:(UIButton *)btn
{
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
    _iconImageV.image = newImage;
    NSLog(@"NewimageDataLength%ld",[UIImageJPEGRepresentation(newImage, 1.0) length]);
    NSLog(@"Newheight:%lf==width:%lf",newImage.size.height,newImage.size.width);
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
    return _areaArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = _areaArray[row];
    NSString *string = [[NSString alloc]initWithFormat:@"%@",title];
    return string;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_areaArray[row]]];
    [string addAttribute:NSForegroundColorAttributeName value:color_font_black range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size_font1] range:NSMakeRange(0, string.length)];

    return string;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _currentArea = _areaArray[row] ;
}

-(void)pickCancelSureClick:(UIButton *)btn
{

    _pickView.hidden = YES;
    _cancelAndCompleteView.hidden = YES;
    if (btn.tag==1) {
        _areaDetailLabel.text = _currentArea;
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
