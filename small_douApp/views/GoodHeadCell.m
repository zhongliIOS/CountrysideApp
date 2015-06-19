//
//  GoodHeadCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodHeadCell.h"

@implementation GoodHeadCell
{



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
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-45, imageH-37, 35, 35)];
    _pageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _pageLabel.layer.cornerRadius = 17.5;
    _pageLabel.font = [UIFont systemFontOfSize:size_font2];
    _pageLabel.text = @"1/5";
    [self.contentView addSubview:_pageLabel];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
