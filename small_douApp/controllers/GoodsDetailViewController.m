//
//  GoodsDetailViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "TianXieOrderViewController.h"
#import "GoodHeadCell.h"
#import "GetGoodsDetailAction.h"
#import "EvaluationViewController.h"

@interface GoodsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    ObjProductDetail *_objProductDetail;
    //当前的个数
    NSInteger _currentNum;
}
@end

@implementation GoodsDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentNum = 1;
    [self initData];
    [self createNavBar];
    [self congigNavBar];
    [self createTableView];
    [self createContentView];
}

-(void)initData
{
    GetGoodsDetailAction *act = [[GetGoodsDetailAction alloc] initWithId:_productId];
    if (!act.isValid) {
        return;
    }
   [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
       MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
       if ([result get_error_code]==kServerErrorCode_OK) {
           NSDictionary *dic = [result try_get_data_with_dict];
           if (dic) {
               _objProductDetail = [[ObjProductDetail alloc] initWithDirectory:dic];
               [_tableView reloadData];
           }
       }
       else
           [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
       
   } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
       
   }];


}


-(void)rightButItemClick
{
    NSDictionary *dic ;
    if ([[MyInfo defaultMyInfo] guid]&&_productId) {
        dic = @{@"cuId":[[MyInfo defaultMyInfo] guid],@"proId":_productId};
    }
    else
    {
        return;
    }
    [self postWithBodyDic:dic andUrl:@"/products/collect" success:^(id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            [LUnity showErrorHUDViewAtView:self.view WithTitle:@"收藏成功"];
        }
        else
        {
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-44.0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

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
        btn.layer.cornerRadius = 3.0;
        btn.backgroundColor = i==1?[UIColor colorWithRed:0.93 green:0.45 blue:0.2 alpha:1]:[UIColor colorWithRed:0.98 green:0.27 blue:0.13 alpha:1];
        [btn setTitle:@[@"立即购买",@"加入购物车"][i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
        [bottomBg addSubview:btn];
        if (i==1) {
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+10, 7.5, 31, 28.5)];
            imgV.image = [UIImage imageNamed:@"gouwuche"];
            [bottomBg addSubview:imgV];
        }
    }
}


-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==0) {
      //buy
        ObjPostOrder *order = [[ObjPostOrder alloc]init];
        order.product = _objProductDetail;
        order.num = [NSNumber numberWithInteger:_currentNum];
        NSArray *arr = @[order];
        TianXieOrderViewController *vc = [[TianXieOrderViewController alloc]init];
        vc.productsArr = arr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
     //addShop
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *dic = @{@"cuId":[[MyInfo defaultMyInfo] guid],@"num":[NSNumber numberWithInteger:_currentNum],@"proId":_productId};
        [self postWithBodyDic:dic andUrl:@"/shoppingCarts/save" success:^(id responseObject, AFHTTPRequestOperation *operation) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
    }

}


#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodHeadCell"];
    if (!cell) {
        cell = [[GoodHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodHeadCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillDataWithModel:_objProductDetail];
    [cell setCallBackCount:^(NSInteger num) {
        _currentNum = num;
    }];
    [cell setCallBackEvaluation:^{
        EvaluationViewController *vc =[[EvaluationViewController alloc]init];
        vc.proId = _productId;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 400;
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
