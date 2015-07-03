//
//  MainHeadViewCell.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainHeadViewCell.h"

@implementation MainHeadViewCell

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
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ImageHeadHeight)];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mainScrollView];
    
    _pageView = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 95, ScreenW, 20)];;
    _pageView.numberOfPages = 3;
    _pageView.currentPage = 0;
    _pageView.userInteractionEnabled  = NO;
    _pageView.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageView.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self.contentView addSubview:_pageView];
    
}

-(void)fillDataWithModel:(ObjMainData *)model
{
    for (UIView *view in _mainScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    NSArray *arr = model.arrBanner;
    if (!arr) {
        return;
    }
    _pageView.numberOfPages = arr.count;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*i, 0, ScreenW, ImageHeadHeight)];
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@""]];
//        imgV.userInteractionEnabled = YES;
        imgV.tag = i;
//        [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgVclick:)]];
        [_mainScrollView addSubview:imgV];
        
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
