//
//  VerifySmsCodeAction.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/29.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "VerifySmsCodeAction.h"

@implementation VerifySmsCodeAction

-(id)initWithMobile:(NSString *)mobilePhoneNumber andCode:(NSString *)smsCode
{
    self = [super initWithActionURLString:@"auth/verifySmsCode.json"];
    if (self) {
        self.parameters = [@{@"mobilePhoneNumber":mobilePhoneNumber,@"smsCode":smsCode} mutableCopy];
    }
    self.isValid = YES;
    return self;
}


@end
