//
//  FavCell.h
//  small_douApp
//
//  Created by zhongli on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavCell : UITableViewCell

@property(nonatomic,copy)void(^DeleteClick)(void);

//我的收藏cell
-(void)fillDataWithModel:(ObjProduct *)model;

@end
