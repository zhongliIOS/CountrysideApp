//
//  GoodHeadCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodHeadCell.h"
#import "AddSubView.h"

@implementation GoodHeadCell
{
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UILabel *_productAreaLabel;
    UILabel *_priceLabel;
    UILabel *_frontSalePriceLabel;
    UILabel *_danWeiLabel;
    UILabel *_evaluationLabel;
    UILabel *_pingJILabel;
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

CGFloat  imageH = 160.0;

-(void)createContentView
{
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, imageH)];
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-45, imageH-37, 35, 35)];
    _pageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _pageLabel.layer.cornerRadius = 17.5;
    _pageLabel.layer.masksToBounds = YES;
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont systemFontOfSize:size_font2];
    _pageLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(_mainScrollView.frame)+10, ScreenW-2*leftSpace, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:size_font2];
    _titleLabel.text = @"进口红心火龙果";
    _titleLabel.textColor = color_font_black;
    [self.contentView addSubview:_titleLabel];
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(_titleLabel.frame), ScreenW-2*leftSpace, 20)];
    _detailLabel.font = [UIFont systemFontOfSize:size_font3];
    _detailLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
    _detailLabel.text = @"新鲜又好吃";
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
    
    
    UIView *pushBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame)+10, ScreenW, 98)];
    pushBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:pushBgView];
    
    for (int i=0; i<4; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 32.5*i, ScreenW, 0.5)];
        line.backgroundColor = i==0||i==3?color_line1:color_line2;
        [pushBgView addSubview:line];
    }
    NSArray *arr = @[@"59.25",@"产地：",@"送至："];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 32.5*i, 42, 32.5)];
        label.textColor = i==0?color_font_red:color_font_black;
        label.font = [UIFont systemFontOfSize:size_font2];
        label.text = arr[i];
        [pushBgView addSubview:label];
        if (i==0) {
            _priceLabel = label;
            _frontSalePriceLabel = [[UILabel alloc] init];
            _frontSalePriceLabel.font = [UIFont systemFontOfSize:size_font4];
            _frontSalePriceLabel.textColor = color_font_gray1;
            [pushBgView addSubview:_frontSalePriceLabel];
        }
        else if (i==1)
        {
            _productAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 32.5, 100, 32.5)];
            _productAreaLabel.font = [UIFont systemFontOfSize:size_font2];
            _productAreaLabel.textColor = color_font_gray1;
            [pushBgView addSubview:_productAreaLabel];
        
        }
        else if (i==2)
        {
            _addressBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            _addressBtn.frame = CGRectMake(CGRectGetMaxX(label.frame), 71, 100, 20);
            _addressBtn.layer.cornerRadius = 3.0;
            _addressBtn.layer.masksToBounds = YES;
            _addressBtn.layer.borderColor = color_btn_red.CGColor;
            _addressBtn.layer.borderWidth = 1.0;
            _addressBtn.titleLabel.font = [UIFont systemFontOfSize:size_font3];
            [_addressBtn setTitle:@"绿城桂花园" forState:UIControlStateNormal];
            [_addressBtn setTitleColor:color_font_black forState:UIControlStateNormal];
            [_addressBtn addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
            [pushBgView addSubview:_addressBtn];
        
        }
    }
    
    UIView *countBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pushBgView.frame)+10, ScreenW, 36)];
    countBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:countBgView];
    for (int i=0; i<2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line1;
        [countBgView addSubview:line];
    }
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0.5, 42, 35)];
    countLabel.font = [UIFont systemFontOfSize:size_font2];
    countLabel.textColor = color_font_black;
    countLabel.text = @"数量：";
    [countBgView addSubview:countLabel];

    
    AddSubView *customView = [[AddSubView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countLabel.frame), 7.5, 90, 20)];
    [customView setAddClick:^(NSInteger num) {
        if (_CallBackCount) {
            _CallBackCount(num);
        }
    }];
    [customView setSubClick:^(NSInteger num) {
        if (_CallBackCount) {
            _CallBackCount(num);
        }
    }];
    [countBgView addSubview:customView];
    
    
    _danWeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView.frame)+5, 0.5, 42, 35)];
    _danWeiLabel.font = [UIFont systemFontOfSize:size_font2];
    _danWeiLabel.textColor = color_font_black;
    _danWeiLabel.text = @"个";
    [countBgView addSubview:_danWeiLabel];
    
    UIButton *evaluationBg = [UIButton buttonWithType:UIButtonTypeCustom];
    evaluationBg.frame = CGRectMake(0, CGRectGetMaxY(countBgView.frame)+10, ScreenW, 36);
    evaluationBg.backgroundColor = [UIColor whiteColor];
    [evaluationBg addTarget:self action:@selector(viewEvaluationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:evaluationBg];
    for (int i=0; i<2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line1;
        [evaluationBg addSubview:line];
    }
    _evaluationLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0.5, 200, 35)];
    _evaluationLabel.font = [UIFont systemFontOfSize:size_font2];
    _evaluationLabel.textColor = color_font_black;
    _evaluationLabel.text = @"好评数：200";
    [evaluationBg addSubview:_evaluationLabel];
    
    _pingJILabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 0.5, 200, 35)];
    _pingJILabel.font = [UIFont systemFontOfSize:size_font2];
    _pingJILabel.textColor = color_font_black;
    _pingJILabel.text = @"用户评级";
    [evaluationBg addSubview:_pingJILabel];
}

-(void)fillDataWithModel:(ObjProductDetail *)model
{
    if (!model) {
        return;
    }
    NSArray *imagesArr = model.picsArr;
    if (imagesArr.count) {
        _pageLabel.text = [NSString stringWithFormat:@"1/%lu",imagesArr.count];
    }
    for (int i=0; i<imagesArr.count; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*i, 0, ScreenW, imageH)];
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [imgV sd_setImageWithURL:[NSURL URLWithString:imagesArr[i]] placeholderImage:[UIImage imageNamed:@""]];
        //        imgV.userInteractionEnabled = YES;
        imgV.tag = i;
        //        [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgVclick:)]];
        [_mainScrollView addSubview:imgV];
    }
    _titleLabel.text = model.name;
    CGSize detailSize = [LUnity CalSizeByString:model.desc ForWidth:ScreenW-2*leftSpace ForFont:[UIFont systemFontOfSize:size_font3]];
    _detailLabel.text = model.desc;
    _detailLabel.frame = CGRectMake(_detailLabel.frame.origin.x, _detailLabel.frame.origin.y, detailSize.width, detailSize.height);
    CGFloat price = [model.price floatValue];
    CGFloat dicount = [model.discount floatValue];
    CGFloat beforePrice = dicount==0?0:price/dicount;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
    CGSize priceSize = [LUnity CalSizeByString:_priceLabel.text ForWidth:200 ForFont:[UIFont systemFontOfSize:size_font2]];
    _priceLabel.frame = CGRectMake(_priceLabel.frame.origin.x, _priceLabel.frame.origin.y, priceSize.width, 32.5);
    
    _productAreaLabel.text = model.place;
    _evaluationLabel.text = [NSString stringWithFormat:@"好评数：%@",model.commentsize];
}
-(void)viewEvaluationClick
{
    if (_CallBackEvaluation) {
        _CallBackEvaluation();
    }

}
-(void)addressClick
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
