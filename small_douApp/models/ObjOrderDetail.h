//
//  ObjOrderDetail.h
//  small_douApp
//
//  Created by zhongli on 15/8/14.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjOrder.h"

@interface ObjOrderDetail : ObjOrder

//存放商品数组
@property(nonatomic,strong)NSMutableArray *arrProducts;
@property(nonatomic,copy)NSString *total_fee;
@property(nonatomic,copy)NSString *store;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *location;

@property(nonatomic,strong)NSNumber *sex;
@property(nonatomic,copy)NSString *address;

@end
