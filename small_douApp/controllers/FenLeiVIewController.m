//
//  FenLeiVIewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "FenLeiVIewController.h"
#import "CategoryCell.h"
#import "GetCategorysAction.h"

@interface FenLeiVIewController()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    EMSearchDisplayController *_displayController;
    UITableView *_tableView;
    UITableView *_searchResultTableView;
    NSMutableArray *_tipDataArr;
    NSMutableArray *_dataArray;
}
@end

@implementation FenLeiVIewController

-(void)initData
{
    [_dataArray removeAllObjects];
    GetCategorysAction *act = [[GetCategorysAction alloc]init];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSArray *arr = [result try_get_data_with_array];
            for (int i=0; i<arr.count; i++) {
                NSDictionary *dic = arr[i];
                ObjCategory *obj = [[ObjCategory alloc] initWithDirectory:dic];
                [_dataArray addObject:obj];
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
    _dataArray = [NSMutableArray array];
    [self initData];
    [self createNavBar];
    [self configNavBar];
    [self createSearchBar];
    [self initSearchDisplay];
    [self createTableView];
    
}


-(void)configNavBar
{
    self.midTitle = @"分类";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    self.leftBtn.hidden = YES;
}

-(void)createSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenW, 44)];
    _searchBar.barStyle = UIBarStyleDefault;
    if (SYSTEM_VERSION_GREATER_THAN(@"7.0")) {
        _searchBar.tintColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    UIImage *image = [LUnity imageWithColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0] andSize:CGSizeMake(1, 1)];
    _searchBar.backgroundImage = image;
    _searchBar.scopeBarBackgroundImage = image;
    _searchBar.translucent  = YES;
    _searchBar.delegate     = self;
    _searchBar.placeholder  = @"输入类别或关键字";
    _searchBar.tintColor = color_blue1;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_searchBar];

}

- (void)initSearchDisplay
{
    _displayController = [[EMSearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchResultTableView = _displayController.searchResultsTableView;
    _displayController.delegate = self;
    _displayController.searchResultsDataSource = self;
    _displayController.searchResultsDelegate   = self;
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight+44, ScreenW, ScreenH-TopHeight-44)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

}

#pragma mark - UISearchDisplayDelegate
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
    
    tableView.frame = CGRectMake(0,0, ScreenW, [UIScreen mainScreen].bounds.size.height-CGRectGetMaxY(_searchBar.frame));
}
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{

    [UIView animateWithDuration:0.2 animations:^{
        _searchBar.frame = CGRectMake(0, 20, ScreenW, 44);
        self.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
        self.navBar.hidden = YES;

    }];
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [UIView animateWithDuration:0.2 animations:^{
        _searchBar.frame = CGRectMake(0, TopHeight, ScreenW, 44);
        self.view.backgroundColor = color_bg;
        self.navBar.hidden = NO;
    }];
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    
    
    
}

#pragma mark----tableViewDelegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView==tableView) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        if (!cell) {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
        }
        [cell fillDataWith:_dataArray[indexPath.row]];
        return cell;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableView==tableView) {
        return _dataArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView==tableView) {
        return 55.0;
    }
    return 44.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
