//
//  ObjArea.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjArea.h"

@implementation ObjArea

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.code = [self ReadField_String:data WithFieldName:@"code"];
        self.location = [self ReadField_String:data WithFieldName:@"location"];
        self.name = [self ReadField_String:data WithFieldName:@"name"];
        self.staffId = [self ReadField_String:data WithFieldName:@"staffId"];
        self.spName = [self ReadField_String:data WithFieldName:@"pic"];
        self.spLocation = [self ReadField_String:data WithFieldName:@"spLocation"];

    }
    return self;

}

@end
