//
//  HYBaseView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseViewController.h"
@interface HYBaseView : UIView
{
    CGFloat MARGIN;
}

@property (nonatomic, strong) HYBaseViewController * viewController;

@property (nonatomic, strong) UIViewController * currentViewController;

//户型详情/签约/预定中的配置图标
- (NSString *)getIconNameWithPeiZhi:(NSString *)peizhi;

/**
 转字符
 */
- (NSString *)toString:(NSString *)str;
/**
 价格区间
 */
- (NSString *)getPriceStr:(NSString *)minAmount max:(NSString *)maxAmount;

@end