//
//  ObjOrderDetail.m
//  small_douApp
//
//  Created by zhongli on 15/8/14.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjOrderDetail.h"

@implementation ObjOrderDetail
-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super init];
    if (self) {

        self.arrProducts = [NSMutableArray array];
        NSArray *arr = [LUnity ReadField_Array:data WithFieldName:@"list"];
        for (NSDictionary *dic in arr) {
            ObjProduct *obj = [[ObjProduct alloc]initWithDirectory:dic];
            [self.arrProducts addObject:obj];
        }

    }
    return self;
}

@end
