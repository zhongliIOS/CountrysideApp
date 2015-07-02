//
//  GetMyInfoAction.h
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface GetMyInfoAction : MyActionGetBase

-(instancetype)initWithMobilePhone:(NSString *)mobilePhoneNumber access_token:(NSString *)access_token;


@end
