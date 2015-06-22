//
//  UserOtherCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/18.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserOtherCell.h"

@implementation UserOtherCell
{

    UILabel *_tipLabel;
    UIImageView *_imgV;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createContentView];
    }
    return self;
    
}

-(void)createContentView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 12.5, 30, 30)];
    [bgView addSubview:_imgV];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgV.frame)+10, 0, 100, 55)];
    _tipLabel.text = @"我的收藏";
    _tipLabel.font = [UIFont systemFontOfSize:size_font2];
    _tipLabel.textColor = color_font_black;
    [bgView addSubview:_tipLabel];
    
    UIImageView *nextImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 17.5, 14, 20)];
    nextImgV.image = [UIImage imageNamed:@"jinru"];
    [bgView addSubview:nextImgV];
}
-(void)setTitleString:(NSString *)titleString
{

    _tipLabel.text = titleString;
    if ([titleString isEqualToString:@"订单查询"]) {
        _imgV.image = [UIImage imageNamed:@"ddcx"];
    }
    if ([titleString isEqualToString:@"完成订单"]) {
        _imgV.image = [UIImage imageNamed:@"wcdd"];

    }
    if ([titleString isEqualToString:@"我的收藏"]) {
        _imgV.image = [UIImage imageNamed:@"wdsc"];

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
