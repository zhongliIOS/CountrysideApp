//
//  MyWeChatPayManager.h
//  small_douApp
//
//  Created by zhongli on 15/8/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyAliPayManager.h"
#import "WXApi.h"

@interface MyWeChatPayManager : NSObject<WXApiDelegate>

+(MyWeChatPayManager *)defultManager;

-(void)PayWithInfo:(NSDictionary *)dic result:(BackPublishContentEventHandler)result;


@end
