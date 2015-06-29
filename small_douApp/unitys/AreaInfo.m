//
//  AreaInfo.m
//  small_douApp
//
//  Created by zhongli on 15/6/26.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AreaInfo.h"

@implementation AreaInfo

static AreaInfo *m = nil;
+(id)areaInfo
{
    if (!m) {
        m = [[AreaInfo alloc]init];
    }
    return m;

}

@end
