//
//  UserDetailViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()
{

    UIImageView *_iconImageV;

}
@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
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
            [bgView addSubview:detailLabel];
        
        }
    }

}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==0) {
        //选择头像
        
    }
    if (btn.tag==1) {
        //修改用户名
        
    }
    if (btn.tag==2) {
        //修改默认小区
        
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
