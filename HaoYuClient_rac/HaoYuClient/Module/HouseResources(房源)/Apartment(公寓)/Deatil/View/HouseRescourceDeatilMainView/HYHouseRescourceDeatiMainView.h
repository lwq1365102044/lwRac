//
//  HYHouseRescourceDeatiMainView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYPictureCarouselView.h"
/**
 点击户型  为0时 点击的更多
 */
typedef void(^clickHuXingBlock)(NSInteger row);
@interface HYHouseRescourceDeatiMainView : HYBaseView
@property (nonatomic, strong) HYPictureCarouselView * ImageScrollView;
@property (nonatomic, copy) clickHuXingBlock  clickHuxingBlock;

@end
