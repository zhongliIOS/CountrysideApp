//
//  AreaInfo.h
//  small_douApp
//
//  Created by zhongli on 15/6/26.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectList.h"

@interface AreaInfo : NSObject

@property(nonatomic,strong)ObjectList *dataList ;

+(id)areaInfo;

-(NSString *)searchAreaNameWithId:(NSString *)Id;


@end
