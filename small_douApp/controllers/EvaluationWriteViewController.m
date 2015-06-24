//
//  EvaluationWriteViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "EvaluationWriteViewController.h"
#import "EvaluationWriteCell.h"

@interface EvaluationWriteViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;

}
@end

@implementation EvaluationWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)configNavBar
{
    self.midTitle = @"评价订单";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
}
-(void)createTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    EvaluationWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationWriteCell"];
    if (!cell) {
        cell = [[EvaluationWriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvaluationWriteCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 500.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
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
