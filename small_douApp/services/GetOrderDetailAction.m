//
//  GetOrderDetailAction.m
//  small_douApp
//
//  Created by zhongli on 15/8/14.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetOrderDetailAction.h"

@implementation GetOrderDetailAction

-(instancetype)initWithOrderId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/orders/%@/detail.json",Id]];
    self.isValid = YES;
    return self;
}


@end
