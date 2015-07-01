//
//  MyActionBase.m
//  small_douApp
//
//  Created by zhongli on 15/6/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "MyActionBase.h"

@interface MyActionBase()
@property (nonatomic,retain) NSString * url;
@end

@implementation MyActionBase
-(id) initWithActionURLString:(NSString *) str_url
{
    self = [super init];
    if( self )
    {
        self.url = str_url;
        self.isValid = NO;
    }
    return self;
}


-(NSString *) get_action_url
{
    return self.url;
}

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure
{

    
    
    
    return YES;
}
@end



@implementation MyActionGetBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure
{
    NSLog(@"%@",[self get_action_url]);
    if( !self.isValid )
        return NO;
    
    AFHTTPRequestOperationManager * http_request_mgr = [[MyHttpActionManager defaultManager] getHttpRequestMgr];
    if( !http_request_mgr )
        return NO;
    
    [http_request_mgr GET:[self get_action_url] parameters:self.parameters
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      success( self , responseObject , operation );
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      failure( self , error , operation );
                  }];
    return YES;
}

@end


@implementation MyActionPostBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure
{
    if( !self.isValid )
        return NO;
    AFHTTPRequestOperationManager * http_request_mgr = [[MyHttpActionManager defaultManager] getHttpRequestMgr];
    if( !http_request_mgr )
        return NO;
    
    [http_request_mgr POST:[self get_action_url] parameters:self.parameters
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       success( self , responseObject , operation );
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       failure( self , error , operation );
                       
                   }];
    
    return YES;
}
@end

@implementation MyActionPostWithSingleImageBase

-(id) initWithActionURLString:(NSString *) str_url
{
    self = [super initWithActionURLString:str_url];
    if( self )
    {
        self.upload_image_max_size = CGSizeZero;
        self.upload_image_param_name = @"photo";
    }
    return self;
}

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure
{
    if( !self.isValid )
        return NO;
    AFHTTPRequestOperationManager * http_request_mgr = [[MyHttpActionManager defaultManager] getHttpRequestMgr];
    if( !http_request_mgr )
        return NO;
    
    NSURL * upload_file_url = nil;
    if( self.upload_image )
    {
        //        图片大小限制
        if( CGSizeEqualToSize(self.upload_image_max_size, CGSizeZero) )
            
        {
            upload_file_url = [LUnity createTempImageUploadFile:self.upload_image];
        }
        else
        {
            upload_file_url = [LUnity createTempImageUploadFile:self.upload_image WithMaxSize:self.upload_image_max_size];
        }
    }
    
    [http_request_mgr POST:[self get_action_url]
                parameters:self.parameters
 constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if( upload_file_url )
         {
             [formData appendPartWithFileURL:upload_file_url name:self.upload_image_param_name error:nil];
             
         }
     }
                   success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if( upload_file_url )
         {
             [[NSFileManager defaultManager] removeItemAtURL:upload_file_url error:nil];
         }
         
         success( self , responseObject , operation );
     }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if( upload_file_url )
         {
             [[NSFileManager defaultManager] removeItemAtURL:upload_file_url error:nil];
         }
         
         failure( self , error , operation );
     }];
    
    return YES;
}

@end

@implementation MyActionPostWithManyImageBase
{
    NSMutableArray *_upload_file_url_Arr;
    
}
-(id)initWithActionURLString:(NSString *)str_url
{
    self = [super initWithActionURLString:str_url];
    if( self )
    {
        _upload_file_url_Arr = [NSMutableArray array];
    }
    return self;
    
    
}
-(BOOL)DoActionWithSuccess:(SussessBlock)success Failure:(FailureBlock)failure
{
    if( !self.isValid )
        return NO;
    AFHTTPRequestOperationManager * http_request_mgr = [[MyHttpActionManager defaultManager] getHttpRequestMgr];
    if( !http_request_mgr )
        return NO;
    
    
    [http_request_mgr POST:[self get_action_url]
                parameters:self.parameters
 constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSURL * upload_file_url = nil;
         int i = 0;
         for (UIImage *image in _upload_imgArr) {
             if (image) {
                 if( CGSizeEqualToSize(self.upload_image_max_size, CGSizeZero) )
                 {
                     upload_file_url = [LUnity createTempImageUploadFile:image];
                 }
                 else
                 {
                     upload_file_url = [LUnity createTempImageUploadFile:image WithMaxSize:self.upload_image_max_size];
                 }
                 if( upload_file_url )
                 {
                     [formData appendPartWithFileURL:upload_file_url name:_upload_image_param_nameArr[i] error:nil];
                     [_upload_file_url_Arr addObject:upload_file_url];
                 }
             }
             i++;
         }
         
     }
                   success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         for (NSURL *upload_file_url in _upload_file_url_Arr) {
             if( upload_file_url )
             {
                 [[NSFileManager defaultManager] removeItemAtURL:upload_file_url error:nil];
             }
             
         }
         
         success( self , responseObject , operation );
     }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         for (NSURL *upload_file_url in _upload_file_url_Arr) {
             if( upload_file_url )
             {
                 [[NSFileManager defaultManager] removeItemAtURL:upload_file_url error:nil];
             }
             
         }
         
         failure( self , error , operation );
     }];
    
    return YES;
    
}

@end

@implementation MyActionDeleteBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure
{
    if( !self.isValid )
        return NO;
    AFHTTPRequestOperationManager * http_request_mgr = [[MyHttpActionManager defaultManager] getHttpRequestMgr];
    if( !http_request_mgr )
        return NO;
    
    [http_request_mgr DELETE:[self get_action_url] parameters:self.parameters
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         success( self , responseObject , operation );
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         failure( self , error , operation );
                     }];
    return YES;
}


@end
