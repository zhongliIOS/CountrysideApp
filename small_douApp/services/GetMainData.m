//
//  GetMainData.m
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetMainData.h"

@implementation GetMainData

-(instancetype)init
{
    self = [super initWithActionURLString:@"/portals.json"];
    self.isValid = YES;
    return self;
}

@end
