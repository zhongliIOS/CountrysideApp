//
//  ObjBase.m
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "ObjBase.h"

@implementation ObjBase (numericComparison)

/*
 按id从大到小排序(即先看到最新的内容)
 */
- (NSComparisonResult) compareNumericallyDESC:(ObjBase *) other
{
    if( self.guid == nil || other.guid == nil )
        return NSOrderedAscending;
    

    return [ObjBase comparisonWithGUID:other WithRight:self];
}

//
- (NSComparisonResult) compareNumericallyASC:(ObjBase *) other
{
    if( self.guid == nil || other.guid == nil )
        return NSOrderedAscending;
    
    return [ObjBase comparisonWithGUID:self WithRight:other];
}


@end

@implementation ObjBase

-(NSString *)   getGUIDWithString
{
    if( [self.guid isKindOfClass:[NSNumber class]] )
    {
        return [self.guid stringValue];
    }
    else if( [self.guid isKindOfClass:[NSString class]] )
    {
        return self.guid;
    }
    return nil;
}

+(NSComparisonResult) comparisonWithGUID:(ObjBase *) left WithRight:(ObjBase *) right
{
    if( ([left.guid isKindOfClass:[NSNumber class]] && [right.guid isKindOfClass:[NSNumber class]]) ||
       ([left.guid isKindOfClass:[NSString class]] && [right.guid isKindOfClass:[NSString class]]) )
    {
        return [left.guid compare:right.guid];
    }
    else
    {
        NSString * left_string_guid = [left getGUIDWithString];
        NSString * right_string_guid = [right getGUIDWithString];
        if( left_string_guid && right_string_guid )
        {
            return [left_string_guid compare:right_string_guid];
        }
    }
    return NSOrderedAscending;
}

-(id) initWithDirectory:(NSDictionary *) data
{
    self = [super init];
    if( self )
    {
        NSNumber * number_guid      = [self ReadField_Number:data WithFieldName:@"id"];
        if( number_guid == nil )
        {
            NSString * string_guid = [self ReadField_String:data WithFieldName:@"id"];
            if( string_guid )
            {
                self.guid = string_guid;
            }
        }
        else
        {
            self.guid = number_guid;
        }
        
        self.class_type = [self ReadField_String:data WithFieldName:@"class_type"];
        self.created_at = [self ReadField_String:data WithFieldName:@"created_at"];
        self.updated_at = [self ReadField_String:data WithFieldName:@"updated_at"];
        
    }
    
    return self;
}
-(id) initWithCoder:( NSCoder *)coder
{
    if( self = [super init] )
    {
        self.guid = [coder decodeObjectForKey:@"id"];
        self.class_type = [coder decodeObjectForKey:@"class_type"];
        self.created_at = [coder decodeObjectForKey:@"created_at"];
        self.updated_at = [coder decodeObjectForKey:@"updated_at"];
    }
    
    return self;
}

// called when serialized

-(void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.guid forKey:@"id"];
    [coder encodeObject: self.class_type forKey:@"class_type"];
    [coder encodeObject: self.created_at  forKey:@"created_at"];
    [coder encodeObject: self.updated_at  forKey:@"updated_at"];
}

@end
