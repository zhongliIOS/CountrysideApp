//
//  GoodsCarViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodsCarViewController.h"
#import "PayViewController.h"
#import "TianXieOrderViewController.h"
#import "LoginViewController.h"
#import "GoodCarCell.h"
#import "GetMyGoodsCarAction.h"

@interface GoodsCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILabel *_sumPriceLabel;
    CGFloat _sumPriceCount;
}
@end

@implementation GoodsCarViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
    [self createFootView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:NotificationUpdateMyInfo object:nil];
    
    MyInfo *m = [MyInfo defaultMyInfo];
    if (!m.tel) {
        //没有自动登陆成功
        LoginViewController *vc = [[LoginViewController alloc]init];
        
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        [self getData];
        
    }

}

-(void)getData
{
    MyInfo *m = [MyInfo defaultMyInfo];
    if (m.guid) {
        GetMyGoodsCarAction *act = [[GetMyGoodsCarAction alloc]initWithCustomId:m.guid];
        [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        
            
        } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
            
        }];
    }


}

-(void)createTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-TabBarHeight-44.0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)createFootView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(_tableView.frame), ScreenW+2, 44.0)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = color_line1.CGColor;
    [self.view addSubview:bgView];
    
    UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    choiceBtn.frame = CGRectMake(leftSpace, 14.5, 15, 15);
    choiceBtn.layer.cornerRadius = 7.5;
    choiceBtn.layer.masksToBounds = YES;
    choiceBtn.layer.borderWidth = 1.0;
    choiceBtn.layer.borderColor = color_line1.CGColor;
    [choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:choiceBtn];
    
    UILabel *qunxuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(choiceBtn.frame)+5, 0, 100, 44.0)];
    qunxuanlabel.text = @"全选";
    qunxuanlabel.font = [UIFont systemFontOfSize:size_font3];
    qunxuanlabel.textColor = color_font_gray1;
    [bgView addSubview:qunxuanlabel];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.tintColor = [UIColor whiteColor];
    buyBtn.frame = CGRectMake(ScreenW-95, 7.5, 85, 29);
    buyBtn.backgroundColor = color_btn_red;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    buyBtn.layer.cornerRadius = 3.0;
    buyBtn.layer.masksToBounds = YES;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:buyBtn];
    
    _sumPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(buyBtn.frame)-255, 0, 250, 44.0)];
    _sumPriceLabel.font = [UIFont systemFontOfSize:size_font3];
    _sumPriceLabel.textAlignment = NSTextAlignmentRight;
    _sumPriceLabel.textColor = color_font_gray1;
    _sumPriceLabel.attributedText = [self getAttStringWith:@"合计：2756.60"];
    [bgView addSubview:_sumPriceLabel];
    
}
-(void)initData
{
  

}
-(void)buyBtnClick
{
  //购买
    TianXieOrderViewController *vc = [[TianXieOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)choiceBtnClick:(UIButton *)btn
{
    //全选
    btn.selected = !btn.selected;
    
}

-(void)configNavBar
{
    self.midTitle = @"购物车";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = YES;
    
}



#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodCarCell"];
    if (!cell) {
        cell = [[GoodCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodCarCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCallBackSelected:^(BOOL isSelected) {
        
    }];
    [cell setCallBackCount:^(NSInteger num) {
        
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 55.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 12;
}




-(NSAttributedString *)getAttStringWith:(NSString *)string
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color_font_red range:NSMakeRange(3, string.length-3)];
//    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_OMNESLIGHT size:size_font4] range:NSMakeRange(0, 1)];
    return attributedStr;
}


-(void)leftButItemClick
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
