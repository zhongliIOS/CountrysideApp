//
//  ObjOrder.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjOrder.h"

@implementation ObjOrder

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.amount = [self ReadField_String:data WithFieldName:@"amount"];
        self.area = [self ReadField_String:data WithFieldName:@"area"];
        self.code = [self ReadField_String:data WithFieldName:@"code"];
        self.cuId = [self ReadField_String:data WithFieldName:@"cuId"];
        self.desc = [self ReadField_String:data WithFieldName:@"description"];
        self.genTime = [self ReadField_String:data WithFieldName:@"genTime"];
        self.status = [self ReadField_String:data WithFieldName:@"status"];
        self.tel = [self ReadField_String:data WithFieldName:@"tel"];
        
        self.doneTime = [self ReadField_String:data WithFieldName:@"doneTime"];
        self.payTime = [self ReadField_String:data WithFieldName:@"payTime"];
        self.vCode = [self ReadField_String:data WithFieldName:@"vCode"];


    }
    return self;
}

@end
