//
//  OrderStatuesController.h
//  small_douApp
//
//  Created by zhongli on 15/8/14.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LBaseViewController.h"

@interface OrderStatuesController : LBaseViewController

//1 待支付，2已支付，3，待评价，4，已完成
@property(nonatomic,assign)NSUInteger status;
@property(nonatomic,strong)NSNumber *orderId;


@end
