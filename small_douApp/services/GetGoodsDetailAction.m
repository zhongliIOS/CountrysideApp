
//
//  GetGoodsDetailAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/7.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetGoodsDetailAction.h"

@implementation GetGoodsDetailAction

-(instancetype)initWithId:(NSString *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/products/%@.json",Id]];
    self.isValid = YES;
    return self;
}

@end
