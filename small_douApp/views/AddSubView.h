//
//  AddSubView.h
//  small_douApp
//
//  Created by zhongli on 15/6/17.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSubView : UIView

@property(nonatomic,assign)NSInteger currentCount;
@property(nonatomic,copy)void(^addClick)(NSInteger );
@property(nonatomic,copy)void(^subClick)(NSInteger );


@end
