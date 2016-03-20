//
//  CreateWxOrderAction.h
//  small_douApp
//
//  Created by 刘中礼 on 16/3/19.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface CreateWxOrderAction : MyActionGetBase
-(instancetype)initWithOrderId:(NSNumber *)orderId;

@end
