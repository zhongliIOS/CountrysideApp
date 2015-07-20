//
//  ObjReview.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjReview.h"

@implementation ObjReview

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.content = [self ReadField_String:data WithFieldName:@"content"];
        self.level = [self ReadField_String:data WithFieldName:@"level"];
    }
    return self;
}

@end
