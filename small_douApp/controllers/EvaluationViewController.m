//
//  EvaluationViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationLevelCell.h"
#import "EvaluationContentCell.h"
#import "GetReviewsAction.h"

@interface EvaluationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;

}
@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}

-(void)initData
{
    GetReviewsAction *act = [[GetReviewsAction alloc] initWithProId:_proId];
    if (!act.isValid) {
        return;
    }
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            
        }
        else
        {
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        }
        
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        
    }];
}

-(void)configNavBar
{
    self.midTitle = @"评价";
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
    if (indexPath.row==0) {
        EvaluationLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationLevelCell"];
        if (!cell) {
            cell = [[EvaluationLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvaluationLevelCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        EvaluationContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationContentCell"];
        if (!cell) {
            cell = [[EvaluationContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvaluationContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 110.0;
    }
    return 150.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 2;
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
