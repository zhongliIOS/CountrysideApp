//
//  LTableViewController.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "LBaseViewController.h"

@interface LTableViewController : LBaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong,nonatomic) UITableView * tableView;

@end
