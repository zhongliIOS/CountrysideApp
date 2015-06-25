//
//  GetAreasAction.m
//  small_douApp
//
//  Created by zhongli on 15/6/25.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "GetAreasAction.h"

@implementation GetAreasAction

-(id)init
{
    self = [super initWithActionURLString:@"areas/areas_list.json"];
    if (self) {
        self.parameters = [@{@"sort":@"玩玩"} mutableCopy];
    }
    self.isValid = YES;
    return self;
}

@end
