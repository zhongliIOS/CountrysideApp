//
//  GetProductListAction.h
//  small_douApp
//
//  Created by zhongli on 15/7/23.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface GetProductListAction : MyActionGetBase

-(instancetype)initWithTypeId:(NSNumber *)Id page:(NSNumber *)page size:(NSNumber *)size sort:(NSString *)sort name:(NSString *)name;


@end
