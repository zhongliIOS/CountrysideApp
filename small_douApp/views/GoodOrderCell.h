//
//  GoodOrderCell.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodOrderCell : UITableViewCell

-(void)fillDataWithModel:(ObjPostOrder *)obj;

-(void)fillDataWithProduct:(ObjProduct *)obj;

@end
