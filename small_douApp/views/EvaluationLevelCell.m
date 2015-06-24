//
//  EvaluationLevelCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "EvaluationLevelCell.h"

@implementation EvaluationLevelCell

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
    UIView *levelBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 55.0)];
    levelBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:levelBgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, ScreenW, 0.5)];
    line.backgroundColor = color_line1;
    [self.contentView addSubview:line];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, 100, 55.0)];
    label.text = @"商品评级";
    label.textColor = color_font_black;
    label.font = [UIFont systemFontOfSize:size_font2];
    [levelBgView addSubview:label];
    NSArray *arr = @[@"全部",@"好评",@"中评",@"差评"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(leftSpace+69*i,69.5, 65, 26);
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.tag = i;
        btn.layer.borderColor = color_line2.CGColor;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:color_font_gray1 forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
        [btn setBackgroundImage:[LUnity imageWithColor:color_btn_green andSize:CGSizeMake(1, 1)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[LUnity imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        if (i==0) {
            btn.selected = YES;
        }
        
    }

}
-(void)click:(UIButton *)btn
{

    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *temp = (UIButton *)view;
            temp.selected = NO;
        }
    }
    btn.selected = YES;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
