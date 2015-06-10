//
//  THttpActionMgr.h
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResponeResult.h"
#import "LUnity.h"
#import "TActionBase.h"

/**
 * http actions manager
 */
@interface THttpActionMgr : NSObject

/**
 *  获得单件实例
 *
 *  @return 返回单件对象
 */
+ (id)shared;

/**
 *  清空学学看相关的本地 cookies
 */
- (void) ClearCookies;

/**
 *  获得http请求操作管理器
 *
 */
- (AFHTTPRequestOperationManager *) getHttpRequestMgr;

@end
