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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:UIKeyboardDidHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}

-(void)configNavBar
{
    self.midTitle = @"评价订单";
    if (_isProduct) {
        self.midTitle = @"评价商品";
    }
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
    cell.isEvaPro = _isProduct;
    [cell setCallBackClick:^{
        NSLog(@"xixi");
        [self endEdit];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self endEdit];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEdit];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 490.0;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
}

//键盘弹起
-(void)showKeyboard:(NSNotification *)not{
    CGSize size = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _tableView.frame =CGRectMake(0,TopHeight, ScreenW,ScreenH-size.height-TopHeight);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView scrollToRowAtIndexPath: indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
//键盘隐藏
-(void)hideKeyboard{
    _tableView.frame =CGRectMake(0, TopHeight, ScreenW ,ScreenH-TopHeight);
}

-(void)endEdit
{
    [self.view endEditing:YES];
    [self.view endEditing:YES];

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
