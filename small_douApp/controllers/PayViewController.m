//
//  PayViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
{
    UIButton *_aliPayBtn;
    UIButton *_weChatBtn;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createContentView];
}
-(void)createContentView
{
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, 110.5)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView1];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 55, ScreenW, 0.5)];
    line1.backgroundColor = color_line2;
    [bgView1 addSubview:line1];
    
    for (int i=0; i<2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 55.5*i, 64, 55)];
        label.textColor = color_font_black;
        label.font = [UIFont systemFontOfSize:size_font2];
        label.text = i==0?@"订单编号":@"订单合计";
        [bgView1 addSubview:label];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW-260, 55.5*i, 250, 55)];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = i==0? color_font_gray2:color_font_red;
        detailLabel.font = [UIFont systemFontOfSize:size_font2];
        detailLabel.text = i==0?@"123456789123456789":@"￥226.60";
        [bgView1 addSubview:detailLabel];
    }
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame)+15, ScreenW, 110.5)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView2];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 55, ScreenW, 0.5)];
    line2.backgroundColor = color_line2;
    [bgView2 addSubview:line2];
    
    CGFloat imgH = 31.0;
    for (int i=0; i<2; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 12.0+55.5*i, imgH, imgH)];
        imgV.image = [UIImage imageNamed:i==0?@"wechat":@"alipay"];
        [bgView2 addSubview:imgV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+10, 55.5*i, 80, 55)];
        label.textColor = color_font_black;
        label.font = [UIFont systemFontOfSize:size_font2];
        label.text = i==0?@"微信支付":@"支付宝支付";
        [bgView2 addSubview:label];
        
        UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        choiceBtn.tag = i;
        choiceBtn.frame = CGRectMake(ScreenW-30, 17.5+55.5*i, 20, 20);
        choiceBtn.layer.cornerRadius = 10.0;
        choiceBtn.layer.masksToBounds = YES;
        choiceBtn.layer.borderWidth = 1.0;
        choiceBtn.layer.borderColor = color_line1.CGColor;
        [choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView2 addSubview:choiceBtn];
        if (i==0) {
            _weChatBtn = choiceBtn;
            _weChatBtn.selected = YES;
        }
        else
        {
            _aliPayBtn = choiceBtn;
        }
    }
    CGFloat payBtnW = 130.0;
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    payBtn.frame = CGRectMake((ScreenW-payBtnW)/2, CGRectGetMaxY(bgView2.frame)+25, payBtnW, 35);
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.backgroundColor = [UIColor colorWithRed:1 green:0.28 blue:0.13 alpha:1];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    payBtn.layer.cornerRadius = 3.0;
    [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
}
-(void)choiceBtnClick:(UIButton *)btn
{
    _weChatBtn.selected = NO;
    _aliPayBtn.selected = NO;
    btn.selected = YES;
}

-(void)payClick
{
    if (_weChatBtn.selected) {
     
        
    }
   else
    {


    }

}



-(void)configNavBar
{
    self.midTitle = @"支付订单";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
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
