//
//  MainAllCell.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/22.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainAllCell : UITableViewCell

@property(nonatomic,copy)void(^btnClick)(NSUInteger );

-(void)fillDataWithModel:(ObjMainData *)obj;


@end
