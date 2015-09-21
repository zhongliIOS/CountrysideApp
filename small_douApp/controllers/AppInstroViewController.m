


//
//  AppInstroViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/8/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AppInstroViewController.h"

@interface AppInstroViewController ()

@end

@implementation AppInstroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
}
-(void)configNavBar
{
    self.midTitle = @"关于我们";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
}
-(void)createContentView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, 120)];
    label.text = @"       介绍：田园小兜是安徽铈闰吕鑫商贸有限责任公司运营的合肥本地O2O蔬菜水果等商品配送平台。提供优质的新鲜蔬菜水果配送服务及多元化的产品销售服务。";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:size_font1];
    label.textColor = color_font_black;
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
