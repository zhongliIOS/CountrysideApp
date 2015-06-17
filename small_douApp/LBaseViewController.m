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
    UIButton *_rightBtn;
   
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
    [self.view addSubview:_navBar];
    _midMaxLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-150)/2, 20, 150, 44)];
    _midMaxLabel.font = [UIFont systemFontOfSize:size_title2];
    _midMaxLabel.textAlignment = NSTextAlignmentCenter;
    [_navBar addSubview:_midMaxLabel];
    //左右边按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 20, 50, 44);
    [_leftBtn addTarget:self action:@selector(leftButItemClick) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"arrow-nav-white-36x36-left@2x"] forState:UIControlStateNormal];
    [self.view addSubview:_leftBtn];
}


-(void)leftButItemClick
{




}
-(void)rightButItemClick
{



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
