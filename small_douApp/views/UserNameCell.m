//
//  UserNameCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/18.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserNameCell.h"

@implementation UserNameCell
{
    UIImageView *_iconImgV;
    UILabel *_userNameLabel;
    UILabel *_phoneLabel;
    UIImageView *_levelImagV;
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

    UIImageView *bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 72)];
    bgImageV.backgroundColor = [UIColor lightGrayColor];
    bgImageV.image = [UIImage imageNamed:@"userBg.jpg"];
    [self.contentView addSubview:bgImageV];
    
    _iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 10, 52, 52)];
    _iconImgV.backgroundColor = [UIColor whiteColor];
    _iconImgV.layer.cornerRadius = 52.0/2;
    _iconImgV.layer.masksToBounds = YES;
    [bgImageV addSubview:_iconImgV];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgV.frame)+10, 20, 200, 20)];
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.font = [UIFont systemFontOfSize:size_font2];
    _userNameLabel.text = @"ihanqi";
    [bgImageV addSubview:_userNameLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgV.frame)+10, CGRectGetMaxY(_userNameLabel.frame), 200, 20)];
    _phoneLabel.textColor = [UIColor colorWithRed:0.67 green:0.86 blue:0.64 alpha:1];
    _phoneLabel.font = [UIFont systemFontOfSize:size_font3];
    _phoneLabel.text = @"";
    [bgImageV addSubview:_phoneLabel];
    
    UIImageView *nextImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 26, 14, 20)];
    nextImgV.image = [UIImage imageNamed:@"jinru"];
    [bgImageV addSubview:nextImgV];
 
    
}

-(void)fillDataWithModel:(MyInfo *)model
{
    if (!model.mobile) {
        return;
    }
    _phoneLabel.text = model.mobile;
    [_iconImgV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    _userNameLabel.text = model.nickname;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
