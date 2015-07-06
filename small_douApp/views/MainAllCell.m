//
//  MainAllCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainAllCell.h"

@implementation MainAllCell
{
    UIView *_mainView;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createContentView];
    }
    return self;
}

-(void)createContentView
{
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 128.5)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mainView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, ScreenW, 24)];
    label.text = @"所有商品";
    label.font = [UIFont systemFontOfSize:size_font2];
    label.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    [_mainView addSubview:label];
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 24.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line2;
        if (i==2) {
            line.frame = CGRectMake(0, 128, ScreenW, 0.5);
        }
        [_mainView addSubview:line];
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
