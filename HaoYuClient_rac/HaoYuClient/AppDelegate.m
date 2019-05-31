//
//  AppDelegate.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HYBaseTabBarController.h"
#import "HYThirdManager.h"
#import "YBNewVersionFeaturesViewController.h"
#import "WXApi.h"
#import "HYPayMentManager.h"
#import "HYRequstGlobalDataTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "HYKeplerManager.h"
#import "LWJpushManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 11.0, *)){
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    [HYThirdManager registerThird:launchOptions];
    [self loadRootViewController];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [LWJpushManager.share lw_registerDeviceTokenFotJpushWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [LWJpushManager.share lw_registerFailForRemoteNotificationsWithError: error];
}

/**
 *  加载根控制器
 */
- (void)loadRootViewController {
    _window                                     = [[UIWindow alloc] initWithFrame:SCREEN_RECT];
    HYBaseTabBarController *tabBarController    = [[HYBaseTabBarController alloc] init];
    if ([[HYPublic_LocalData share] isFristInstall]) {
        [_window setRootViewController:[[YBNewVersionFeaturesViewController alloc]init]];
    }else{
        [_window setRootViewController:tabBarController];
    }
    [_window makeKeyAndVisible];
    [self handleGlogbalDatas];
}

#pragma mark -----------支付回调--------------
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果result = %@",resultDic);
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            //解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [WXApi handleOpenURL:url delegate:[HYPayMentManager shareManager]];
    }else if([url.absoluteString containsString:[NSString stringWithFormat:@"sdkback%@",KEPLER_APP_KEY]])
    {
         [HYKeplerManager handleOpenURL:url];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果result = %@",resultDic);
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            POST_NOTI(@"getAlipayResultNotiName", resultDic);
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [WXApi handleOpenURL:url delegate:[HYPayMentManager shareManager]];
    }else if([url.absoluteString containsString:[NSString stringWithFormat:@"sdkback%@",KEPLER_APP_KEY]])
        {
            [HYKeplerManager handleOpenURL:url];
        }
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    BOOL haveJDKeplerServiceNewContent = NO;
    [self fetchJDKeplerService:&haveJDKeplerServiceNewContent];
    if (haveJDKeplerServiceNewContent){
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}  
//（可选）
- (void)fetchJDKeplerService:(BOOL *)paramFetchedJDKeplerNewContent {
    [[KeplerApiManager sharedKPService] checkUpdate]; //检测更新
}

/**
 删除全局数据
 */
- (void)handleGlogbalDatas
{
    [[HYPublic_LocalData share] deleGlobalDatas];
    HYRequstGlobalDataTool *tool = [[HYRequstGlobalDataTool alloc] init];
    [tool requestCityData];
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    LWLog(@"\n\n************清理图片缓存************\n\n")
}


#pragma mark - Core Data stack

@end
