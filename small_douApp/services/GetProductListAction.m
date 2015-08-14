//
//  GetProductListAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetProductListAction.h"

@implementation GetProductListAction

-(instancetype)initWithTypeId:(NSNumber *)Id page:(NSNumber *)page size:(NSNumber *)size sort:(NSString *)sort name:(NSString *)name
{
    self = [super initWithActionURLString:@"/products/products_list"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        if (Id) {
            [self.parameters setObject:Id forKey:@"typeId"];
        }
        if (page) {
            [self.parameters setObject:page forKey:@"page"];
        }
        if (size) {
            [self.parameters setObject:size forKey:@"size"];
        }
        if (sort) {
            [self.parameters setObject:sort forKey:@"sort"];
        }
        if (name) {
            [self.parameters setObject:name forKey:@"name"];
        }
    }
    self.isValid = YES;
    return self;
}

@end
