//
//  ObjNewOrder.h
//  small_douApp
//
//  Created by 刘中礼 on 16/3/13.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "ObjBase.h"

@interface ObjNewOrder : ObjBase

@property(nonatomic,strong)NSNumber *addressId;
@property(nonatomic,copy)NSString   *code;
@property(nonatomic,copy)NSString   *ctime;
@property(nonatomic,copy)NSString   *message;
@property(nonatomic,strong)NSNumber   *refundedFee;
@property(nonatomic,copy)NSString   *status;
@property(nonatomic,strong)NSNumber   *totalFee;
@property(nonatomic,strong)NSNumber   *userId;


@end
