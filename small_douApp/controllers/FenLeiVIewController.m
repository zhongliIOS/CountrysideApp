//
//  FenLeiVIewController.m
//  small_douApp
//
//  Created by zhongli on 15/6/12.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "FenLeiVIewController.h"

@interface FenLeiVIewController()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    EMSearchDisplayController *_displayController;
    UITableView *_tableView;
    NSMutableArray *_tipDataArr;
}
@end

@implementation FenLeiVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self configNavBar];
    [self createSearchBar];
    [self initSearchDisplay];
    [self createContentView];
    
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
    _displayController.delegate = self;
    _displayController.searchResultsDataSource = self;
    _displayController.searchResultsDelegate   = self;
}
-(void)createContentView
{
   
    




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

    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
