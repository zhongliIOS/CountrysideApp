//
//  CollectionAction.h
//  small_douApp
//
//  Created by 刘中礼 on 16/3/13.
//  Copyright © 2016年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface CollectionAction : MyActionPostBase

-(id)initWithId:(NSNumber *)Id;
-(id)initWithUnCollectId:(NSNumber *)Id;

@end
