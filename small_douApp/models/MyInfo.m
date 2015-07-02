//
//  MyInfo.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyInfo.h"

@implementation MyInfo

static MyInfo *_m = nil;
+(id)defaultMyInfo
{
    if (!_m) {
        _m = [[MyInfo alloc]init];
    }
    return _m;
}

-(void)initWithModel:(NSDictionary *)data
{
    self.areaId = [self ReadField_String:data WithFieldName:@"areaId"];
    self.code = [self ReadField_String:data WithFieldName:@"code"];
    self.guid = [self ReadField_String:data WithFieldName:@"id"];
    self.name = [self ReadField_String:data WithFieldName:@"name"];
    self.regTime = [self ReadField_String:data WithFieldName:@"regTime"];
    self.tel = [self ReadField_String:data WithFieldName:@"tel"];
    self.typeId = [self ReadField_String:data WithFieldName:@"typeId"];
    self.photo = [self ReadField_String:data WithFieldName:@"photo"];

}

@end
