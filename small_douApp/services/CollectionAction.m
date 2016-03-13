//
//  CollectionAction.m
//  small_douApp
//
//  Created by 刘中礼 on 16/3/13.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "CollectionAction.h"

@implementation CollectionAction

-(id)initWithId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/products/%@/collect.json",Id]];
    self.isValid = YES;
    return self;
}

-(id)initWithUnCollectId:(NSNumber *)Id
{
    self = [super initWithActionURLString:[NSString stringWithFormat:@"/products/%@/uncollect.json",Id]];
    self.isValid = YES;
    return self;

}
@end
