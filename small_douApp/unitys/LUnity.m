//
//  LUnity.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LUnity.h"

@implementation LUnity

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}
+ (BOOL)string:(NSString *)string1  isEqualToString:(NSString *)string2{
    if (string2 != nil) {
        if ([string1 isEqualToString:string2]||(string1 == nil && string2 == nil))
            return YES;
    }else{
        if (string1 == nil)
            return YES;
        return NO;
    }
    return NO;
}
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return img;
}

/*
 根据字符串计算出需要地高度
 */
+ (CGFloat)CalHeightByString:(NSString *) str  ForWidth : (CGFloat) width ForFont : (UIFont *) font MinHeight :(CGFloat) min_height
{
    CGSize constraint = CGSizeMake(width, 20000.0f);
    
    CGSize size = [str sizeWithFont:font constrainedToSize:constraint];
    
    CGFloat content_height = MAX(size.height, min_height);
    
    return content_height;
    
}

+(CGSize)CalSizeByString:(NSString *)str ForWidth:(CGFloat)width ForFont:(UIFont *)font
{
    
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    else
        size = [str sizeWithFont:font constrainedToSize:constraint];
    return size;
    
    
}
+ (UIImage *)ReduceToDefaultSize:(UIImage *)image
{
    
    UIImage *tempImage = [LUnity Reduce:image WithMaxSize:CGSizeMake(640, 960)];
    return [UIImage imageWithData:UIImageJPEGRepresentation(tempImage, 0.3)];
    
    //    return [LUnity Reduce:image WithMaxSize:CGSizeMake(1080, 1920)];
}

+ (UIImage *)Reduce:(UIImage *)image WithMaxSize:(CGSize) maxSize
{
    
    /*
     // 原图的宽高比
     CGFloat img_ratio = image.size.width / image.size.height;
     // 设定的最大大小的宽高比
     CGFloat maxImg_ratio = maxSize.width / maxSize.height;
     
     // 得到最接近最大SIZE的不改变原图宽高比的SIZE
     */
    
    // 从宽和高中取比值最小的比作为缩放标准
    //CGFloat x_ratio = maxSize.width / image.size.width;
    //CGFloat y_ratio = maxSize.height / image.size.height;
    //CGFloat ratio = x_ratio > y_ratio ? y_ratio : x_ratio;
    
    CGSize curSize = image.size;
    CGFloat ratio = 1.0f;
    while ( curSize.width > maxSize.width && curSize.height > maxSize.height )
    {
        curSize = image.size;
        CGFloat nextStep = 0.01;
        ratio = ratio -nextStep;
        curSize.width *= ratio;
        curSize.height *= ratio;
    }
    
    if( ratio < 1.0f )
    {
        // 比我们设定的最大值大的图片，我们才缩
        CGFloat save_width = image.size.width * ratio;
        CGFloat save_height = image.size.height * ratio;
        
        save_width = truncf(save_width);
        save_height = truncf(save_height);
        
        CGSize newSize = CGSizeMake(save_width, save_height);
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(newSize);
        // 绘制改变大小的图片
        [image drawInRect:CGRectMake(0, 0, save_width , save_height )];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    
    // 否则返回原图
    return image;
}
+(void)setRoundedView:(UIImageView *)roundedView
{
    CGFloat radius = roundedView.frame.size.width /2;
    roundedView.layer.cornerRadius = radius;
    roundedView.layer.masksToBounds = YES;
    roundedView.clipsToBounds = YES;
    roundedView.contentMode = UIViewContentModeScaleAspectFill;
    roundedView.layer.borderWidth = 0.5;
    roundedView.layer.borderColor = [UIColor whiteColor].CGColor;
}

+(NSString *)   timestampToString:(NSNumber *) value
{
    if( value == nil )
        return @"";
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: [value doubleValue] ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *) SendStringSince1970WithNumber:(NSNumber *) sendTime
{
    NSDate * now = [NSDate date];
    NSTimeInterval now_time = [now timeIntervalSince1970];
    NSTimeInterval send_time = [sendTime doubleValue];
    
    NSString * time_string = nil;
    if( now_time <= send_time )
    {
        time_string = [[NSString alloc] initWithFormat:@"一分钟前"];
    }
    else
    {
        NSTimeInterval secondsBetweenDates = now_time - send_time;
        
        if( secondsBetweenDates < 60 * 60 )
        {
            NSUInteger min = secondsBetweenDates / 60;
            time_string = [[NSString alloc] initWithFormat:@"%lu分钟前" , (unsigned long)  min];
        }
        else if( secondsBetweenDates < 60 * 60 * 24 )
        {
            NSUInteger hour = secondsBetweenDates / (60 * 60);
            time_string = [[NSString alloc] initWithFormat:@"%lu小时前" ,(unsigned long)   hour];
        }
        else if( secondsBetweenDates < 60 * 60 * 24 * 7 )
        {
            NSUInteger hour = secondsBetweenDates / (60 * 60 * 24);
            time_string = [[NSString alloc] initWithFormat:@"%lu天前" ,(unsigned long)   hour];
        }
        else
        {
            NSDate * sd = [[NSDate alloc] initWithTimeIntervalSince1970:send_time];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            time_string = [formatter stringFromDate:sd];
        }
    }
    
    return time_string;
}

+ (NSString *) SendStringSince1970:(NSString *) sendTimeString
{
    NSString * time_string = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * now = [NSDate date];
    NSDate * send_date = [formatter dateFromString:sendTimeString];
    
    NSTimeInterval now_time = [now timeIntervalSince1970];
    NSTimeInterval send_time = [send_date timeIntervalSince1970];
    
    if( now_time <= send_time )
    {
        time_string = [[NSString alloc] initWithFormat:@"one min ago"];
    }
    else
    {
        NSTimeInterval secondsBetweenDates = now_time - send_time;
        
        
        if( secondsBetweenDates < 60 * 60 )
        {
            NSUInteger min = secondsBetweenDates / 60;
            time_string = [[NSString alloc] initWithFormat:@"%lumin ago" , (unsigned long)  min];
        }
        else if( secondsBetweenDates < 60 * 60 * 24 )
        {
            NSUInteger hour = secondsBetweenDates / (60 * 60);
            time_string = [[NSString alloc] initWithFormat:@"%luhours ago" ,(unsigned long)   hour];
        }
        else
        {
            NSDate * sd = [[NSDate alloc] initWithTimeIntervalSince1970:send_time];
            [formatter setDateFormat:@"MM-dd"];
            time_string = [formatter stringFromDate:sd];
        }
    }
    
    return time_string;
}

+(NSString *)timestampToStringAtDay:(NSNumber *) value
{
    if( value == nil )
        return @"";
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: [value doubleValue] ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+(UIView *) showErrorAlertViewWithMessage:(NSString *) msg Delegate:(id) delegate
{
    return  [LUnity showAlertViewTitle:@"Oops!" Message:msg Delegate:delegate];
}


+(UIView *) showAlertViewTitle:(NSString *) title Message:(NSString *) msg Delegate:(id) delegate
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:delegate
                                               cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:nil];
    [alertView show];
    return alertView;
}

+(UIView *) showHttprequestErrorAlertViewWithDelegate:(id) delegate
{
    return [LUnity showAlertViewTitle:@"Oops!"
                              Message:@"request error"
                             Delegate:delegate];
}

+(MBProgressHUD *) showHttprequestErrorHUDViewAtView:(UIView *) view
{
    return [self showErrorHUDViewAtView:view WithTitle:@"send request faild."];
}

+(MBProgressHUD *) showErrorHUDViewAtView:(UIView *) view WithTitle:(NSString *) title
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
    return hud;
}
+(NSURL *) createTempImageUploadFile:(UIImage *) origin_upload_image
{
    NSURL *uploadFilePath = nil;
    
    NSString * random_string = [LUnity randomStringWithLength:32];
    NSString * strFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                              [NSString stringWithFormat: @"%@_%.0f.%@", random_string ,
                               [NSDate timeIntervalSinceReferenceDate] ,
                               @"jpg"]];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:strFilePath isDirectory:nil] )
    {
        [[NSFileManager defaultManager] removeItemAtPath:strFilePath error:nil];
    }
    
    NSData * binaryImageData = UIImageJPEGRepresentation(origin_upload_image , 0.7f);
    if( ![binaryImageData writeToFile:strFilePath atomically:YES] )
        return nil;
    uploadFilePath = [NSURL fileURLWithPath:strFilePath];
    return uploadFilePath;
}
+ (NSURL*) returenFileURL:(UIImage *)image{
    NSURL *url  = nil;
    
    NSString *random_str = [LUnity randomStringWithLength:10];
    
    NSString *ImagePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%.0f.jpg",random_str,[NSDate timeIntervalSinceReferenceDate]]];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    /**
     *  把图片写到指定路径
     */
    [data writeToFile:ImagePath atomically:YES];
    
    url = [NSURL fileURLWithPath:ImagePath];
    
    return url;
}
+(NSURL *) createTempImageUploadFile:(UIImage *) origin_upload_image WithMaxSize:(CGSize) max_size
{
    UIImage * resizedImage = [LUnity Reduce:origin_upload_image WithMaxSize:max_size];
    if( !resizedImage )
        return nil;
    
    NSURL *uploadFilePath = nil;
    
    NSString * random_string = [LUnity randomStringWithLength:32];
    NSString * strFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                              [NSString stringWithFormat: @"%@_%.0f.%@", random_string ,
                               [NSDate timeIntervalSinceReferenceDate] ,
                               @"jpg"]];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:strFilePath isDirectory:nil] )
    {
        [[NSFileManager defaultManager] removeItemAtPath:strFilePath error:nil];
    }
    
    NSData * binaryImageData = UIImageJPEGRepresentation(resizedImage , 0.7f);
    if( ![binaryImageData writeToFile:strFilePath atomically:YES] )
        return nil;
    
    uploadFilePath = [NSURL fileURLWithPath:strFilePath];
    return uploadFilePath;
}
+(BOOL) ReadField_Bool:(NSDictionary *) data
         WithFieldName:(NSString *) field_name
             ResultOut:(BOOL*) out_result
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return NO;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return NO;
    
    if( [field isKindOfClass:[NSString class]] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSNumber * temp = [num_format numberFromString:field];
        *out_result =  [temp boolValue];
        return YES;
    }
    else  if( [field isKindOfClass:[NSNumber class] ] )
    {
        NSNumber * temp = (NSNumber *)field;
        *out_result = [temp boolValue];
        return YES;
    }
    return FALSE;
}


+(NSNumber *) ReadField_Number:(NSDictionary *) data  WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSNumber class] ] )
    {
        return field;
    }
    else if( [field isKindOfClass:[NSString class]] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSNumber * ret = [num_format numberFromString:field];
        
        return ret;
    }
    return nil;
}

+(NSString *) ReadField_String:(NSDictionary *) data WithFieldName :(NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return @"";
    if( [field isKindOfClass:[NSNumber class] ] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSString * ret = [num_format stringFromNumber:field];
        
        return ret;
    }
    else if([field isKindOfClass:[NSString class]])
    {
        return field;
    }
    
    return @"";
}

+(NSDictionary *) ReadField_Dict:(NSDictionary *) data WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSDictionary class]] )
    {
        return field;
    }
    
    return nil;
}

+(NSArray *) ReadField_Array:(NSDictionary *) data WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSArray class]] )
    {
        return field;
    }
    
    return nil;
}



@end
