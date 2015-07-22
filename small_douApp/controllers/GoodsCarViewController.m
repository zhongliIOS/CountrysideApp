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
#import "DeleteGoodsCarAction.h"

@interface GoodsCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILabel *_sumPriceLabel;
    CGFloat _sumPriceCount;
    ObjectList *_objectList;
    CGFloat _currentPayNum;
    UIButton *_choiceBtn;

}
@end

@implementation GoodsCarViewController

-(void)getData
{
    MyInfo *m = [MyInfo defaultMyInfo];
    if (m.guid) {
        [_objectList ClearAll];
        GetMyGoodsCarAction *act = [[GetMyGoodsCarAction alloc]initWithCustomId:m.guid];
        [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
            MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
            if ([result get_error_code]==kServerErrorCode_OK) {
                NSArray *arr = [result try_get_data_with_array];
                if (arr) {
                    for (int i=0; i<arr.count; i++) {
                        NSDictionary *dic = arr[i];
                        ObjGoodCar *obj = [[ObjGoodCar alloc]initWithDirectory:dic];
                        if (_choiceBtn.selected) {
                            obj.isSelected = YES;
                        }
                        [_objectList Add:obj];
                    }
                    [_tableView reloadData];
                }
            }
            else
                [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
            
        } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
            
        }];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectList = [[ObjectList alloc]init];
    [self createNavBar];
    [self configNavBar];
    [self createTableView];
    [self createFootView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:NotificationUpdateMyInfo object:nil];
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
    
    _choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _choiceBtn.frame = CGRectMake(leftSpace, 12, 20, 20);
    _choiceBtn.layer.cornerRadius = 7.5;
    _choiceBtn.layer.masksToBounds = YES;
    [_choiceBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_choiceBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_choiceBtn];
    
    UILabel *qunxuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_choiceBtn.frame)+5, 0, 100, 44.0)];
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
    _sumPriceLabel.attributedText = [self getAttStringWith:@"合计：0.00"];
    [bgView addSubview:_sumPriceLabel];
    
}


-(NSArray *)getPayArr
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<[_objectList GetCount]; i++) {
        ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:i WithIsDESC:YES];
        if (obj.isSelected) {
            ObjPostOrder *order = [[ObjPostOrder alloc] init];
            ObjProductDetail *product = [[ObjProductDetail alloc]init];
            product.guid = obj.proId;
            product.price = obj.price;
            product.mu = obj.mu;
            product.pic = obj.pic;
            product.name = obj.name;
            order.num = [NSNumber numberWithInt:[obj.num intValue]];
            order.product = product;
            [arr addObject:order];
            
        }
    }
 
    return arr;
}
-(void)buyBtnClick
{
  //购买
    NSArray *payArr = [self getPayArr];
    if (payArr.count==0) {
        return;
    }
    TianXieOrderViewController *vc = [[TianXieOrderViewController alloc]init];
    vc.productsArr = payArr;
    [self.navigationController pushViewController:vc animated:YES];


}

-(void)choiceBtnClick:(UIButton *)btn
{
    //全选
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showAllCheck];
    }
    else
    {
        [self hideAllCheck];
    }
    [self refreshPayNum];
}

-(CGFloat)getPayNumBy:(ObjGoodCar *)obj
{
   
    return [obj.price floatValue]*[obj.num intValue];
}
-(void)refreshPayNum
{
    BOOL isAllSelected = YES;
    _currentPayNum = 0.0;
    for (int i=0; i<[_objectList GetCount]; i++) {
        ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:i WithIsDESC:YES];
        if (obj.isSelected) {
            _currentPayNum+=[self getPayNumBy:obj];

        }
        else{
            isAllSelected = NO;
        }
    }
    _sumPriceLabel.attributedText = [self getAttStringWith:[NSString stringWithFormat:@"合计：%.2f",_currentPayNum]];
    _choiceBtn.selected = isAllSelected;
}

-(void)showAllCheck
{
    for (int i=0; i<[_objectList GetCount]; i++) {
        ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:i WithIsDESC:YES];
        obj.isSelected = YES;
    }
    [_tableView reloadData];
}

-(void)hideAllCheck
{
    for (int i=0; i<[_objectList GetCount]; i++) {
        ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:i WithIsDESC:YES];
        obj.isSelected = NO;
    }
    [_tableView reloadData];

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
    [cell fillDataWithModel:(ObjGoodCar *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES]];
    [cell setCallBackSelected:^(BOOL isSelected) {
     ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES];
        obj.isSelected = isSelected;
        [self refreshPayNum];
    }];
    [cell setCallBackCount:^(NSInteger num) {
        ObjGoodCar *obj = (ObjGoodCar *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES];
        obj.num = [NSString stringWithFormat:@"%lu",num];
        [self refreshPayNum];

    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 55.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [_objectList GetCount];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self deleteWithShopId:[(ObjGoodCar *)[_objectList GetIndexAt:indexPath.row WithIsDESC:YES] guid]];

}

-(void)deleteWithShopId:(NSNumber *)num
{
    DeleteGoodsCarAction *act = [[DeleteGoodsCarAction alloc] initWithGoodId:num];
    if (!act.isValid) {
        return;
    }
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            [self getData];
        }
        else
            [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
        
    }];
}


-(NSAttributedString *)getAttStringWith:(NSString *)string
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color_font_red range:NSMakeRange(3, string.length-3)];
//    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONT_OMNESLIGHT size:size_font4] range:NSMakeRange(0, 1)];
    return attributedStr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
