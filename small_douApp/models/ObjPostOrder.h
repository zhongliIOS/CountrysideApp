//
//  ObjPostOrder.h
//  small_douApp
//
//  Created by zhongli on 15/7/17.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

//生成订单的时候用

#import <Foundation/Foundation.h>

@interface ObjPostOrder : NSObject

@property(nonatomic,strong)ObjProductDetail *product;
@property(nonatomic,strong)NSNumber *num;

@end
