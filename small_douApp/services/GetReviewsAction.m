
//
//  GetReviewsAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetReviewsAction.h"

@implementation GetReviewsAction

-(instancetype)initWithProId:(NSNumber *)Id page:(NSNumber *)page size:(NSNumber *)size sort:(NSString *)sort
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/reviews/reviews_list/%@.json",Id]];
    if (page&&size&&sort) {
        self.parameters = [@{@"page":page,@"size":size,@"sort":sort} mutableCopy];
    }
    self.isValid = YES;
    return self;
}


@end
