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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
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
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, TabBarHeight);
        btn.tag = i;
        if (i==0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:color_font_gray2 forState:UIControlStateNormal];
        [btn setTitleColor:color_green forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
        [_tabBar addSubview:btn];
        
    }
    

}

-(void)createViewControllers
{
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *controllersArr = @[@"MainViewController",@"FenLeiVIewController",@"GoodsCarViewController",@"UserViewController"];
    for (int i=0; i<4; i++) {
        UIViewController *vc = [[NSClassFromString(controllersArr[i]) alloc] init];
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:vc];
//        navi.navigationBarHidden = YES;
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
        }
    }
    btn.selected = YES;
    self.selectedIndex = btn.tag;
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
