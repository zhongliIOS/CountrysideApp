//
//  MyActionBase.h
//  small_douApp
//
//  Created by zhongli on 15/6/30.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyHttpActionManager.h"

@class MyActionBase;
typedef void (^SussessBlock)(MyActionBase *action, id responseObject , AFHTTPRequestOperation *operation );
typedef void (^FailureBlock)(MyActionBase *action, NSError *error , AFHTTPRequestOperation *operation );

@interface MyActionBase : NSObject



@property (nonatomic,assign)    BOOL    isValid;

@property (nonatomic,retain)    NSMutableDictionary *parameters;

-(id) initWithActionURLString:(NSString *) str_url;

-(NSString *) get_action_url;
- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end


@interface MyActionGetBase : MyActionBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end

@interface MyActionPostBase : MyActionBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end

/**
 *  http post 动作并且能够上传一张图片
 */
@interface MyActionPostWithSingleImageBase : MyActionBase

@property (nonatomic,retain) NSString * upload_image_param_name;
@property (nonatomic,retain) UIImage * upload_image;
@property (nonatomic,assign) CGSize    upload_image_max_size;

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end

/**
 * http post 动作并且能够上传多张图片
 */
@interface MyActionPostWithManyImageBase : MyActionBase

@property (nonatomic,strong) NSArray * upload_image_param_nameArr;
@property (nonatomic,strong) NSArray * upload_imgArr;
@property (nonatomic,assign) CGSize    upload_image_max_size;

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end


/**
 *  http delete 动作
 */
@interface MyActionDeleteBase : MyActionBase

- (BOOL) DoActionWithSuccess:(SussessBlock) success Failure:(FailureBlock) failure;

@end



