//
//  GoodAddressCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodAddressCell.h"

@implementation GoodAddressCell
{
    UILabel *_phoneDetailLabel;
    UILabel *_areaDetailLabel;
    UILabel *_priceDetailLabel;
    UILabel *_salePriceDetaiLabel;
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
    NSArray *titleArr = @[@"手机号码",@"收货小区",@"商品金额",@"优惠金额"];
    for (int i=0; i<2; i++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+120.5*i, ScreenW, 110.5-55*i)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        for (int j=0; j<2; j++) {
            if (i==1&&j==1) {
                break;
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 55*j, 100, 55)];
            label.textColor = color_font_black;
            label.font = [UIFont systemFontOfSize:size_font2];
            label.text = titleArr[i*2+j];
            [bgView addSubview:label];
            
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW-210, 55*j, 200, 55)];
            detailLabel.font = [UIFont systemFontOfSize:size_font2];
            detailLabel.text = @"";
            detailLabel.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:detailLabel];
            detailLabel.textColor = i==0?color_font_gray1:color_font_red;
            int c = i*2+j;
            if (c==0) {
                _phoneDetailLabel = detailLabel;
            }else if (c==1)
            {
                _areaDetailLabel = detailLabel;
                _areaDetailLabel.frame = CGRectMake(ScreenW-240, 55*j, 200, 55);
                detailLabel.userInteractionEnabled = YES;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0, 55*j, ScreenW, 55);
                [btn addTarget:self action:@selector(clickArea) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:btn];
                UIImageView *nextImageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW-30, 19,20 , 17)];
                nextImageV.image=[UIImage imageNamed:@"xiala"];
                [btn addSubview:nextImageV];
            }
            else if (c==2)
            {
                _priceDetailLabel = detailLabel;
            }
            else
            {
                _salePriceDetaiLabel = detailLabel;
            }
            
        }
        for (int j=0; j<3; j++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 55*j, ScreenW, 0.5)];
            line.backgroundColor = color_line2;
            [bgView addSubview:line];
        }
    }
    
}


-(void)fillDataWithModel:(NSArray *)arr
{
    MyInfo *user = [MyInfo defaultMyInfo];
    _phoneDetailLabel.text = user.tel;
    CGFloat allPrice = 0.0;
    CGFloat salePrice = 0.0;
    for (ObjPostOrder *obj in arr) {
        ObjProductDetail *product = obj.product;
        allPrice += [product.price floatValue]*[obj.num integerValue];
        salePrice +=[product.price floatValue]/[product.discount floatValue]*[obj.num integerValue];
    }
    _priceDetailLabel.text = [NSString stringWithFormat:@"￥%.2f",allPrice];
//    _salePriceDetaiLabel.text = [NSString stringWithFormat:@"-￥%.2f",salePrice-allPrice];
}

-(void)setAddressId:(NSString *)addressId
{
    AreaInfo *areaInfo = [AreaInfo areaInfo];
    _areaDetailLabel.text = [areaInfo searchAreaNameWithId:addressId];
}
-(void)clickArea
{
    if (_areaClick) {
        _areaClick();
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
