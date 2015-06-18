//
//  CustomTextField.h
//  学学看
//
//  Created by 李康 on 14-6-5.
//  Copyright (c) 2014年 Alison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField
@property (nonatomic,strong) UIColor *placeholderColor;
@property (nonatomic,assign) NSInteger space;
@property (nonatomic,strong) UIFont *placeholderFont;
@property (nonatomic,assign) NSInteger maxLength;
-(void)LimitWithMaxLength:(NSInteger )length;
@end
