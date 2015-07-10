//
//  MyAliPayManager.m
//  xuexuecan
//
//  Created by zhongli on 15/5/25.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "MyAliPayManager.h"
#import "DataSigner.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation MyAliPayManager
{
    BackPublishContentEventHandler _backResult;
    NSString *_partnerID;
    NSString *_sellerID;
    NSString *_partnerPrivKey;
    NSString *_aliPayPubKey;
    NSString *_payMoney;
    NSString *_orderDescription;
    NSString *_orderID;
    NSString *_product_name;
    NSString *_callBackUrl;
}
+(MyAliPayManager *)defultManager
{
    static MyAliPayManager *_m=nil;
    if (!_m) {
        _m=[[MyAliPayManager alloc] init];
        
    }
    return _m;
}
//
//-(void)PayWithInfo:(ObjPay *)obj result:(BackPublishContentEventHandler)result
//{
//
//    _partnerID = @"2088212236370875";
//    _sellerID = @"2088212236370875";
//    _partnerPrivKey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKDscACI2SRWp7kLb6arOUGm/JcodVSQjjYfH7yhAaWRGa55g/cy8H12TMAxo7LXHkjCyzWsZ2C+cue7cQKOK+A57ieG3vFTPcuBZicObQitNZYbU2D/su9s3sh4TQHwVzKcH/B91xYuOmvIq3NP5UCrTDvZ/H+bByOJagVPpcmnAgMBAAECgYBct93QcQirZ0I729r4rK7QpOXkMetoTeGiTUx74kiQnImvfVQLmc32e7K9CdzHripEwfdTdYIau6B45Aa48jFUlifKvGkW/ciqJf02bvcLLMgKGUlg6ZGGWjJtrIZqSRjlg0qU6P2RRE7/iEhXNZ2oKneYZHmqqBsdI/KCgrdkAQJBAMvF7GRkaOnsPrzT+JNy9BNhSm2gdzUlIHZBKmfAapvHigR7SoCDF2JQkcSrjUTUYWkNJ7pqIEvp9Ht/f/kOKx0CQQDKKwuYJcqIx0yrI1hE3XugNR3krAKcpxVkcN9fmXQUUpjH6eh105mvfcjvjZHhfLX7vVLZKGYFvv4HvERTmKiTAkEAhhNPa+rJQQkJapMKHnJneAzuvNz1MomgJ07PSP7I5oDPJg29Qnt+uliK4N2DkQMwqL9YIYbMg0aHb26/1C5nXQJADiWY+Bqc45leqhMdGCSPhBRzdQ78V83xV0f2uY/ZaZqmCkc59xTJilg4+VpkvOynJ2iGJaAIE5rb19q6xUbHdQJAL1ovKBXP9/SeocmESIU2jwITlEj7T/bXCAN9ATQTNyRZdrXVHMCtFbdR7Zvsww0mdxVfFgn4tkBDj/UyC9H/Lw==";
//    
//    _aliPayPubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
//    _orderDescription = obj.extra_info.product_desc;
//    _orderID = obj.sdk_oid;
//    _product_name = obj.extra_info.product_name;
//    _callBackUrl = obj.extra_info.notify_url;
//    _backResult = result;
//    
//    _payMoney = @"0.01";
//    #if defined(XUEXUECAN_UAT)||defined(XUEXUECAN_PRODUCTION)
//    _payMoney = [NSString stringWithFormat:@"%.2f",[obj.amount floatValue]/100];
//    #endif
//    NSString *appScheme = @"xuexuecan";
//    NSString* orderInfo = [self getOrderInfo];
//    NSString* signedStr = [self doRsa:orderInfo];
//    NSLog(@"%@",signedStr);
//    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                             orderInfo, signedStr, @"RSA"];
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//        if ([resultDic[@"resultStatus"] integerValue]==9000) {
//            //成功
//            _backResult(YES);
//        }
//        else
//            _backResult(NO);
//    }];
//
//}
-(void)backInfoWith:(BOOL)payResult
{
    if (payResult) {
    
        _backResult(YES);
    }
    else
    {
        _backResult(NO);
    
    }

}
-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(_partnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}
-(NSString*)getOrderInfo
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    Order *order = [[Order alloc] init];
    order.partner = _partnerID;
    order.seller = _sellerID;
    order.tradeNO = _orderID; //订单ID（由商家自行制定）
    order.productName = _product_name; //商品标题
    order.productDescription = _orderDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%@",_payMoney]; //商品价格
    order.notifyURL =  _callBackUrl;
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"xuexuecantest";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    return orderSpec;
}
@end
