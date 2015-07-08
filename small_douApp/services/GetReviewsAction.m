
//
//  GetReviewsAction.m
//  small_douApp
//
//  Created by zhongli on 15/7/2.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetReviewsAction.h"

@implementation GetReviewsAction

-(instancetype)initWithProId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/reviews/reviews_list/%@.json",Id]];
    self.isValid = YES;
    return self;
}


@end
