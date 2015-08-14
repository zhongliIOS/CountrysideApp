//
//  AreaViewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AreaViewController.h"

@interface AreaViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    EMSearchDisplayController *_displayController;
    UITableView *_tableView;
    NSMutableArray *_tipDataArr;
    ObjectList *_areaList;
    ObjectList *_areaSearchList;
}
@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createSearchBar];
    [self createTableView];
    [self initSearchDisplay];
    _areaSearchList = [[ObjectList alloc]init];
    AreaInfo *m = [AreaInfo areaInfo];
    _areaList = m.dataList;
    
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

-(void)configNavBar
{
    self.midTitle = @"选择小区";
    self.navTintColor = color_green;
    self.midTitelColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    self.leftBtn.hidden = NO;
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
    _searchBar.placeholder  = @"输入小区名";
    _searchBar.tintColor = color_blue1;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_searchBar];
    
}

- (void)initSearchDisplay
{
    _displayController = [[EMSearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _displayController.delegate = self;
    _displayController.searchResultsDataSource = self;
    _displayController.searchResultsDelegate   = self;
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

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [_areaSearchList ClearAll];
    for (int i=0; i<[_areaList GetCount]; i++) {
        ObjArea *obj = (ObjArea *)[_areaList GetIndexAt:i WithIsDESC:YES];
        if ([obj.name containsString:searchText]) {
            [_areaSearchList Add:obj];
        }
    }
}

#pragma mark----tableViewDelegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView == tableView) {
        static NSString *tipCellIdentifier = @"tipCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:tipCellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
        if (indexPath.section==0) {
            cell.textLabel.text =  [[AreaInfo areaInfo] searchAreaNameWithId:[[MyInfo defaultMyInfo] areaId]];
        }
        else
        {
         ObjArea *area = (ObjArea *)[_areaList GetIndexAt:indexPath.row WithIsDESC:YES];
         cell.textLabel.text = area.name;
        }
        cell.textLabel.textColor = color_font_gray1;
        cell.textLabel.font = [UIFont systemFontOfSize:size_font1];
        return cell;
    }
    else
    {
        static NSString *tipCellIdentifier = @"tipCellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:tipCellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.textLabel.text = [(ObjArea *)[_areaSearchList GetIndexAt:indexPath.row WithIsDESC:YES] name];
        cell.textLabel.textColor = color_font_gray1;
        cell.textLabel.font = [UIFont systemFontOfSize:size_font1];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_tableView) {
        return 35.0;
    }
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
        bgView.backgroundColor = color_bg;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 34.5, ScreenW, 0.5)];
        line.backgroundColor = color_font_green;
        [bgView addSubview:line];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 35)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = color_font_green;
        titleLabel.font = [UIFont systemFontOfSize:size_font2];
        titleLabel.text = section==0?@"当前":@"全部";
        [bgView addSubview:titleLabel];
        
        return bgView;
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        bgView.backgroundColor = color_line2;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = color_font_black;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.text = @"搜索结果";
        [bgView addSubview:titleLabel];
        return bgView;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_tableView) {
        return 2;
    }
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView==_tableView) {
        if (indexPath.section==0) {
            [self saveAreaWith:nil];
        }
        else
        {
            [self saveAreaWith:(ObjArea *)[_areaList GetIndexAt:indexPath.row WithIsDESC:YES]];
        }
    }
    else
    {
       [self saveAreaWith:(ObjArea *)[_areaSearchList GetIndexAt:indexPath.row WithIsDESC:YES]];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableView == tableView) {
        if(section==0)
        {
            return 1;
        }
        return [_areaList GetCount];;
    }
  
    return [_areaSearchList GetCount];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView==tableView) {
        return 35.0;

    }
    return 35.0;
}
-(void)saveAreaWith:(ObjArea *)area
{
    if (!area) {
        [self leftButItemClick];
        return;
    }
    NSMutableDictionary *paramets = [NSMutableDictionary dictionary];
    [paramets setObject:area.guid forKey:@"areaId"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:My_token];
    NSString *phoneNum = [[MyInfo defaultMyInfo] tel];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    [manager POST:[NSString stringWithFormat:@"/customers/%@/edit",phoneNum] parameters:paramets success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        [LUnity showErrorHUDViewAtView:self.view WithTitle:[result get_messge]];
        if ([result get_error_code]==kServerErrorCode_OK) {
            MyInfo *myinfo = [MyInfo defaultMyInfo];
            [myinfo initWithModel:[result try_get_data_with_dict]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateMyInfo object:nil];
            [self leftButItemClick];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
    }];
    
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
