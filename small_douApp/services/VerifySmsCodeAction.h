//
//  VerifySmsCodeAction.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/29.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface VerifySmsCodeAction : MyActionPostBase

-(id)initWithMobile:(NSString *)mobilePhoneNumber andCode:(NSString *)smsCode;

@end
