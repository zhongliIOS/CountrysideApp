//
//  AppDelegate.m
//  small_douApp
//
//  Created by zhongli on 15/6/10.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "AppDelegate.h"
#import "GetAreasAction.h"
#import "CountryTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

   [self getAreaInfo];
   [self isHasAutoLogin];
    
    CountryTabBarController *vc = [[CountryTabBarController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBarHidden = YES;
    self.window.rootViewController = navi;
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

-(void)getAreaInfo
{
    GetAreasAction *act = [[GetAreasAction alloc]init];
    [act DoActionWithSuccess:^(MyActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
     
    MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSArray *arr = [result try_get_data_with_array];
            if (arr) {
                AreaInfo *m = [AreaInfo areaInfo];
                m.dataArray = arr;
            }
        }
    
    } Failure:^(MyActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
       NSLog(@"%@",operation.responseObject);
     }];
}

-(void)isHasAutoLogin
{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:My_phone];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:My_token];
    if (!phone||!token) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    [manager GET:[NSString stringWithFormat:@"/customers/%@.json",phone] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        if (dic[@"id"]) {
            MyInfo *m = [MyInfo defaultMyInfo];
            [m initWithModel:dic];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
