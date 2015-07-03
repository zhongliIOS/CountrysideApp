//
//  TResponeResult.m
//  xuexuecan
//
//  Created by teng.tang on 15/2/5.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "MyResponeResult.h"

#define JSONRESKEY_ERRORCODE    @"errcode"
#define JSONRESKEY_DATA @"data"
#define JSONRESKEY_MESSAGE  @"showmessage"

@implementation MyResponeResult


@synthesize json_data=_json;


+ (id) createWithResponeObject:(id) responeObject
{
    if( ![responeObject isKindOfClass:[NSDictionary class]] )
    {
        return nil;
    }
    NSDictionary * jsonDict = (NSDictionary *) responeObject;
    MyResponeResult * ret = [[MyResponeResult alloc] initWithJsonRespone:jsonDict];
    return ret;
}

- (id) initWithJsonRespone:(NSDictionary *) json
{
    self = [super init];
    if (self) {
        _json = json;
    }
    
    return self;
}

- (kServerErrorCode)  get_error_code
{

    NSString * error_code = [_json objectForKey:JSONRESKEY_ERRORCODE];
    int result = [error_code intValue];
    return result;
}

- (NSString *)  get_messge
{
    if( _json == nil  )
    return nil;
    
    
    NSString * result_message = [_json objectForKey:JSONRESKEY_MESSAGE];
    return result_message;
}

- (id) get_data
{
    if( _json == nil )
        return nil;
    
    id data = [_json objectForKey:JSONRESKEY_DATA];
    
    return data;
}

- (NSArray *) try_get_data_with_array
{
    if( [[self get_data] isKindOfClass:[NSArray class]] )
        return (NSArray *)[self get_data];
    return nil;
}

- (NSDictionary *) get_first_object
{
    if( [self try_get_data_with_dict] )
        return [self try_get_data_with_dict];
    
    NSArray * list = [self try_get_data_with_array];
    if( list.count > 0 )
    {
        if( [[list objectAtIndex:0] isKindOfClass:[NSDictionary class]] )
        {
            NSDictionary * ret = [list objectAtIndex:0];
            return ret;
        }
        
    }
    return nil;
}
- (NSDictionary *) try_get_data_with_dict
{
if( [[self get_data] isKindOfClass:[NSDictionary class]] )
        return (NSDictionary *)[self get_data];
    return nil;
}
-(NSString *) description
{
    NSString * desc = [[NSString alloc] initWithFormat:@"Respone Code<%lu> , Message<%@> , Data<%@> " ,
                       [self get_error_code] ,
                       [self get_messge] ,
                       [[self get_data] description]];
    return desc;
}

@end
