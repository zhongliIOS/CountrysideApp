//
//  MyAliPayManager.h
//  xuexuecan
//
//  Created by zhongli on 15/5/25.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ObjPay.h"

typedef unsigned int ShareType;

typedef unsigned int ShareStatus;
typedef void(^BackPublishContentEventHandler) (BOOL end);


@interface MyAliPayManager : NSObject

+(MyAliPayManager *)defultManager;

-(void)backInfoWith:(BOOL)payResult;
//-(void)PayWithInfo:(id )obj result:(BackPublishContentEventHandler)result;

@end
