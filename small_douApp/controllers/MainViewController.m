//
//  MainViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainViewController.h"
#import "SearchGoodsViewController.h"

@interface MainViewController()<UITextViewDelegate>
{
    UILabel *_areaLabel;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContentView];
    [self createNavBar];
    [self configNavBar];
}

-(void)createContentView
{
 
    
    
}




-(void)configNavBar
{
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = YES;
    
    UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    areaBtn.tag = 0;
    areaBtn.frame = CGRectMake(leftSpace, 20, 100, 44);
    [areaBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:areaBtn];
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    _areaLabel.font = [UIFont systemFontOfSize:size_font3];
    _areaLabel.textColor = [UIColor whiteColor];
    _areaLabel.text = @"新建商务大厦";
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(90, 35, 10, 10)];
    imgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imgV];
    [areaBtn addSubview:_areaLabel];
    
    UILabel *navSearchView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(areaBtn.frame)+10, 30, ScreenW-30-areaBtn.frame.size.width, 24)];
    navSearchView.layer.cornerRadius = 12;
    navSearchView.layer.masksToBounds = YES;
    navSearchView.userInteractionEnabled = YES;
    navSearchView.text = @"      搜索商品";
    navSearchView.textColor = [UIColor colorWithRed:0.52 green:0.94 blue:0.36 alpha:1];
    navSearchView.font = [UIFont systemFontOfSize:size_font3];
    navSearchView.backgroundColor = [UIColor colorWithRed:0.37 green:0.76 blue:0.25 alpha:1];
    [self.navBar addSubview:navSearchView];
    UIImageView *bigV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 6, 12, 12)];
    bigV.backgroundColor = [UIColor whiteColor];
    [navSearchView addSubview:bigV];
    
    UIButton *searchFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchFoodBtn.frame = navSearchView.bounds;
    searchFoodBtn.tag = 1;
    [searchFoodBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navSearchView addSubview:searchFoodBtn];
}


-(void)navBtnClick:(UIButton *)btn
{
    
    if (btn.tag == 0) {
        //选择小区
        
    }
    if (btn.tag == 1) {
        //搜索商品
        SearchGoodsViewController *vc = [[SearchGoodsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
