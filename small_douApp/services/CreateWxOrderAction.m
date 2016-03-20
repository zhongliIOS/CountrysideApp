//
//  CreateWxOrderAction.m
//  small_douApp
//
//  Created by 刘中礼 on 16/3/19.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "CreateWxOrderAction.h"

@implementation CreateWxOrderAction
-(instancetype)initWithOrderId:(NSNumber *)orderId
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/orders/wxpay/createPayOrder/%@.json",orderId]];
    self.isValid = YES;
    return self;
}

@end
