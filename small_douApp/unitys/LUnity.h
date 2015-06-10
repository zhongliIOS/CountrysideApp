//
//  LUnity.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//




#import <Foundation/Foundation.h>


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@interface LUnity : NSObject

/**
 *  计算一个字符串所需要的高度
 *
 *  @param str        需要计算的字符串
 *  @param width      宽度
 *  @param font       字体
 *  @param min_height 最小高度
 *
 *  @return 返回需要的高度，不小于 min_height
 */
+ (CGFloat)CalHeightByString:(NSString *) str  ForWidth : (CGFloat) width ForFont : (UIFont *) font MinHeight :(CGFloat) min_height;

/**
 *  <#Description#>
 *
 *  @param str        <#str description#>
 *  @param width      <#width description#>
 *  @param font       <#font description#>
 *  @param min_height <#min_height description#>
 *
 *  @return 返回字符串所需要的显示尺寸
 */
+(CGSize)CalSizeByString:(NSString *) str  ForWidth : (CGFloat) width ForFont : (UIFont *) font;

/**
 *  使用指定颜色创建指定大小的IMAGE图像
 *
 *  @param color 指定的颜色
 *  @param size  指定的大小
 *
 *  @return 返回创建后的 UIImage 对象
 */

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;


+ (UIImage *)Reduce:(UIImage *)image WithMaxSize:(CGSize) maxSize;

/**
 *  图片做等比缩放，不超过约定的最大大小
 *
 *  @param image 需要处理的图片
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)ReduceToDefaultSize:(UIImage *)image;

/**
 *  设置imageview 为圆形图片
 *
 *  @param roundedView 需要设置的 imageview
 */
+(void)setRoundedView:(UIImageView *)roundedView;

+(NSURL *) createTempImageUploadFile:(UIImage *) origin_upload_image;
+ (BOOL)string:(NSString *)string1  isEqualToString:(NSString *)string2;


+(NSURL *) createTempImageUploadFile:(UIImage *) origin_upload_image WithMaxSize:(CGSize) max_size;

+(NSString *) SendStringSince1970:(NSString *) sendTimeString;
+(NSString *) SendStringSince1970WithNumber:(NSNumber *) sendTime;
+(NSString *) timestampToString:(NSNumber *) value;
+(NSString *) timestampToStringAtDay:(NSNumber *) value;

+(UIView *) showErrorAlertViewWithMessage:(NSString *) msg Delegate:(id) delegate;
+(UIView *) showAlertViewTitle:(NSString *) title Message:(NSString *) msg Delegate:(id) delegate;
+(UIView *) showHttprequestErrorAlertViewWithDelegate:(id) delegate;
+(MBProgressHUD *) showHttprequestErrorHUDViewAtView:(UIView *) view;
+(MBProgressHUD *) showErrorHUDViewAtView:(UIView *) view WithTitle:(NSString *) title;

//解析工具
+(NSNumber *) ReadField_Number:(NSDictionary *) data
                 WithFieldName:(NSString *) field_name;

+(NSString *) ReadField_String:(NSDictionary *) data
                 WithFieldName:(NSString *) field_name;

+(BOOL) ReadField_Bool:(NSDictionary *) data
         WithFieldName:(NSString *) field_name
             ResultOut:(BOOL*) out_result;

+(NSDictionary *) ReadField_Dict:(NSDictionary *) data
                   WithFieldName:(NSString *) field_name;

+(NSArray *) ReadField_Array:(NSDictionary *) data
               WithFieldName:(NSString *) field_name;
+ (BOOL)string:(NSString *)string1  isEqualToString:(NSString *)string2;


@end
