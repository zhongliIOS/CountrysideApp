//
//  MyFavViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyFavViewController.h"
#import "GetFavoritesAction.h"
#import "DeleteCollectAction.h"
#import "GoodsDetailViewController.h"
#import "FavCell.h"

@interface MyFavViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    ObjectList *_objectList;
}
@end

@implementation MyFavViewController


-(void)downLoadData
{
    GetFavoritesAction *act = [[GetFavoritesAction alloc]initWithCustomerId:[[MyInfo defaultMyInfo] guid]];
    if (!act.isValid) {
        return;
    }
    
    [_objectList ClearAll];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSArray *arr = [result try_get_data_with_array];
            for (int i=0; i<arr.count; i++) {
                NSDictionary *dic = arr[i];
                ObjProduct *obj = [[ObjProduct alloc]initWithDirectory:dic];
                [_objectList Add:obj];
            }
            [_tableView reloadData];
        }
        else
        {
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        }
        
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        
    }];
    
}

-(void)DeleteWithGuid:(NSNumber *)num
{
    DeleteCollectAction *act = [[DeleteCollectAction alloc] initWithCollectId:num];
    if (!act.isValid) {
        return;
    }
   [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
       MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
       [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
       if ([result get_error_code]==kServerErrorCode_OK) {
           [self downLoadData];
       }
       
   } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
       
   }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self downLoadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _objectList = [[ObjectList alloc]init];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
}
-(void)configNavBar
{
    self.midTitle = @"我的收藏";
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
    FavCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavCell"];
    if (!cell) {
        cell = [[FavCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillDataWithModel:(ObjProduct *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES]];
    [cell setDeleteClick:^{
        ObjProduct *product = (ObjProduct *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES];
        [self DeleteWithGuid:product.guid];
    }];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ObjProduct *product = (ObjProduct *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES];
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
    vc.productId = product.proId;
    [self.navigationController pushViewController:vc animated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [_objectList GetCount];
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
