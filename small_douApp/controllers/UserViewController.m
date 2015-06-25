
//
//  UserViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserViewController.h"
#import "GoodsDetailViewController.h"
#import "LoginViewController.h"
#import "OrderSearchController.h"
#import "UserDetailViewController.h"
#import "MyFavViewController.h"
#import "UserNameCell.h"
#import "UserOtherCell.h"
#import "EvaluationWriteViewController.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;

}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)createTableView
{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-TabBarHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)configNavBar
{
    self.midTitle = @"我的账户";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = YES;
  
}



#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UserNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserNameCell"];
        if (!cell) {
            cell = [[UserNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserNameCell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        UserOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserOtherCell"];
        if (!cell) {
            cell = [[UserOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserOtherCell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.titleString = @[@"订单查询",@"完成订单",@"我的收藏"][indexPath.row-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 72.0;
    }
    else
     return 56;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //个人信息
        UserDetailViewController *vc = [[UserDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
    //订单查询
        OrderSearchController *vc = [[OrderSearchController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
     //完成订单
        EvaluationWriteViewController *vc =[[EvaluationWriteViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
        //我的收藏
        MyFavViewController *vc = [[MyFavViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

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
