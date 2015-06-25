//
//  THttpActionMgr.m
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "THttpActionMgr.h"



#define HTTPNOTIFY_USERDATA_KEY @"request.userInfo"


static THttpActionMgr *sharedMgr = nil;

@interface THttpActionMgr ()

@property (nonatomic,assign)    BOOL    output_respone;
@property (nonatomic,assign)    BOOL    output_error;
@property (nonatomic,retain)    AFHTTPRequestOperationManager * httpRequestMgr;

-(NSString *) getBaseURLString;

@end

@implementation THttpActionMgr




/**
 *  获得base url
 *
 *  @return 根据版本返回base url
 */
-(NSString *) getBaseURLString
{
   NSString * hostname = nil;
    

    hostname = @"http://120.25.213.75:8080";

                
    NSString * base_url_string = [[NSString alloc] initWithFormat:@"%@",hostname];
    return base_url_string;
}

- (AFHTTPRequestOperationManager *) getHttpRequestMgr
{
    return self.httpRequestMgr;
}
+ (id)shared
{
	if (!sharedMgr) {
		@synchronized(self) {
			if (!sharedMgr) {
				sharedMgr = [[self alloc] init];
                sharedMgr.output_error = TRUE;
                sharedMgr.output_respone = TRUE;
                
                NSURL * base_url = [NSURL URLWithString:[sharedMgr getBaseURLString]];
                AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:base_url];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                sharedMgr.httpRequestMgr = manager;
			}
		}
	}
	return sharedMgr;
}
-(void) ClearCookies
{
    NSURL * base_url = [NSURL URLWithString:[sharedMgr getBaseURLString]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: base_url];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

@end
