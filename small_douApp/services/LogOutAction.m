//
//  LogOutAction.m
//  small_douApp
//
//  Created by zhongli on 15/6/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LogOutAction.h"

@implementation LogOutAction

-(instancetype)initWithMobilePhone:(NSString *)mobilePhoneNumber
{
    self = [super initWithActionURLString:@""];
    if (self) {
        if (mobilePhoneNumber)
          self.parameters = [@{@"mobilePhoneNumber":mobilePhoneNumber} mutableCopy];
    }
    self.isValid = YES;

    return self;

}

@end
