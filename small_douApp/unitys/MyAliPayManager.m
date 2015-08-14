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

-(void)PayWithInfo:(NSDictionary *)dic result:(BackPublishContentEventHandler)result
{
    _partnerID = @"2088021017121731";
    _sellerID = @"2088021017121731";
    _partnerPrivKey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALu8DpLyYorRtNLLa1LHWVcEwY8c8f/2FjVZVsF/Z5nvocTT7Tt/e1cC+qy8ZHpc4YBvatcSpBBNaPkyi+NecWR1XluDCF5LE3b4k4kVbtEsO82/typYWvxBsK2fa26p2mAlkuq08zGMFUomoaG4GRbKnNtrsygPvupO9qaCLQfFAgMBAAECgYANA4FDIHhCRT0yq5U5/MWtqY+9WvVPmAB8HEBOU4Wb/yeInGRCjpi/NF6qILkaXlvnalHOrOUgmC0hsSZPUZmsjZ8x4KLIPMauOnCVgUuV1FEz39khViXzI2jJjqXPTRjgIUE5eeAGuece9+OCNNqfU5yWf63qxYnMMANwFtYd9QJBAOjp1fQ3Yf6dbNaFBB4lz6cjoAmCy4lku5NpsECMICP0mG78pfFBWtqsQPKl0ckcvQEi6V8JAI/lSan3f2ACHdsCQQDOV8+rES0CpYrxfkPxwfu4pz3TOYtPQXbeoVJEJDnnbiKnzZ6xsMpbM+eeHvg0Iyp+7fb+RZmG6w4k4H4RFPLfAkBJ6EmYISrbXKD4wWS5HE50Pv29ht+HTYuoD1V6Zfyc7DSio1EU6SQnV5mUZcHYC2J+RdG/8l9XSe7CHGMy1/kZAkBEGH6UOercwL0FzWGm2xmzap3go1DyKuyLtDlt+3aQhawyLI1+npVpW8vIRvgqXKCdmvK0H0v3VoMocF2qTXuJAkEAh8JUeQl8Hy1Ml76uK+I5sTRLDiE265oJJ5cSkvJxGXcVBIAwgt8upttfYXTljiwemxRj/lNyme4ICMLPhLsm3w==";
    
    _aliPayPubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
    _orderDescription = dic[@"product_desc"];
    _orderID = dic[@"orderno"];
    _product_name = dic[@"productName"];
    _callBackUrl = dic[@"callbackUrl"];
    _backResult = result;
    
    _payMoney = @"0.01";
    #if defined(XUEXUECAN_UAT)||defined(XUEXUECAN_PRODUCTION)
    _payMoney = [NSString stringWithFormat:@"%.2f",[obj.amount floatValue]/100];
    #endif
    NSString *appScheme = @"smalldou";
    NSString* orderInfo = [self getOrderInfo];
    NSString* signedStr = [self doRsa:orderInfo];
    NSLog(@"%@",signedStr);
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] integerValue]==9000) {
            //成功
            _backResult(YES);
        }
        else
            _backResult(NO);
    }];
}
-(void)PayWithOrderString:(NSString *)orderString result:(BackPublishContentEventHandler)result
{
    NSString *appScheme = @"smalldou";
    _backResult = result;
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] integerValue]==9000) {
            //成功
            _backResult(YES);
        }
        else
            _backResult(NO);
    }];
    

}

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
    NSString *appScheme = @"smalldou";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    return orderSpec;
}
@end
