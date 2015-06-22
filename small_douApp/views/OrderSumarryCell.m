//
//  OrderSumarryCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "OrderSumarryCell.h"

@implementation OrderSumarryCell
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
    UILabel *_statusLabel;
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
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(7, (55.0-imgVH)/2, imgVH, imgVH)];
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

   UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_titleLabel.frame)+7, 60, 12)];
    tipLabel.font = [UIFont systemFontOfSize:size_font4];
    tipLabel.textColor = color_font_gray1;
    tipLabel.text = @"订单状态：";
    [mainView addSubview:tipLabel];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tipLabel.frame)+3, CGRectGetMaxY(_titleLabel.frame)+7, 250, 14)];
    _statusLabel.font = [UIFont systemFontOfSize:size_font2];
    _statusLabel.textColor = color_font_green;
    _statusLabel.text = @"未支付";
    [mainView addSubview:_statusLabel];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 17.5, 14, 20)];
    imgV.image = [UIImage imageNamed:@"jinru"];
    [mainView addSubview:imgV];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
