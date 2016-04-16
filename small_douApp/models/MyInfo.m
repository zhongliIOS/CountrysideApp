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
    self.username = [self ReadField_String:data WithFieldName:@"username"];
    self.nickname = [self ReadField_String:data WithFieldName:@"nickname"];
    self.guid = [self ReadField_String:data WithFieldName:@"id"];
    self.mtime = [self ReadField_String:data WithFieldName:@"mtime"];
    self.ctime = [self ReadField_String:data WithFieldName:@"ctime"];
    self.mobile = [self ReadField_String:data WithFieldName:@"mobile"];
    self.typeId = [self ReadField_String:data WithFieldName:@"typeId"];
    self.locationId = [self ReadField_String:data WithFieldName:@"locationId"];
    self.avatar = [self ReadField_String:data WithFieldName:@"avatar"];

}

@end
