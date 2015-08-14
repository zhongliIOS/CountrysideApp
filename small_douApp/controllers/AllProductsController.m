//
//  AllProductsController.m
//  small_douApp
//
//  Created by zhongli on 15/7/20.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AllProductsController.h"
#import "ProductCell.h"
#import "GetProductListAction.h"
#import "GoodsDetailViewController.h"

@interface AllProductsController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger _currentPage;
    ObjectList *_productList;
    UIButton *_zongheBtn;
    UIButton *_xiaoliangBtn;
    UIButton *_pinhjiBtn;
}
@end

@implementation AllProductsController


-(void)initData
{
    NSNumber *guid;
    if (_categoryObj) {
        guid = _categoryObj.guid;
    }
    GetProductListAction *act = [[GetProductListAction alloc] initWithTypeId:guid page:[NSNumber numberWithInteger:_currentPage] size:sizecount sort:sortDesc name:nil];
    if (!act.isValid) {
        return;
    }
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        [_tableView.infiniteScrollingView stopAnimating];
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSArray *arr = [[result try_get_data_with_dict] objectForKey:@"rows"];
            if (arr) {
                for (NSDictionary *dic in arr) {
                    ObjProduct *obj = [[ObjProduct alloc] initWithDirectory:dic];
                    [_productList Add:obj];
                }
                [_tableView reloadData];
            }
        }
        else
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        [_tableView.infiniteScrollingView stopAnimating];

    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _productList = [[ObjectList alloc]init];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)configNavBar
{
    self.midTitle = @"全部商品";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = NO;
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addInfiniteScrollingWithActionHandler:^{
        _currentPage++;
        [self initData];
    }];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

-(void)sortBtnClick:(UIButton *)btn
{
    btn.selected = YES;
    if (_zongheBtn==btn) {
        _pinhjiBtn.selected = NO;
        _xiaoliangBtn.selected = NO;
    }
    if (_xiaoliangBtn==btn) {
        _zongheBtn.selected = NO;
        _pinhjiBtn.selected = NO;
    }
    if (_pinhjiBtn==btn) {
        _zongheBtn.selected = NO;
        _xiaoliangBtn.selected = NO;
    }
}

#pragma mark----tableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.backgroundColor = [UIColor clearColor];
            NSArray *arr = @[@"综合",@"销量",@"评级"];
            for (int i=0; i<3; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame =  CGRectMake(10+75*i, 12.5, 65, 25);
                [btn setBackgroundImage:[LUnity imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
                [btn setBackgroundImage:[LUnity imageWithColor:color_btn_green andSize:CGSizeMake(1, 1)] forState:UIControlStateSelected];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn setTitleColor:color_font_gray1 forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:arr[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 5.0;
                btn.layer.masksToBounds = YES;
                [cell.contentView addSubview:btn];
                if (i==0) {
                    _zongheBtn = btn;
                    _zongheBtn.selected = YES;
                }
                if (i==1) {
                    _xiaoliangBtn = btn;
                }
                if (i==2) {
                    _pinhjiBtn = btn;
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
        if (!cell) {
            cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillDataWithModel:(ObjProduct *)[_productList GetIndexAt:indexPath.row-1 WithIsDESC:YES]];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50.0;
    }

    return 77.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ObjProduct *obj = (ObjProduct *)[_productList GetIndexAt:indexPath.row-1 WithIsDESC:YES];
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
    vc.productId = [obj guid];
    vc.product = obj;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_productList GetCount]+1;
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
