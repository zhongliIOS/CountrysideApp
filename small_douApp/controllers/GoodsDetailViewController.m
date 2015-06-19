//
//  GoodsDetailViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodHeadCell.h"
#import "GoodDescribleCell.h"
#import "GoodPushCell.h"

@interface GoodsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;

}
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self congigNavBar];
    [self createContentView];
}

-(void)congigNavBar
{
    self.midTitle = @"商品详情";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
    [self.rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;


}
-(void)createContentView
{
    CGFloat bottomH = 44.0;
    UIView *bottomBg = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-44, ScreenW, bottomH)];;
    bottomBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBg];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
    line.backgroundColor = color_line1;
    [bottomBg addSubview:line];
    
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tintColor = [UIColor whiteColor];
        btn.frame = CGRectMake(leftSpace+(120+leftSpace)*i, 8, 120, 28);
        btn.layer.cornerRadius = 2.0;
        btn.backgroundColor = i==1?[UIColor colorWithRed:0.93 green:0.45 blue:0.2 alpha:1]:[UIColor colorWithRed:0.98 green:0.27 blue:0.13 alpha:1];
        [btn setTitle:@[@"立即购买",@"加入购物车"][i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
        [bottomBg addSubview:btn];
    }
}


#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 4;
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
