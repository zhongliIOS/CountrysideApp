//
//  GetProductDetailAction.m
//  small_douApp
//
//  Created by 刘中礼 on 16/3/14.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "GetProductDetailAction.h"

@implementation GetProductDetailAction
-(instancetype)initWithId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/products/desc/%@.json",Id]];
    self.isValid = YES;
    
    return self;
}

@end
