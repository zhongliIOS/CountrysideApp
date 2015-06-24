//
//  GoodHeadCell.h
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodHeadCell : UITableViewCell

@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UILabel *pageLabel;
@property(nonatomic,strong)UIButton *addressBtn;
@property(nonatomic,copy)void(^CallBackEvaluation)(void );
@property(nonatomic,copy)void(^CallBackCount)(NSInteger );
@end
