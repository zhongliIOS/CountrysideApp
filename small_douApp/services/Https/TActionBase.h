//
//  TActionBase.h
//  xuexuecan
//
//  Created by teng.tang on 15/2/13.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ActionsTypeDef.h"
#import "THttpActionMgr.h"

@class TActionBase;

typedef void (^ActionSussessBlock)(TActionBase *action, id responseObject , AFHTTPRequestOperation *operation );
typedef void (^ActionFailureBlock)(TActionBase *action, NSError *error , AFHTTPRequestOperation *operation );

/**
 http 动作基础类
 */
@interface TActionBase : NSObject

-(id) initWithActionURLString:(NSString *) str_url;

-(NSString *) get_action_url;

@property (nonatomic,assign)    BOOL    isValid;

@property (nonatomic,retain)    NSMutableDictionary *parameters;

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end




 /**
 *  http get 动作
 */
@interface TActionGetBase : TActionBase

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end


/**
 *  http post 动作
 */
@interface TActionPostBase : TActionBase

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end

/**
 *  http post 动作并且能够上传一张图片
 */
@interface TActionPostWithSingleImageBase : TActionBase

@property (nonatomic,retain) NSString * upload_image_param_name;
@property (nonatomic,retain) UIImage * upload_image;
@property (nonatomic,assign) CGSize    upload_image_max_size;

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end

/**
 * http post 动作并且能够上传多张图片
 */
@interface TActionPostWithManyImageBase : TActionBase

@property (nonatomic,strong) NSArray * upload_image_param_nameArr;
@property (nonatomic,strong) NSArray * upload_imgArr;
@property (nonatomic,assign) CGSize    upload_image_max_size;

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end


/**
 *  http delete 动作
 */
@interface TActionDeleteBase : TActionBase

- (BOOL) DoActionWithSuccess:(ActionSussessBlock) success Failure:(ActionFailureBlock) failure;

@end