//
//  AddSubView.m
//  small_douApp
//
//  Created by zhongli on 15/6/17.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AddSubView.h"

@implementation AddSubView
{
    NSInteger _currentCount;
    UILabel *_label;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentCount = 1;
        [self createContentView:frame];
    }
    return self;
}

-(void)createContentView:(CGRect )frame
{
    CGSize selfSize = frame.size;
    //创建两个按钮
    NSArray *imgArr = @[@"jian",@"jia"];
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((selfSize.width-35)*i, 0, 35, selfSize.height);
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //中间的_label
    _label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, selfSize.width-2*35, selfSize.height)];
    _label.text = [NSString stringWithFormat:@"%lu",_currentCount];
    _label.textColor = color_font_black;
    _label.font = [UIFont systemFontOfSize:size_font4];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
}

-(void)click:(UIButton *)btn
{
    if (btn.tag == 0) {
       //减
        _currentCount--;
        if (_currentCount==0) {
            _currentCount=1;
        }
        _subClick(_currentCount);
        
    }
    if (btn.tag == 1) {
        _currentCount++;
        _addClick(_currentCount);
       //加
    }
    _label.text = [NSString stringWithFormat:@"%lu",_currentCount];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
