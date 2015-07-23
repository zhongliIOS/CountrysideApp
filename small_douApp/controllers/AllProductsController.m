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

@interface AllProductsController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger _currentPage;
    ObjectList *_productList;
}
@end

@implementation AllProductsController


-(void)initData
{
    GetProductListAction *act = [[GetProductListAction alloc] initWithTypeId:nil page:nil size:nil sort:nil name:nil];
    if (!act.isValid) {
        return;
    }
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
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
#pragma mark----tableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.backgroundColor = [UIColor clearColor];
            for (int i=0; i<3; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame =  CGRectMake(15, 10, 70, 30);
                btn.backgroundColor = [UIColor whiteColor];
                btn.layer.cornerRadius = 5.0;
                btn.layer.masksToBounds = YES;
                [cell.contentView addSubview:btn];
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

    
    return 50.0;
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
