//
//  JsonObject.m
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "JsonObject.h"

@implementation JsonObject


-(BOOL) ReadField_Bool:(NSDictionary *) data
        WithFieldName:(NSString *) field_name
            ResultOut:(BOOL*) out_result
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return NO;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return NO;

    if( [field isKindOfClass:[NSString class]] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSNumber * temp = [num_format numberFromString:field];
        *out_result =  [temp boolValue];
        return YES;
    }
    else  if( [field isKindOfClass:[NSNumber class] ] )
    {
        NSNumber * temp = (NSNumber *)field;
        *out_result = [temp boolValue];
        return YES;
    }
    return FALSE;
}


-(NSNumber *) ReadField_Number:(NSDictionary *) data  WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSNumber class] ] )
    {
        return field;
    }
    else if( [field isKindOfClass:[NSString class]] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSNumber * ret = [num_format numberFromString:field];
        
        return ret;
    }
    return nil;
}

-(NSString *) ReadField_String:(NSDictionary *) data WithFieldName :(NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return @"";
    if( [field isKindOfClass:[NSNumber class] ] )
    {
        NSNumberFormatter * num_format = [[NSNumberFormatter alloc] init];
        NSString * ret = [num_format stringFromNumber:field];
        
        return ret;
    }
    else if([field isKindOfClass:[NSString class]])
    {
        return field;
    }
    
    return @"";
}

-(NSDictionary *) ReadField_Dict:(NSDictionary *) data WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSDictionary class]] )
    {
        return field;
    }
    
    return nil;
}

-(NSArray *) ReadField_Array:(NSDictionary *) data WithFieldName : (NSString *) field_name
{
    if( ![data isKindOfClass:[NSDictionary class]] )
        return nil;
    
    id field = [data objectForKey:field_name];
    if( field == [NSNull null] )
        return nil;
    if( [field isKindOfClass:[NSArray class]] )
    {
        return field;
    }
    
    return nil;
}

@end
