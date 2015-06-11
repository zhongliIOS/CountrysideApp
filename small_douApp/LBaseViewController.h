//
//  LBaseViewController.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBaseViewController : UIViewController


@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,copy)NSString *midTitle;
@property(nonatomic,strong)UIColor *midTitelColor;
@property(nonatomic,strong)UIColor *navTintColor;


-(void)createNavBar;

- (void)leftButItemClick;
- (void)rightButItemClick;

@end
