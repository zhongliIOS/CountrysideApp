//
//  CreateAliOrderAction.m
//  small_douApp
//
//  Created by zhongli on 15/8/13.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "CreateAliOrderAction.h"

@implementation CreateAliOrderAction

-(instancetype)initWithOrderId:(NSNumber *)orderId
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/orders/alipay/createPayOrder/%@.json",orderId]];
    self.isValid = YES;
    return self;
}

@end
