//
//  TianXieOrderViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "TianXieOrderViewController.h"
#import "PayViewController.h"
#import "GoodOrderCell.h"
#import "GoodAddressCell.h"


@interface TianXieOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{

   UITableView *_tableView;
    UILabel *_priceLabel;
}
@end

@implementation TianXieOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
    [self createFootView];
}
-(void)configNavBar
{
    self.midTitle = @"填写订单";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
}
-(void)createFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-45.0, ScreenW, 45.0)];
    footView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1.0)];
    line.backgroundColor = color_line2;
    [footView addSubview:line];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 1, 200, 44.0)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font2];
    _priceLabel.textColor = color_font_red;
    _priceLabel.text = @"实付款：￥226.00";
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.tintColor = [UIColor whiteColor];
    buyBtn.frame = CGRectMake(ScreenW-128, 5, 118, 35);
    buyBtn.backgroundColor = color_btn_red;
    [buyBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    buyBtn.layer.cornerRadius = 3.0;
    buyBtn.layer.masksToBounds = YES;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:buyBtn];
    [footView addSubview:_priceLabel];
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-45.0)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)buyBtnClick
{
    PayViewController *vc = [[PayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=2) {
        GoodOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodOrderCell"];
        if (!cell) {
            cell = [[GoodOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        GoodAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodAddressCell"];
        if (!cell) {
            cell = [[GoodAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodAddressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        return 235.0;
    }
    
    return 55.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
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
