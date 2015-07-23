//
//  ProductCell.m
//  small_douApp
//
//  Created by zhongli on 15/7/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
    UILabel *_descLabel;
    UILabel *_priceLabel;
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
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7.5, 35, 35)];
    [self.contentView addSubview:_imageV];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+5, 7.5, ScreenW-50, 15)];
    _titleLabel.textColor = color_font_black;
    _titleLabel.font = [UIFont systemFontOfSize:size_font2];
    [self.contentView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+5, 7.5, ScreenW-50, 15)];
    _descLabel.font = [UIFont systemFontOfSize:size_font2];
    _titleLabel.textColor = color_font_gray1;
    [self.contentView addSubview:_descLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+5, 7.5, ScreenW-50, 15)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font2];
    _titleLabel.textColor = color_font_green;
    [self.contentView addSubview:_priceLabel];

}

-(void)fillDataWithModel:(ObjProduct *)obj
{
    if (!obj) {
        return;
    }
    _titleLabel.text = obj.name;
    _descLabel.text = obj.desc;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[obj.price floatValue]];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:obj.pic] placeholderImage:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
