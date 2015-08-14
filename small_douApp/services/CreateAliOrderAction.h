//
//  CreateAliOrderAction.h
//  small_douApp
//
//  Created by zhongli on 15/8/13.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface CreateAliOrderAction : MyActionGetBase

-(instancetype)initWithOrderId:(NSNumber *)orderId;

@end
