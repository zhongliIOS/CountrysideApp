//
//  ObjectList.m
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "ObjectList.h"
#import "ObjBase.h"


@interface ObjectList ()
@property (nonatomic,retain)    NSMutableDictionary  *   impl;
@end

@implementation ObjectList

-(id) init
{
    self = [super init];
    if (self) {
        self.impl = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone{
    ObjectList *list = [[ObjectList alloc]init];
    list.impl = [self.impl copy];
    return list;
}
- (ObjBase *) Find:(id) guid
{
    ObjBase * ret = nil;
    
    if( self.impl != nil && guid )
    {
        ret = [self.impl objectForKey:guid];
    }
    
    return ret;
}

- (BOOL) Add:(ObjBase *)elm
{
    BOOL ret = NO;
    if( self.impl != nil && elm != nil && elm.guid  )
    {
        [ self.impl setObject:elm forKey:elm.guid ];
        ret = YES;
    }
    
    return ret;
}

- (void) Remove:(id) guid
{
    if(  guid )
    {
        [ self.impl removeObjectForKey: guid ];
    }
}

- (ObjBase *) GetIndexAt:(NSInteger) idx WithIsDESC:(BOOL) is_desc
{
    ObjBase * ret = nil;
    
    NSArray *sortedKeys = nil;
    if( is_desc )
    {
        sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyDESC:)];
    }
    else
    {
        sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyASC:)];
    }
    
    if( sortedKeys )
    {
        if( [sortedKeys count] >= idx + 1 )
        {
            NSNumber * key = [sortedKeys objectAtIndex:idx];
            ret = [self.impl objectForKey:key];
        }
    }
    
    return ret;
}


- (ObjBase *) GetMax
{
    NSUInteger count = [self.impl count];
    if( count > 0 )
    {
        return [self GetIndexAt:0 WithIsDESC:YES];
    }
    return nil;
}

- (ObjBase *) GetMin
{
    NSUInteger count = [self.impl count];
    if( count > 0 )
    {
        return [self GetIndexAt:0 WithIsDESC:NO];
    }
    return nil;
}

- (NSInteger)  GetIndexByObj:(ObjBase *) baseObj
{
    if( !baseObj )
        return -1;
    
    NSArray * allValues = [self.impl allValues];
    if( allValues )
    {
        NSInteger index = 0;
        NSEnumerator * itor = [allValues objectEnumerator];
        if( itor )
        {
            id value;
            while ( value = [itor nextObject] ) {
                ObjBase * elm = (ObjBase *)value;
                if( elm == baseObj )
                {
                    return index;
                }
                index += 1;
            }
        }
    }
    
    return -1;
}
-(NSInteger)GetIndexByGuId:(id)Id
{
    for (int i=0; i<[self GetCount]; i++) {
        ObjBase *obj = [self GetIndexAt:i WithIsDESC:YES];
        if ([obj.guid integerValue]==[Id integerValue]) {
            return i;
        }
    }
    return 0;
}

- (void) ClearAll
{
    [self.impl removeAllObjects];
}

- (void) LimitSizeByGUID:(NSUInteger) limit_size
{
    if( [self.impl count] > limit_size )
    {
        NSUInteger remove_count = [self.impl count] - limit_size;
        NSArray *sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyASC:)];
        
        for (NSUInteger n = 0; n < remove_count; n++) {
            [self.impl removeObjectForKey:[sortedKeys objectAtIndex:n]];
        }
    }
}

- (NSUInteger) GetCount
{
    NSUInteger count =  [self.impl count];
    return count;
}



- (void) appendFromObjectList:(ObjectList *) otherList
{
    if( otherList && otherList.impl )
    {
        [self.impl addEntriesFromDictionary:otherList.impl];
    }
}




@end
