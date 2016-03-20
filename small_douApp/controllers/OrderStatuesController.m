//
//  OrderStatuesController.m
//  small_douApp
//
//  Created by zhongli on 15/8/14.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "OrderStatuesController.h"
#import "GetOrderDetailAction.h"
#import "ObjOrderDetail.h"
#import "GoodOrderCell.h"
#import "GoodAddressCell.h"

@interface OrderStatuesController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    ObjOrderDetail *_orderDetailObj;
    NSArray *_productsArr;
    UILabel *_priceLabel;
    UIView  *_footView;
    UIButton *_buyBtn;
}
@end

@implementation OrderStatuesController

-(void)downLoadData
{
    GetOrderDetailAction *act = [[GetOrderDetailAction alloc] initWithOrderId:_orderId];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
       
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
       MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
       if ([result get_error_code]==kServerErrorCode_OK) {
           NSDictionary *dic = [result try_get_data_with_dict];
           if (dic) {
               _orderDetailObj = [[ObjOrderDetail alloc]initWithDirectory:dic];
               _productsArr = _orderDetailObj.arrProducts;
               [_tableView reloadData];
               [self updateUI];
           }
       }
       else
           [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
   } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

   }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
    [self createFootView];
    [self downLoadData];

}

-(void)updateUI
{
    NSString *status = _orderDetailObj.status;
    if (!status) {
        return;
    }
    self.midTitle = status;
    if ([status isEqualToString:OrderStatusWaitPay]) {
        _footView.hidden = NO;
    }
    else if ([status isEqualToString:OrderStatusPeiSongzhong]) {
        _footView.hidden = YES;
    }
    else if ([status isEqualToString:OrderStatusDaiPingjia])
    {
        _footView.hidden = NO;
        [_buyBtn setTitle:@"去评价" forState:UIControlStateNormal];
    }
    else if ([status isEqualToString:OrderStatusCompleted])
    {
        _footView.hidden = YES;
    }
}

-(void)configNavBar
{
    self.midTitle = _orderDetailObj.status;
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
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

-(void)createFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-45.0, ScreenW, 45.0)];
    _footView = footView;
    footView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1.0)];
    line.backgroundColor = color_line2;
    [footView addSubview:line];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 1, 200, 44.0)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font2];
    _priceLabel.textColor = color_font_red;
//    _priceLabel.text = [self getStringWithArr:_productsArr];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _buyBtn = buyBtn;
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

-(void)buyBtnClick
{
      
}

#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row!=_productsArr.count) {
        GoodOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodOrderCell"];
        if (!cell) {
            cell = [[GoodOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillDataWithProduct:(ObjProduct *)_productsArr[indexPath.row] ];
       
        return cell;
    }
    else
    {
        GoodAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodAddressCell"];
        if (!cell) {
            cell = [[GoodAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodAddressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillDataWithOrderDeatilModel:_orderDetailObj];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<_orderDetailObj.arrProducts.count) {
        return 55.0;
    }
    return 55.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _orderDetailObj.arrProducts.count+1;
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
