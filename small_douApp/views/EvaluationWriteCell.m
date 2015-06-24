//
//  EvaluationWriteCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "EvaluationWriteCell.h"

@implementation EvaluationWriteCell
{
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UITextView *_textView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createContentView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

-(void)createContentView
{
    CGFloat imageH = 160.0;
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, imageH)];
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-45, imageH-37, 35, 35)];
    _pageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _pageLabel.layer.cornerRadius = 17.5;
    _pageLabel.layer.masksToBounds = YES;
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont systemFontOfSize:size_font2];
    _pageLabel.text = @"1/5";
    [self.contentView addSubview:_pageLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(_mainScrollView.frame)+10, ScreenW-2*leftSpace, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:size_font2];
    _titleLabel.text = @"进口红心火龙果";
    _titleLabel.textColor = color_font_black;
    [self.contentView addSubview:_titleLabel];
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(_titleLabel.frame), ScreenW-2*leftSpace, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:size_font3];
    _detailLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
    _detailLabel.text = @"新鲜又好吃";
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame)+10, ScreenW, 215.0)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 55*i, ScreenW, 0.5)];
        line.backgroundColor = color_line2;
        [bgView addSubview:line];
        if (i==2) {
            line.frame = CGRectMake(0, 214.5, ScreenW, 0.5);
        }
        if (i!=2) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 55*i, 100, 55)];
            label.font = [UIFont systemFontOfSize:size_font2];
            label.textColor = color_font_black;
            label.text = i==0?@"订单评级":@"评价内容";
            [bgView addSubview:label];
        }
    }
    UIView *textBg = [[UITextView alloc] initWithFrame:CGRectMake(6, 105, ScreenW-12, 101)];
    textBg.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [bgView addSubview:textBg];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, ScreenW-22, 91)];
    [textBg addSubview:_textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.tintColor = [UIColor whiteColor];
    btn.frame = CGRectMake((ScreenW-118)/2, CGRectGetMaxY(bgView.frame)+16, 118, 35);
    btn.backgroundColor = color_btn_red;
    [btn setTitle:@"确认评价" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];

}

-(void)btnClick
{
    if (_CallBackClick) {
        _CallBackClick();
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
