//
//  GoodOrderCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodOrderCell.h"

@implementation GoodOrderCell
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
    UILabel *_countLabel;
    UILabel *_yuanJiaLabel;
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
    CGFloat imgVH = 37;
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mainView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 54.5, ScreenW, 0.5)];
    line.backgroundColor = color_line2;
    [mainView addSubview:line];
    
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, (55.0-imgVH)/2, imgVH, imgVH)];
    _imageV.layer.cornerRadius = 3.0;
    _imageV.layer.masksToBounds = YES;
    _imageV.layer.borderWidth = 0.5;
    _imageV.layer.borderColor = color_line2.CGColor;
    [mainView addSubview:_imageV];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, (55.0-imgVH)/2, 250, 14)];
    _titleLabel.font = [UIFont systemFontOfSize:size_font2];
    _titleLabel.textColor = color_font_black;
    _titleLabel.text = @"特级红富士";
    [mainView addSubview:_titleLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-110, (55.0-16)/2, 100, 16)];
    _countLabel.font = [UIFont systemFontOfSize:size_font2];
    _countLabel.textColor = color_font_gray1;
    _countLabel.text = @"1个";
    _countLabel.textAlignment = NSTextAlignmentRight;
    [mainView addSubview:_countLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_titleLabel.frame)+7, 150, 12)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font4];
    _priceLabel.textColor = color_font_red;
    _priceLabel.text = @"￥100.00";
    [mainView addSubview:_priceLabel];
    
    _yuanJiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+10, CGRectGetMaxY(_titleLabel.frame)+7, 150, 12)];
    _yuanJiaLabel.font = [UIFont systemFontOfSize:size_font4];
    _yuanJiaLabel.textColor = color_font_red;
    _yuanJiaLabel.text = @"￥110.00";
    [mainView addSubview:_yuanJiaLabel];
    
}

-(void)fillDataWithModel:(ObjPostOrder *)obj
{
    if (!obj) {
        return;
    }
    ObjProduct *product = obj.product;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:product.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = product.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[product.price floatValue]];
    CGFloat price = [product.price floatValue];
    CGFloat discount = [product.discount floatValue];
    CGFloat noSalePrice = price/discount;
    _yuanJiaLabel.text = [NSString stringWithFormat:@"￥%.2f",noSalePrice];
    _countLabel.text = [NSString stringWithFormat:@"%@ %@",obj.num,product.mu];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
