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
#import "LoginViewController.h"
#import "MyAliPayManager.h"
#import "MyWeChatPayManager.h"
#import "PayViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <Google/Analytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

   [self configGoogleAnalytics];
   [self getAreaInfo];
//
//    PayViewController *vc = [[PayViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
//    navi.navigationBarHidden = YES;
//    self.window.rootViewController = navi;
//    [self.window makeKeyAndVisible];
    UIViewController *vc = [[UIViewController alloc]init];
    self.window.rootViewController = vc;
    [self initWindowBackgroundColorwithView:vc.view];
    [self.window makeKeyAndVisible];
    //尝试自动登陆
    [self isHasAutoLogin];
    
    return YES;
}

-(void)configGoogleAnalytics
{
//    // Configure tracker from GoogleService-Info.plist.
//    NSError *configureError;
//    [[GGLContext sharedInstance] configureWithError:&configureError];
//    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
//    

    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-54478999-2"];
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;

    tracker.allowIDFACollection = YES;
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (void)initWindowBackgroundColorwithView:(UIView *)view
{
    UIImage *image;
    if(ScreenH==568){
        image = [UIImage imageNamed:@"Default-568h"];
    }else if(ScreenH==480)
    {
        image = [UIImage imageNamed:@"Default-480h"];
    }
    else{
        image = [UIImage imageNamed:@"Default"];
    }
    view.backgroundColor = [UIColor colorWithPatternImage:image];
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
                m.dataList = [[ObjectList alloc]init];
                for (NSDictionary *dic in arr) {
                    ObjArea *obj = [[ObjArea alloc] initWithDirectory:dic];
                    [m.dataList Add:obj];
                }
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
        [self pushLogin];
        return;
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"access-token"];
    [manager GET:[NSString stringWithFormat:@"/customers/%@.json",phone] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyResponeResult *result = [MyResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]==kServerErrorCode_OK) {
            NSDictionary *dic = [result try_get_data_with_dict];
            MyInfo *m = [MyInfo defaultMyInfo];
            [m initWithModel:dic];
            [self pushTabBarVC];
        }
        else
        {
            [self pushLogin];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [self pushLogin];
    }];

}

-(void)pushLogin
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBarHidden = YES;
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
}

-(void)pushTabBarVC
{
    CountryTabBarController *vc = [[CountryTabBarController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBarHidden = YES;
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor grayColor];
//    [self.window makeKeyAndVisible];

}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            
        }];
        
    }
    
    return YES;
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
