//
//  GoodAddressCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodAddressCell.h"

@implementation GoodAddressCell

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
    NSArray *titleArr = @[@"手机号码",@"收获小区",@"商品金额",@"优惠金额"];
    for (int i=0; i<2; i++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+120*i, ScreenW, 110)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        for (int j=0; j<2; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 55*j, 100, 55)];
            label.textColor = color_font_black;
            label.font = [UIFont systemFontOfSize:size_font2];
            label.text = titleArr[i*2+j];
            [bgView addSubview:label];
        }
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
