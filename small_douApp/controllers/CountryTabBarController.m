//
//  CountryTabBarController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "CountryTabBarController.h"
#import "MainViewController.h"
#import "FenLeiVIewController.h"
#import "GoodsCarViewController.h"
#import "UserViewController.h"

@interface CountryTabBarController ()
{
    UIView *_tabBar;
    NSArray *_imgArr;
    NSArray *_imgHArr;
}
@end

@implementation CountryTabBarController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = color_bg;   
    }
    return self;
}

-(void)hideTabBar
{
    _tabBar.hidden = YES;
}
-(void)showTabBar
{
    _tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar) name:NotificationHideTabBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar) name:NotificationShowTabBar object:nil];

    [self createTabBar];
    [self createTabs];
    [self createViewControllers];
}

-(void)createTabBar
{
    _tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-TabBarHeight, ScreenW, TabBarHeight)];
    _tabBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBar];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-TabBarHeight-0.5, ScreenW, 0.5)];
    topLine.backgroundColor = color_line2;
    [self.view addSubview:topLine];
    
}

-(void)createTabs
{
    CGFloat btnWidth = ScreenW/4.0;
    NSArray *arr = @[@"首页",@"分类",@"购物车",@"账户"];
    _imgArr = @[@"home",@"label",@"shop",@"me"];
    _imgHArr = @[@"home_nav",@"label_nav",@"shop_nav",@"me_nav"];
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, TabBarHeight);
        btn.tag = i;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((btnWidth-39)/2.0, 5, 39, 27.5)];
        imageV.image = [UIImage imageNamed:_imgArr[i]];
        [btn addSubview:imageV];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), btnWidth, 14)];
        label.textColor = color_font_gray2;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:size_font4];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
        if (i==0) {
            btn.selected = YES;
            imageV.image = [UIImage imageNamed:_imgHArr[0]];
            label.textColor = color_font_green;
        }
        [btn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        [_tabBar addSubview:btn];
    }
}

-(void)createViewControllers
{
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *controllersArr = @[@"MainViewController",@"FenLeiVIewController",@"GoodsCarViewController",@"UserViewController"];
    for (int i=0; i<4; i++) {
        UIViewController *vc = [[NSClassFromString(controllersArr[i]) alloc] init];
//        if (i==0) {
//            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
//            navi.navigationBarHidden = YES;
//            [controllers addObject:navi];
//        }
//        else
        [controllers addObject:vc];
    }
    self.viewControllers = controllers;
    self.selectedIndex = 0;
}


-(void)tabBarBtnClick:(UIButton* )btn
{
    for (UIView *view in _tabBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)view;
            tempBtn.selected = NO;
            for (UIView *view in tempBtn.subviews) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    UIImageView *temp = (UIImageView *)view;
                    temp.image = [UIImage imageNamed:_imgArr[tempBtn.tag]];
                }
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)view;
                    label.textColor = color_font_gray2;
                }
            }
        }
    }
    btn.selected = YES;
    self.selectedIndex = btn.tag;
    for (UIView *view in btn.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *temp = (UIImageView *)view;
            temp.image = [UIImage imageNamed:_imgHArr[btn.tag]];
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = color_font_green;
        }
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
