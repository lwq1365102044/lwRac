//
//  SOAComponentAppDelegate.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "LWComponentAppDelegate.h"
#import <objc/message.h>
@interface LWComponentAppDelegate ()
{
    NSMutableArray * AllServices;
}
@end

@implementation LWComponentAppDelegate
+ (instancetype)share
{
    static LWComponentAppDelegate *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWComponentAppDelegate alloc] init];
        instance->AllServices = [[NSMutableArray alloc] init];
    });
    return instance;
}

/**
 添加到服务源中
 */
- (void)registerWithService:(NSString *)service
{
    Class service_class =  NSClassFromString(service);
    if (service_class) {
        NSObject *objc = [[service_class alloc] init];
        if (![AllServices containsObject:objc]) {
            [AllServices addObject:objc];
        }
    }
}

/**
 注册所有的服务
 */
- (void)registerServices
{
    if (AllServices.count != 0) {
        return;
    }
    NSArray *servicesArray = [[NSArray alloc] initWithObjects:
                              @"LWRemotePushService",
                              @"LWPayMentService",
                              @"LWKeplerService",
                              nil];
    for (NSString *service in servicesArray) {
        [self registerWithService:service];
    }
}

/**
 获取所有的服务
 */
- (NSMutableArray *)services
{
    [self registerServices];
    return AllServices;
}

@end
