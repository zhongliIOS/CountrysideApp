//
//  MyInfo.h
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjCustomer.h"

@interface MyInfo : ObjCustomer


+(id)defaultMyInfo;

-(void)initWithModel:(NSDictionary *)data;

@end
