//
//  MyHttpActionManager.h
//  small_douApp
//
//  Created by zhongli on 15/6/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHttpActionManager : NSObject

+(id)defaultManager;
- (void) ClearCookies;
- (AFHTTPRequestOperationManager *) getHttpRequestMgr;

@end
