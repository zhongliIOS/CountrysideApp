//
//  TianXieOrderViewController.m
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "TianXieOrderViewController.h"
#import "PayViewController.h"
#import "GoodOrderCell.h"
#import "GoodAddressCell.h"


@interface TianXieOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{

   UITableView *_tableView;
    UILabel *_priceLabel;
    NSDictionary *_payDic;
    NSString *_currentAreaId;
    NSString *_tempAreaId;
    ObjectList *_areaList;
    
    UIPickerView *_pickView;
    UIView *_cancelAndCompleteView;

}
@end

@implementation TianXieOrderViewController


-(void)initData
{
    _currentAreaId = [[MyInfo defaultMyInfo] areaId];
    _tempAreaId = _currentAreaId;
    _areaList = [[AreaInfo areaInfo] dataList];
}

-(void)setOrder:(ObjOrder *)order
{
    if (order) {
        _order = order;
    }
    if ([_order.status isEqualToString:OrderStatusWaitPay]) {
        
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
    [self createFootView];
    [self createPickView];
}

-(void)createPickView
{
    CGFloat height = ISiPhone4?130.0:150;
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,ScreenH-height, ScreenW, height)];
    _pickView.delegate = self;
    _pickView.backgroundColor  = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    _pickView.showsSelectionIndicator = YES;
    _pickView.dataSource = self;
    _pickView.hidden = YES;
    [_pickView selectRow:[_areaList GetIndexByGuId:_currentAreaId] inComponent:0 animated:NO];
    [self.view addSubview:_pickView];
    
    _cancelAndCompleteView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-height-40, ScreenW, 40)];
    _cancelAndCompleteView.backgroundColor = [UIColor whiteColor];
    _cancelAndCompleteView.hidden = YES;
    [self.view addSubview:_cancelAndCompleteView];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((ScreenW-60)*i, 0, 60, 40);
        [btn setTitle:@[@"取消",@"完成"][i] forState:UIControlStateNormal];
        [btn setTitleColor:color_font_black forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:size_font1];
        btn.tag = i;
        [btn addTarget:self action:@selector(pickCancelSureClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelAndCompleteView addSubview:btn];
    }
}
-(void)configNavBar
{
    self.midTitle = @"填写订单";
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
    
}
-(NSString *)getStringWithArr:(NSArray *)arr
{
    CGFloat allPrice = 0.0;
    for (ObjPostOrder *obj in arr) {
        ObjProductDetail *product = obj.product;
        allPrice += [product.price floatValue]*[obj.num integerValue];
    }
    return  [NSString stringWithFormat:@"实付款￥%.2f",allPrice];

}
-(void)createFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-45.0, ScreenW, 45.0)];
    footView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1.0)];
    line.backgroundColor = color_line2;
    [footView addSubview:line];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 1, 200, 44.0)];
    _priceLabel.font = [UIFont systemFontOfSize:size_font2];
    _priceLabel.textColor = color_font_red;
    _priceLabel.text = [self getStringWithArr:_productsArr];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyBtn.tintColor = [UIColor whiteColor];
    buyBtn.frame = CGRectMake(ScreenW-128, 5, 118, 35);
    buyBtn.backgroundColor = color_btn_red;
    
    [buyBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:size_font2];
    buyBtn.layer.cornerRadius = 3.0;
    buyBtn.layer.masksToBounds = YES;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:buyBtn];
    [footView addSubview:_priceLabel];
    
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, ScreenH-TopHeight-45.0)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)buyBtnClick
{
    MyInfo *user = [MyInfo defaultMyInfo];
    NSMutableArray *arr = [NSMutableArray array];
    for (ObjPostOrder *obj in _productsArr) {
        NSDictionary *dic = @{@"proId":obj.product.guid,@"num":obj.num};
        [arr addObject:dic];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dataDic = @{@"list":arr,@"cuId":user.guid,@"tel":user.tel,@"area":_currentAreaId};
    [self postWithBodyDic:dataDic andUrl:@"/orders/submit" success:^(id responseObject, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            _payDic = [result try_get_data_with_dict];
            ObjOrder *order = [[ObjOrder alloc] initWithDirectory:_payDic];
            PayViewController *vc = [[PayViewController alloc] init];
            vc.orderObj = order;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

#pragma mark----tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=_productsArr.count) {
        GoodOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodOrderCell"];
        if (!cell) {
            cell = [[GoodOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillDataWithModel:(ObjPostOrder *)_productsArr[indexPath.row] ];
        
        return cell;
    }
    else
    {
        GoodAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodAddressCell"];
        if (!cell) {
            cell = [[GoodAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodAddressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillDataWithModel:_productsArr];
        cell.addressId = _currentAreaId;
        [cell setAreaClick:^{
            _pickView.hidden = NO;
            _cancelAndCompleteView.hidden = NO;
        }];
        return cell;
    
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==_productsArr.count) {
        return 235.0;
    }
    
    return 55.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _productsArr.count+1;
}
#pragma mark------pickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_areaList GetCount];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [(ObjArea *)[_areaList GetIndexAt:row WithIsDESC:YES] name];
    NSString *string = [[NSString alloc]initWithFormat:@"%@",title];
    return string;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _tempAreaId = [(ObjArea *)[_areaList GetIndexAt:row WithIsDESC:YES] guid] ;
}

-(void)pickCancelSureClick:(UIButton *)btn
{
    
    _pickView.hidden = YES;
    _cancelAndCompleteView.hidden = YES;
    if (btn.tag==1) {
        _currentAreaId = _tempAreaId;
        [_tableView reloadData];
    }
    else
    {
        _tempAreaId = _currentAreaId;
    
    }
    
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
