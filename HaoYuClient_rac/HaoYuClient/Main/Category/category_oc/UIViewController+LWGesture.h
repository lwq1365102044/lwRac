//
//  UIViewController+LWGesture.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LWGesture)
+ (void)popGestureClose:(UIViewController *)VC;
+ (void)popGestureOpen:(UIViewController *)VC;
@end
