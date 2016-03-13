//
//  ObjNewOrder.m
//  small_douApp
//
//  Created by 刘中礼 on 16/3/13.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "ObjNewOrder.h"

@implementation ObjNewOrder

-(id)initWithDirectory:(NSDictionary *)data
{
    self = [super initWithDirectory:data];
    if (self) {
        self.addressId = [self ReadField_Number:data WithFieldName:@"addressId"];
        self.refundedFee = [self ReadField_Number:data WithFieldName:@"refundedFee"];
        self.totalFee = [self ReadField_Number:data WithFieldName:@"totalFee"];
        self.userId = [self ReadField_Number:data WithFieldName:@"userId"];
        self.code = [self ReadField_String:data WithFieldName:@"code"];
        self.ctime = [self ReadField_String:data WithFieldName:@"ctime"];
        self.message = [self ReadField_String:data WithFieldName:@"message"];
        self.status = [self ReadField_String:data WithFieldName:@"status"];
    }
    return self;
}

@end
