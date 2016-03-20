
//
//  GetOrderListAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/31.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetOrderListAction.h"

@implementation GetOrderListAction

-(instancetype)initWithCuId:(NSNumber *)Id
{
    self = [super initWithActionURLString:@"/orders/orders_list.json"];
    self.isValid = YES;
    return self;
}



@end
