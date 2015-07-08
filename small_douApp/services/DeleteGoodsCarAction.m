//
//  DeleteGoodsCarAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "DeleteGoodsCarAction.h"

@implementation DeleteGoodsCarAction

-(instancetype)initWithGoodId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/shoppingCarts/del/%@.json",Id]];
    self.isValid = YES;
    return self;
}
@end
