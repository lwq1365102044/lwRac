//
//  SOAComponentAppDelegate.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWComponentAppDelegate : NSObject

+ (instancetype)share;
/**
 获取所有的组件服务
 */
- (NSMutableArray *)services;

@end
