//
//  GoodCarCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodCarCell.h"
#import "AddSubView.h"

@implementation GoodCarCell
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
    AddSubView *_customView;
    UIButton *_choiceBtn;
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
    
    _choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _choiceBtn.frame = CGRectMake(leftSpace, 17.5, 20, 20);
    _choiceBtn.layer.cornerRadius = 7.5;
    _choiceBtn.layer.masksToBounds = YES;
    
    [_choiceBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        [_choiceBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_choiceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:_choiceBtn];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_choiceBtn.frame)+10, (55.0-imgVH)/2, imgVH, imgVH)];
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
    
    _customView = [[AddSubView alloc] initWithFrame:CGRectMake(ScreenW-90, 17.5, 85, 25)];
    [_customView setAddClick:^(NSInteger num) {
        if (_CallBackCount) {
            _CallBackCount(num);
        }
    }];
    [_customView setSubClick:^(NSInteger num) {
        if (_CallBackCount) {
            _CallBackCount(num);
        }
    }];
    [mainView addSubview:_customView];
}

-(void)fillDataWithModel:(ObjGoodCar *)obj
{
    if (!obj) {
        return;
    }
    [_imageV sd_setImageWithURL:[NSURL URLWithString:obj.pic] placeholderImage:nil];
    _titleLabel.text = obj.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[obj.price floatValue]];
    _customView.currentCount = [obj.num integerValue];
    _choiceBtn.selected = obj.isSelected;
}

-(void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (_CallBackSelected) {
        _CallBackSelected(btn.selected);
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
