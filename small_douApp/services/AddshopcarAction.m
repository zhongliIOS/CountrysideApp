//
//  AddshopcarAction.m
//  small_douApp
//
//  Created by 刘中礼 on 16/3/20.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "AddshopcarAction.h"

@implementation AddshopcarAction

-(instancetype)initWithProId:(NSNumber *)proId num:(NSNumber *)num
{

    self = [super initWithActionURLString:@"/shoppingCarts.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        if (proId) {
            [self.parameters setObject:proId forKey:@"proId"];
        }
        if (num) {
            [self.parameters setObject:num forKey:@"num"];
        }

    }
    self.isValid = YES;
    return self;

}


@end
