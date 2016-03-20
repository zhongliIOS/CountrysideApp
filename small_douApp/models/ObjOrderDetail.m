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
    self = [super initWithDirectory:data];
    if (self) {

        self.arrProducts = [NSMutableArray array];
        NSArray *arr = [LUnity ReadField_Array:data WithFieldName:@"list"];
        for (NSDictionary *dic in arr) {
            ObjProduct *obj = [[ObjProduct alloc]initWithDirectory:dic];
            [self.arrProducts addObject:obj];
        }
        self.total_fee = [self ReadField_String:data WithFieldName:@"total_fee"];
        self.store = [self ReadField_String:data WithFieldName:@"store"];
        self.name = [self ReadField_String:data WithFieldName:@"name"];
        self.mobile = [self ReadField_String:data WithFieldName:@"mobile"];
        self.location = [self ReadField_String:data WithFieldName:@"location"];
        self.sex = [self ReadField_Number:data WithFieldName:@"sex"];
        self.address = [self ReadField_String:data WithFieldName:@"address"];

    }
    return self;
}

@end
