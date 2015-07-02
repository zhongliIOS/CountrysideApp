//
//  GetMyGoodsCarAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetMyGoodsCarAction.h"

@implementation GetMyGoodsCarAction

-(instancetype)initWithCustomId:(NSString *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/shoppingCarts/shoppingCarts_list/%@.json",Id]];

    return self;
}

@end
