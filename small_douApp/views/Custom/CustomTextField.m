//
//  CustomTextField.m
//  学学看
//
//  Created by 李康 on 14-6-5.
//  Copyright (c) 2014年 Alison. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        
        // Initialization code
    }
    return self;
}
- (void)setSpace:(NSInteger)space{
    if (_space != space) {
        _space = space;
    }
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    if (_placeholderFont != placeholderFont) {
        _placeholderFont = placeholderFont;
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    if (_placeholderColor != placeholderColor) {
        _placeholderColor = placeholderColor;
    }
}
- (CGRect)textRectForBounds:(CGRect)bounds{
    return bounds;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return bounds;
}
//编辑的时候
- (CGRect)editingRectForBounds:(CGRect)bounds{
    [super editingRectForBounds:bounds];
    
    return CGRectMake(bounds.origin.x+_space, bounds.origin.y, bounds.size.width-_space, bounds.size.height);
    
}
- (void)drawTextInRect:(CGRect)rect{
    
    //    [self.textColor setFill];
    
    CGRect rec = CGRectMake(rect.origin.x+_space, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);
    [super drawTextInRect:rec];
    //    [[self text] drawInRect:rec withFont:self.font lineBreakMode:NSLineBreakByWordWrapping alignment:self.textAlignment];
}
- (void)drawPlaceholderInRect:(CGRect)rect{
    if (_placeholderColor) {
        [_placeholderColor setFill];
    }
    CGRect rec = CGRectMake(rect.origin.x+_space, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);

    if (_placeholderFont) {
    [[self placeholder] drawInRect:rec withFont:_placeholderFont lineBreakMode:NSLineBreakByWordWrapping alignment:self.textAlignment];
    }else{
        [[self placeholder] drawInRect:rec withFont:self.font lineBreakMode:NSLineBreakByWordWrapping alignment:self.textAlignment];
    }
}

-(void)LimitWithMaxLength:(NSInteger)length
{
    self.maxLength = length;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}
-(void)textFieldChanged:(NSNotification *)obj
{
    

    UITextField *textField = self;

    NSLog(@"%d",self.maxLength);
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        NSInteger count = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            if ((toBeString.length -count) >self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
                
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > self.maxLength) {
            textField.text = [toBeString substringToIndex:self.maxLength];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
