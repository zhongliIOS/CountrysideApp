//
//  GetFavoritesAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/13.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetFavoritesAction.h"

@implementation GetFavoritesAction

-(instancetype)initWithCustomerId:(NSNumber *)Id
{
    self = [super initWithActionURLString:@"/customer/favorites.json"];
    self.isValid = YES;
    return self;
}

@end
