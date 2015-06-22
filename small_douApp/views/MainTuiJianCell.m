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
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 130)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mainView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, ScreenW, 24)];
    label.text = @"精品推荐";
    label.font = [UIFont systemFontOfSize:size_font2];
    label.textColor = [UIColor colorWithRed:254.0/255 green:85.0/255 blue:58.0/255 alpha:1.0];
    [_mainView addSubview:label];
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 24.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line2;
        if (i==2) {
            line.frame = CGRectMake(0, 129.5, ScreenW, 0.5);
        }
        [_mainView addSubview:line];
    }
}
-(void)setDataArr:(NSArray *)dataArr
{
    for (int i=0; i<dataArr.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [_mainView addSubview:imageV];
        
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
