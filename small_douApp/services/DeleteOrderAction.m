
//
//  DeleteOrderAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/31.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "DeleteOrderAction.h"

@implementation DeleteOrderAction

-(instancetype)initWithOrderId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/orders/del/%@.json",Id]];
    self.isValid = YES;
    return self;
}

@end
