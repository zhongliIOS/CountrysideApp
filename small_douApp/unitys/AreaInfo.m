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

-(NSString *)searchAreaNameWithId:(NSString *)Id
{

    for (int i=0; i<[_dataList GetCount]; i++) {
        ObjArea *obj = (ObjArea *)[_dataList GetIndexAt:i WithIsDESC:YES];
        if ([obj.guid integerValue]==[Id integerValue]) {
            return obj.name;
        }
    }

    return nil;
}

@end
