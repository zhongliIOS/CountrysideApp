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

@interface OrderStatuesController ()
{

    ObjOrderDetail *_orderDetailObj;

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
//               [self updateUI];
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
    [self downLoadData];
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
