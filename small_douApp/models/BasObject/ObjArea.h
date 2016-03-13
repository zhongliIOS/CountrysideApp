//
//  ObjArea.h
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjBase.h"

@interface ObjArea : ObjBase

@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *storeId;
/**
 *  服务点位置
 */
@property(nonatomic,copy)NSString *spLocation;
/**
 *  服务点名称
 */
@property(nonatomic,copy)NSString *spName;
/**
 *  负责人ID
 */
@property(nonatomic,copy)NSString *staffId;




@end
