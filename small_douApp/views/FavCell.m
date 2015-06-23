//
//  FavCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "FavCell.h"

@implementation FavCell
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
    UILabel *_priceLabel;

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
    

    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, (55.0-imgVH)/2, imgVH, imgVH)];
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
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_titleLabel.frame)+7, 150, 12)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font4];
    _priceLabel.textColor = color_font_red;
    _priceLabel.text = @"￥100.00";
    [mainView addSubview:_priceLabel];
    
    CGFloat AddBtnW = 85.0;
    UIButton *AddBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    AddBtn.frame = CGRectMake(ScreenW-34-AddBtnW,15, AddBtnW, 25);
    [AddBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [AddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AddBtn.backgroundColor = [UIColor colorWithRed:1 green:0.49 blue:0.22 alpha:1];
    AddBtn.titleLabel.font = [UIFont systemFontOfSize:size_font3];
    AddBtn.layer.cornerRadius = 3.0;
    [AddBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:AddBtn];
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-22, 17.5, 14, 20)];
    imgV.image = [UIImage imageNamed:@"jinru"];
    [mainView addSubview:imgV];
    
}
-(void)addClick
{


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
