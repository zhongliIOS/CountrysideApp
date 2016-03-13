//
//  ObjCustomer.h
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "ObjBase.h"

@interface ObjCustomer : ObjBase


@property(nonatomic,copy)NSString *locationId;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *mtime;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *typeId;
@property(nonatomic,copy)NSString *ctime;
@property(nonatomic,copy)NSString *photo;

@end
