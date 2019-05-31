//
//  HYPayMentManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol payMentResultDelegate<NSObject>
/**
 payMethod    WX / ALI
 code 100 成功！
 outTradeNo  商户交易号
 */
- (void)payMentResultHandleWithpayMethod:(NSString *)payMethod
                                    code:(NSInteger)code
                               errordesc:(NSString *)errordesc;

@end

@interface HYPayMentManager : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<payMentResultDelegate> resultDelegate;

+ (instancetype)shareManager;

- (void)WechatPay:(NSDictionary *)param;

/**
 支付宝支付
 */
- (void)alipayWithorderSign:(NSString *)orderSign;

@end
