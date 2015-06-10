//
//  ObjBase.h
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonObject.h"


/**
 *  数据模块的基础类
 */
@interface ObjBase : JsonObject<NSCoding,NSCopying>

/**
 *  对象的唯一id
 */
@property (nonatomic,retain)    id    guid;

/**
 *  对象类型
 */
@property (nonatomic,retain)    NSString *     class_type;

/**
 *  创建时间
 */
@property (nonatomic,retain)    NSString * created_at;

 /**
 *  更新时间
 */
@property (nonatomic,retain)    NSString * updated_at;


-(id) initWithDirectory:(NSDictionary *) data;

+(NSComparisonResult) comparisonWithGUID:(ObjBase *) left WithRight:(ObjBase *) right;
-(NSString *)   getGUIDWithString;

@end


@interface ObjBase (numericComparison)

/*
 按id从大到小排序(即先看到最新的内容)
 */
- (NSComparisonResult) compareNumericallyDESC:(ObjBase *) other;
- (NSComparisonResult) compareNumericallyASC:(ObjBase *) other;

@end
