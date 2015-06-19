//
//  GoodDescribleCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodDescribleCell.h"

@implementation GoodDescribleCell
{
    UILabel *_titleLabel;
    UILabel *_detailLabel;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createContentView];
        self.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
    }
    return self;
    
}

-(void)createContentView
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, leftSpace, ScreenW-2*leftSpace, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:size_font1];
    _titleLabel.textColor = color_font_black;
    [self.contentView addSubview:_titleLabel];
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, leftSpace, ScreenW-2*leftSpace, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:size_font2];
    _detailLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
