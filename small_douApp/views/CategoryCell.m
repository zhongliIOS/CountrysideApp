//
//  CategoryCell.m
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
{
    UIImageView *_iconImageV;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createContenView];
    }
    return self;

}

-(void)createContenView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mainView];
    
    _iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace, 7.5, 40, 40)];
    [mainView addSubview:_iconImageV];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageV.frame)+5, 10, ScreenW-80, 15)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"标题";
    _titleLabel.textColor = color_font_black;
    [mainView addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageV.frame)+5, CGRectGetMaxY(_titleLabel.frame)+5, ScreenW-80, 14)];
    _subTitleLabel.font = [UIFont systemFontOfSize:12];
    _subTitleLabel.text = @"描述";
    _subTitleLabel.textColor = color_font_gray2;
    [mainView addSubview:_subTitleLabel];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 17.5, 14, 20)];
    imgV.image = [UIImage imageNamed:@"jinru"];
    [mainView addSubview:imgV];
}

-(void)fillDataWith:(ObjCategory *)model
{
  if (!model) {
      return;
  }
    _titleLabel.text = model.name;
    _subTitleLabel.text = model.desc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
