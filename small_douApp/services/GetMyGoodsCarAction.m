//
//  GetMyGoodsCarAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetMyGoodsCarAction.h"

@implementation GetMyGoodsCarAction

-(instancetype)init
{
    self = [super initWithActionURLString:@"/shoppingCarts/shoppingCarts_list.json"];
    self.isValid = YES;

    return self;
}

@end
