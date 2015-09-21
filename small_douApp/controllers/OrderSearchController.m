//
//  OrderSearchController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "OrderSearchController.h"
#import "OrderSumarryCell.h"
#import "GetOrderListAction.h"
#import "DeleteOrderAction.h"
#import "ObjOrder.h"
#import "PayViewController.h"
#import "TianXieOrderViewController.h"
#import "OrderStatuesController.h"

@interface OrderSearchController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    ObjectList *_objList;
}
@end

@implementation OrderSearchController

- (void)initData
{
    MyInfo *user = [MyInfo defaultMyInfo];
    GetOrderListAction *act = [[GetOrderListAction alloc]initWithCuId:user.guid];
    if (!act.isValid) {
        return;
    }
    [_objList ClearAll];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSArray *arr = [result try_get_data_with_array];
            if (arr) {
                for (NSDictionary *dic in arr) {
                    ObjOrder *obj = [[ObjOrder alloc] initWithDirectory:dic];
                    [_objList Add:obj];
                }
                [_tableView reloadData];
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
    _objList = [[ObjectList alloc] init];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)configNavBar
{
    self.midTitle = @"订单查询";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;

}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    OrderSumarryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderSumarryCell"];
    if (!cell) {
        cell = [[OrderSumarryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderSumarryCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillDataWithModel:(ObjOrder *)[_objList GetIndexAt:indexPath.row WithIsDESC:YES]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ObjOrder *order = (ObjOrder *)[_objList GetIndexAt:indexPath.row WithIsDESC:YES];
    OrderStatuesController *vc = [[OrderStatuesController alloc]init];
    vc.orderId = order.guid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteWithOrderId:[(ObjOrder *)[_objList GetIndexAt:indexPath.row WithIsDESC:YES] guid]];
}

-(void)deleteWithOrderId:(NSNumber *)num
{
    DeleteOrderAction *act = [[DeleteOrderAction alloc] initWithOrderId:num];
    if (!act.isValid) {
        return;
    }
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            [self initData];
        }
        else
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [_objList GetCount];
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
