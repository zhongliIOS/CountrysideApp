//
//  ObjGoodCar.m
//  small_douApp
//
//  Created by zhongli on 15/7/21.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjGoodCar.h"

@implementation ObjGoodCar

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.num = [self ReadField_String:data WithFieldName:@"num"];
    }
    return self;

}

@end
