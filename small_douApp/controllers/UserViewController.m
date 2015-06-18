
//
//  UserViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;

}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContentView];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)createTableView
{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-TabBarHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)configNavBar
{
    self.midTitle = @"我的账户";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = YES;
  
}

-(void)createContentView
{
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 


    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 44.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
