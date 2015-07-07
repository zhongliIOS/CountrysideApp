//
//  MainTuiJianCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainTuiJianCell.h"

@implementation MainTuiJianCell
{

    UIView *_mainView;
    UIScrollView *_scrollView;

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
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 128.5)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mainView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, ScreenW, 24)];
    label.text = @"精品推荐";
    label.font = [UIFont systemFontOfSize:size_font2];
    label.textColor = [UIColor colorWithRed:254.0/255 green:85.0/255 blue:58.0/255 alpha:1.0];
    [_mainView addSubview:label];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, ScreenW, 103)];
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.pagingEnabled = YES;
    [_mainView addSubview:_scrollView];
    
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 24.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line2;
        if (i==2) {
            line.frame = CGRectMake(0, 128, ScreenW, 0.5);
        }
        [_mainView addSubview:line];
    }
}

-(void)fillDataWithModel:(ObjMainData *)model
{
    if (!model) {
        return;
    }
    
    for (UIView *view in _scrollView.subviews) {
        //清楚之前创建的
        [view removeFromSuperview];
    }
    
    CGFloat imgW = 80.0;
    CGFloat imgH = 50.0;
    CGFloat elemtWidth = 105.0;
    CGFloat space = (elemtWidth-imgW)/2;
    NSArray *arr = model.arrJingpin;
    if (!arr) {
        return;
    }
    NSUInteger arrCount = arr.count;
    _scrollView.contentSize = CGSizeMake(elemtWidth*arrCount+0.5*(arrCount-1), 0);

    for (int i=0; i<arrCount; i++) {
        ObjProduct *obj = arr[i];
        if (obj.pics) {
            NSArray *arr = [obj.pics componentsSeparatedByString:@";"];
        }
        NSString *firstImageUrl = arr[0];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(space+(2*space+0.5+imgW)*i, 10, imgW, imgH)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:imageV];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((elemtWidth+0.5)*i, CGRectGetMaxY(imageV.frame)+10, elemtWidth, 10)];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = @"特级红富士";
        label1.textColor = color_font_black;
        label1.font = [UIFont systemFontOfSize:size_font5];
        [_scrollView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((elemtWidth+0.5)*i, CGRectGetMaxY(label1.frame)+5, elemtWidth, 12)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = color_green;
        label2.text = @"￥59.0";
        label2.font = [UIFont systemFontOfSize:size_font4];
        [_scrollView addSubview:label2];

        if (i!=(arrCount-1)) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(elemtWidth+(elemtWidth+0.5)*i, 14, 0.5, 70)];
            line.backgroundColor = color_line2;
            [_scrollView addSubview:line];
        }
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = CGRectMake((elemtWidth+0.5)*i, 0, elemtWidth, 103);
        [clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:clickBtn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (_btnClick) {
        _btnClick(btn.tag);
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
