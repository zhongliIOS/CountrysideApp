//
//  DeleteOrderAction.h
//  small_douApp
//
//  Created by zhongli on 15/7/31.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface DeleteOrderAction : MyActionGetBase

-(instancetype)initWithOrderId:(NSNumber *)Id;


@end
