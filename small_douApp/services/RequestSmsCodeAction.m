//
//  RequestSmsCodeAction.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/29.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "RequestSmsCodeAction.h"

@implementation RequestSmsCodeAction

-(id)initWithMobilePhoneNum:(NSString *)str
{
    self = [super initWithActionURLString:@"auth/requestSmsCode.json"];
    if (self) {
        self.parameters = [@{@"mobilePhoneNumber":str} mutableCopy];
    }
    self.isValid = YES;
    return self;
}

@end
