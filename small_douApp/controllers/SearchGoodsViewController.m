//
//  SearchGoodsViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/18.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "SearchGoodsViewController.h"

@interface SearchGoodsViewController ()<UITextFieldDelegate>
{
    CustomTextField *_tf;

}
@end

@implementation SearchGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
}

-(void)configNavBar
{
    self.rightBtn.hidden = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, 30, ScreenW-70, 25)];
    view.layer.cornerRadius = 12.5;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorWithRed:0.37 green:0.77 blue:0.25 alpha:1];
    [self.navBar addSubview:view];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    imgV.image = [UIImage imageNamed:@""];
    [view addSubview:imgV];
    
    _tf = [[CustomTextField alloc] initWithFrame:CGRectMake(25, 0, ScreenW-95, 25)];
    _tf.font = [UIFont systemFontOfSize:size_font2];
    _tf.placeholder = @"请输入搜索关键字";
    _tf.delegate = self;
    _tf.placeholderColor = color_font_green;
    _tf.textColor = [UIColor whiteColor];
    _tf.returnKeyType = UIReturnKeySearch;
    [view addSubview:_tf];
    UIImageView *bigV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, 31, 31)];
    bigV.image = [UIImage imageNamed:@"search_green"];
    [view addSubview:bigV];
}

-(void)createContentView
{
    




}

#pragma mark----textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

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
