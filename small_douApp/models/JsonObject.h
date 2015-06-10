//
//  JsonObject.h
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  有能力解析json格式的对象
 */
@interface JsonObject : NSObject


/**
 *  解析一个number 属性
 *
 *  @param data       数据源
 *  @param field_name 属性名
 *
 *  @return 返回解析的number对象，失败返回nil
 */
-(NSNumber *) ReadField_Number:(NSDictionary *) data
                WithFieldName:(NSString *) field_name;

/**
 *  解析一个字符串属性
 *
 *  @param data       数据源
 *  @param field_name 属性名
 *
 *  @return 返回解析的string对象，失败返回nil
 */
-(NSString *) ReadField_String:(NSDictionary *) data
                WithFieldName:(NSString *) field_name;

/**
 *  解析一个bool属性
 *
 *  @param data       数据源
 *  @param field_name 属性名
 *  @param out_result 输出参数，成功的情况下存放，解析结果
 *
 *  @return 解析成功返回true
 */
-(BOOL) ReadField_Bool:(NSDictionary *) data
         WithFieldName:(NSString *) field_name
             ResultOut:(BOOL*) out_result;

/**
 *  解析一个 NSDictionary 对象
 *
 *  @param data       数据源
 *  @param field_name 属性名
 *
 *  @return 返回解析的 NSDictionary 对象，失败返回nil
 */
-(NSDictionary *) ReadField_Dict:(NSDictionary *) data
                  WithFieldName:(NSString *) field_name;

/**
 *  解析一个 NSArray 对象
 *
 *  @param data       数据源
 *  @param field_name 属性名
 *
 *  @return 返回解析的 NSArray 对象,失败返回nil
 */
-(NSArray *) ReadField_Array:(NSDictionary *) data
              WithFieldName:(NSString *) field_name;



@end
