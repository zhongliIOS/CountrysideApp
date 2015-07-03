//
//  ObjMainData.m
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjMainData.h"
#import "ObjProduct.h"

@implementation ObjMainData

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.arrBanner = [LUnity ReadField_Array:data WithFieldName:@"banner"];
        self.arrJingpin = [NSMutableArray array];
        self.arrProducts = [NSMutableArray array];
        NSArray *arr = [LUnity ReadField_Array:data WithFieldName:@"jingpin"];
        for (NSDictionary *dic in arr) {
            ObjProduct *obj = [[ObjProduct alloc]initWithDirectory:dic];
            [self.arrJingpin addObject:obj];
        }
        NSArray *arrAll = [LUnity ReadField_Array:data WithFieldName:@"products"];
        for (NSDictionary *dic in arrAll) {
            ObjProduct *obj = [[ObjProduct alloc]initWithDirectory:dic];
            [self.arrProducts addObject:obj];
        }
    }
    return self;
}

@end
