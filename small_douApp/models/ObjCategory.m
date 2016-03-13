//
//  ObjCategory.m
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjCategory.h"

@implementation ObjCategory

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.name = [self ReadField_String:data WithFieldName:@"name"];
        self.desc = [self ReadField_String:data WithFieldName:@"description"];
    }
    return self;
}

@end
