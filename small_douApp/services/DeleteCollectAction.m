

//
//  DeleteCollectAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/13.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "DeleteCollectAction.h"

@implementation DeleteCollectAction

-(instancetype)initWithCollectId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/products/uncollect/%@.json",Id]];
    self.isValid = YES;
    return self;
}

@end
