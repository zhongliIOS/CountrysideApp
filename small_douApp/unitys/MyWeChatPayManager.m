//
//  MyWeChatPayManager.m
//  small_douApp
//
//  Created by zhongli on 15/8/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyWeChatPayManager.h"

@implementation MyWeChatPayManager
{
    BackPublishContentEventHandler _backResult;


}
+(MyWeChatPayManager *)defultManager
{
    static MyWeChatPayManager *_m=nil;
    if (!_m) {
        _m=[[MyWeChatPayManager alloc] init];
    }
    return _m;
}
-(void)PayWithInfo:(NSDictionary *)dic result:(BackPublishContentEventHandler)result
{
    
    _backResult = result;
    //生成支付对象
    PayReq *req = [[PayReq alloc]init];
    NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
    req.openID              = [dic objectForKey:@"appid"];
    req.partnerId           = [dic objectForKey:@"partnerid"];
    req.prepayId            = [dic objectForKey:@"prepayid"];
    req.nonceStr            = [dic objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dic objectForKey:@"package"];
    req.sign                = [dic objectForKey:@"sign"];
    [WXApi sendReq:req];
}

//支付结果回调
-(void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        if (resp.errCode==WXSuccess) {
            
            _backResult(YES);
        }
        else
        {
            _backResult(NO);
        }
    }

}



@end
