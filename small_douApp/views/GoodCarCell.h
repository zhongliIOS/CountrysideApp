//
//  GoodCarCell.h
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodCarCell : UITableViewCell

//购物车Cell
@property(nonatomic,copy)void(^CallBackSelected)(BOOL );
@property(nonatomic,copy)void(^CallBackCount)(NSInteger );

-(void)fillDataWithModel:(ObjGoodCar *)obj;

@end
