//
//  CountryTabBarController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "CountryTabBarController.h"

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
    _tabBar.backgroundColor = color_green;
    [self.view addSubview:_tabBar];

}

-(void)createTabs
{


}

-(void)createViewControllers
{



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
