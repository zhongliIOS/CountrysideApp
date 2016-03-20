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
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *tel;


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


//新参数
@property(nonatomic,strong)NSNumber *addressId;
@property(nonatomic,strong)NSNumber *userId;

@property(nonatomic,copy)NSString *ctime;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *refundedFee;
@property(nonatomic,copy)NSString *totalFee;


@end
