//
//  HYHeTongYouQiXianView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/20.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYHeTongYouQiXianView : HYBaseView
@property (nonatomic, strong) NSMutableDictionary * param;

/**
 检查参数
 */
- (BOOL)checkParam;
@end
