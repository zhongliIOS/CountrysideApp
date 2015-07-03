//
//  ObjMainData.h
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//


@interface ObjMainData : NSObject

@property(nonatomic,strong)NSArray *arrBanner;
@property(nonatomic,strong)NSMutableArray *arrJingpin;
@property(nonatomic,strong)NSMutableArray *arrProducts;
-(id)initWithDirectory:(NSDictionary *)data;


@end
