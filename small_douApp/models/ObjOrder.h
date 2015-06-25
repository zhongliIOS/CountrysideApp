//
//  ObjOrder.h
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjBase.h"

@interface ObjOrder : ObjBase

@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *cuId;
@property(nonatomic,copy)NSString *desc;
/**
 *  订单生成时间
 */
@property(nonatomic,copy)NSString *doneTime;
/**
 *  订单完成时间
 */
@property(nonatomic,copy)NSString *genTime;
@property(nonatomic,copy)NSString *payTime;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *vCode;



@end
