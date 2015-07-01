//
//  MyHttpActionManager.m
//  small_douApp
//
//  Created by zhongli on 15/6/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyHttpActionManager.h"

@interface MyHttpActionManager ()

@property (nonatomic,retain)    AFHTTPRequestOperationManager * httpRequestMgr;
@property (nonatomic,copy)  NSString *baseURL;

@end

@implementation MyHttpActionManager

static MyHttpActionManager *_m = nil;
+(id)defaultManager
{
    if (!_m) {
        @synchronized(self)
        {
            if (!_m) {
                _m = [[self alloc]init];
                _m.baseURL = @"http://120.25.213.75:8080";
                AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:_m.baseURL]];
                manger.responseSerializer = [AFJSONResponseSerializer serializer];
                _m.httpRequestMgr = manger;
            }
        }
    }
    return _m;
}
- (AFHTTPRequestOperationManager *) getHttpRequestMgr
{
    return _m.httpRequestMgr;
}

-(void) ClearCookies
{
    NSURL * base_url = [NSURL URLWithString:_m.baseURL];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: base_url];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}
@end
