//
//  ObjProduct.h
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjBase.h"

@interface ObjProduct : ObjBase

@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *discount;
@property(nonatomic,copy)NSString *mu;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *number;

@property(nonatomic,copy)NSString *pics;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,strong)NSNumber *proId;
@property(nonatomic,strong)NSNumber *total_fee;

@property(nonatomic,copy)NSString *place;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *sl;
@property(nonatomic,copy)NSString *typeId;

@property(nonatomic,copy)NSString *num;


@end
