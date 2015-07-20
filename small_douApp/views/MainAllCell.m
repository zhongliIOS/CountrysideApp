//
//  MainAllCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainAllCell.h"

@implementation MainAllCell
{
    UIView *_mainView;
    NSMutableArray *_viewsArr;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _viewsArr = [NSMutableArray array];
        [self createContentView];
    }
    return self;
}

-(void)createContentView
{
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 128.5)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mainView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, ScreenW, 24)];
    label.text = @"所有商品";
    label.font = [UIFont systemFontOfSize:size_font2];
    label.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    [_mainView addSubview:label];
    for (int i=0; i<2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 24.5*i, ScreenW, 0.5)];
        line.backgroundColor = color_line2;
        if (i==2) {
            line.frame = CGRectMake(0, 128, ScreenW, 0.5);
        }
        [_mainView addSubview:line];
    }
    
}
-(void)fillDataWithModel:(ObjMainData *)obj
{
    for (UIView *view in _viewsArr) {
        [view removeFromSuperview];
    }
    [_viewsArr removeAllObjects];
    if (!obj) {
        return;
    }
    CGFloat width = 147.0;
    CGFloat height = 158.0;
    CGFloat space = (ScreenW-2*width)/3;
    NSArray *productArr = obj.arrProducts;
    NSUInteger count = (productArr.count+1)/2;
    _mainView.frame = CGRectMake(0, 7, ScreenW, 25+count*(158.0+space)+20);
    for (int i=0; i<[productArr count]; i++) {
        ObjProduct *product = productArr[i];
        int hang = i/2;
        int lie = i%2;
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(space+lie*(width+space), 35+(space+height)*hang, width, height);
        [view addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        view.layer.cornerRadius = 1.0;
        view.layer.masksToBounds = YES;
        view.tag = i;
        view.layer.borderColor = color_line2.CGColor;
        view.layer.borderWidth = 0.5;
        [_mainView addSubview:view];
        [_viewsArr addObject:view];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        [view addSubview:imageV];
        for (int i=0; i<3; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 108, width, 20)];
            if (i==0) {
                label.text = product.name;
                label.textColor = color_font_black;
                label.font = [UIFont systemFontOfSize:size_font3];
            }else if (i==1)
            {
                label.text = product.desc;
                label.frame = CGRectMake(0, 125, width, 15);
                label.textColor = color_font_gray1;
                label.font = [UIFont systemFontOfSize:size_font5];
                
            }else
            {
                label.text = [NSString stringWithFormat:@"￥%.2f",[product.price  floatValue]];
                label.frame = CGRectMake(0, 138, width, 15);
                label.textColor = color_font_green;
                label.font = [UIFont systemFontOfSize:size_font4];
            }
            
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
    }
}
-(void)click:(UIButton *)btn
{

    if (_btnClick) {
        _btnClick(btn.tag);
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
