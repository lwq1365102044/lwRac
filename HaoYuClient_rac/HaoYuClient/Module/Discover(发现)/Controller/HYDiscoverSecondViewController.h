//
//  HYDiscoverSecondViewController.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/27.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseViewController.h"
#import <WebKit/WebKit.h>
@interface HYDiscoverSecondViewController : HYBaseViewController
@property (nonatomic, strong) NSString * nextUrls;
@property (nonatomic, copy) HYEventCallBackBlock gotoBackBlock;

@end
