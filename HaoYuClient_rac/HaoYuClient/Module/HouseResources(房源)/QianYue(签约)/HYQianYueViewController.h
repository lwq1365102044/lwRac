//
//  HYQianYueViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYQianYueViewController : HYBaseViewController
/**
 先判断是否登录 在选择跳转
 */
+ (void)onLineQianYueViewControllerFrom:(HYBaseViewController *)sourceVc Extend:(id)extend;

@end
