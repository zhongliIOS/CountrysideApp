//
//  ObjectList.h
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ObjBase;

/**
 *  对象列表
 */
@interface ObjectList : NSObject


/**
 *  根据一个guid查找对象
 *
 *  @param guid 要查找的对象id
 *
 *  @return 返回找到的对象,不存在返回nil
 */
- (ObjBase *) Find:(NSNumber *) guid;



/**
 *  添加一个对象
 *
 *  @param elm 要添加的对象

 *  @return 成功返回true
 */
- (BOOL) Add:(ObjBase *)elm;

/**
 *  删除一个对象
 *
 *  @param guid 要删除的对象id
 */
- (void) Remove:(NSNumber*) guid;

/**
 *  根据对象id排序获得指定索引位置的一个对象
 *
 *  @param idx     索引位置，0-n
 *  @param is_desc 是否降序
 *
 *  @return 返回找到的对象id
 */
- (ObjBase *) GetIndexAt:(NSInteger) idx WithIsDESC:(BOOL) is_desc;

/**
 *  获得列表中id最大的一个对象
 *
 *  @return 返回guid最大的对象，列表空返回nil
 */
- (ObjBase *) GetMax;

/**
 *  获得列表中id最小的一个对象
 *
 *  @return 返回guid最小的对象，列表空返回nil
 */
- (ObjBase *) GetMin;

/**
 *  查找对象所在的索引位置
 *
 *  @param obj 要找的对象
 *
 *  @return 对象存在列表中返回所在位置 >= 0 , 不存在返回-1
 */
- (NSInteger)  GetIndexByObj:(ObjBase *) obj;
- (NSInteger)  GetIndexByGuId:(id) Id;

/**
 *  清空列表
 */
- (void) ClearAll;


/**
 *  获得列表个数
 *
 *  @return 返回列表个数
 */
- (NSUInteger) GetCount;


/**
 *  根据id大小排序后限制列表大小
 *
 *  @param limit_size 要限制的大小
 */
- (void) LimitSizeByGUID:(NSUInteger) limit_size;

/**
 *  将另一个列表和自己合并
 *
 *  @param otherList 需要合并的列表
 */
- (void) appendFromObjectList:(ObjectList *) otherList;

@end
