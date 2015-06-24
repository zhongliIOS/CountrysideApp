//
//  EvaluationWriteCell.h
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationWriteCell : UITableViewCell

@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UILabel *pageLabel;
@property(nonatomic,copy)void(^CallBackClick)(void);

@end
