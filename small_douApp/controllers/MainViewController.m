//
//  MainViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MainViewController.h"
#import "SearchGoodsViewController.h"
#import "GoodsDetailViewController.h"
#import "MainHeadViewCell.h"
#import "MainTuiJianCell.h"
#import "MainAllCell.h"
#import "AreaViewController.h"
#import "GetMainData.h"
#import "ObjMainData.h"

@interface MainViewController()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_areaLabel;
    UITableView *_tableView;
    ObjMainData *_obj;
}
@end

@implementation MainViewController


-(void)initData
{
    GetMainData *act = [[GetMainData alloc]init];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        NSLog(@"sss");
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSDictionary *dic = [result try_get_data_with_dict];
            if (dic) {
                _obj = [[ObjMainData alloc] initWithDirectory:dic];
                [_tableView reloadData];
            }
        }
        else
        {
        
        }
        
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        NSLog(@"ss");

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}


-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-TabBarHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
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
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _areaLabel.font = [UIFont systemFontOfSize:size_font2];
    _areaLabel.textColor = [UIColor whiteColor];
    _areaLabel.text = @"新建商务大厦";
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 39, 10, 7)];
    imgV.image = [UIImage imageNamed:@"areaxiala"];
    [self.view addSubview:imgV];
    [areaBtn addSubview:_areaLabel];
    
    UILabel *navSearchView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(areaBtn.frame)+10, 30, ScreenW-30-areaBtn.frame.size.width, 24)];
    navSearchView.layer.cornerRadius = 12;
    navSearchView.layer.masksToBounds = YES;
    navSearchView.userInteractionEnabled = YES;
    navSearchView.text = @"       搜索商品";
    navSearchView.textColor = [UIColor colorWithRed:0.52 green:0.94 blue:0.36 alpha:1];
    navSearchView.font = [UIFont systemFontOfSize:size_font2];
    navSearchView.backgroundColor = [UIColor colorWithRed:0.37 green:0.76 blue:0.25 alpha:1];
    [self.navBar addSubview:navSearchView];
    UIImageView *bigV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, 31, 31)];
    bigV.image = [UIImage imageNamed:@"search_green"];
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
        AreaViewController *vc = [[AreaViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        //搜索商品
        SearchGoodsViewController *vc = [[SearchGoodsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
-(void)clickViewAllProducts
{
   //查看全部商品



}
#pragma mark----tableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        MainHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainHeadViewCell"];
        if (!cell) {
            cell = [[MainHeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainHeadViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    if (indexPath.row==1) {
        MainTuiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTuiJianCell"];
        if (!cell) {
            cell = [[MainTuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainTuiJianCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        [cell fillDataWithModel:_obj];
        [cell setBtnClick:^(NSUInteger tag) {
            
            GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
            vc.productId = [(ObjProduct *)_obj.arrJingpin[tag] guid];
            vc.product = (ObjProduct *)_obj.arrJingpin[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    if (indexPath.row==2) {
        MainAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainAllCell"];
        if (!cell) {
            cell = [[MainAllCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainAllCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell fillDataWithModel:_obj];
        [cell setBtnClick:^(NSUInteger tag) {
            GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
            vc.productId = [(ObjProduct *)_obj.arrProducts[tag] guid];
            vc.product = (ObjProduct *)_obj.arrProducts[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    if (indexPath.row==3) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 15, ScreenW-20, 40);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"查看全部商品" forState:UIControlStateNormal];
        [btn setTitleColor:color_font_gray1 forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
        [btn addTarget:self action:@selector(clickViewAllProducts) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 114.0*AutoPlus;
    }
    if (indexPath.row==1) {
        return 135.5;
    }
    if (indexPath.row==2) {
        CGFloat width = 147.0;
        CGFloat space = (ScreenW-2*width)/3;
        return 25+(_obj.arrProducts.count+1)/2*(158.0+space)+20;
    }
    return 75.0;
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 4;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
