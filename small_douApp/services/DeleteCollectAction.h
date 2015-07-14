//
//  DeleteCollectAction.h
//  small_douApp
//
//  Created by zhongli on 15/7/13.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface DeleteCollectAction : MyActionGetBase
-(instancetype)initWithCollectId:(NSNumber *)Id;

@end
