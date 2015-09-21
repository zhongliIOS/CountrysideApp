//
//  GoodAddressCell.h
//  small_douApp
//
//  Created by 刘中礼 on 15/6/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjOrderDetail.h"

@interface GoodAddressCell : UITableViewCell

@property(nonatomic,copy)NSString *addressId;
@property(nonatomic,copy)void(^areaClick)(void);

-(void)fillDataWithModel:(NSArray *)arr;
-(void)fillDataWithOrderDeatilModel:(ObjOrderDetail *)obj;


@end
