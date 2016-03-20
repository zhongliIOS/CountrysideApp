//
//  ObjProduct.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjProduct.h"

@implementation ObjProduct

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.code = [self ReadField_String:data WithFieldName:@"code"];
        self.desc = [self ReadField_String:data WithFieldName:@"description"];
        self.discount = [self ReadField_String:data WithFieldName:@"discount"];
        if ([self.discount isEqualToString:@""]) {
            self.discount = @"1.0";
        }
        self.proId = [self ReadField_Number:data WithFieldName:@"proId"];
        self.total_fee = [self ReadField_Number:data WithFieldName:@"total_fee"];

        self.mu = [self ReadField_String:data WithFieldName:@"mu"];
        self.name = [self ReadField_String:data WithFieldName:@"name"];
        self.number = [self ReadField_String:data WithFieldName:@"number"];
        self.pics = [self ReadField_String:data WithFieldName:@"pics"];
        self.place = [self ReadField_String:data WithFieldName:@"place"];
        self.price = [self ReadField_String:data WithFieldName:@"price"];
        self.sl = [self ReadField_String:data WithFieldName:@"sl"];
        self.typeId = [self ReadField_String:data WithFieldName:@"typeId"];
        self.pic = [self ReadField_String:data WithFieldName:@"pic"];
        
        self.num = [self ReadField_String:data WithFieldName:@"num"];

    }

    return self;
}

@end
