//
//  HYYuDingListCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYWaterSurfaceCellView.h"

@interface HYYuDingListCellView : HYWaterSurfaceCellView
@property (nonatomic, strong) HYDefaultLabel * yudingTimeLable;
@property (nonatomic, strong) HYDefaultLabel * zuyueStarTimeLable;
@property (nonatomic, strong) HYDefaultLabel * dingweiLable;
@property (nonatomic, strong) HYBaseView * lineview;
@property (nonatomic, copy) HYEventCallBackBlock  clickFuncBtnBlock;
@property (nonatomic, strong) NSMutableArray * funcBtnArray;
/**
 设置按钮数组 [@“取消”，@“支付”，@“去电”]
 */
- (void)setBtnArray:(NSArray *)array;

@property (nonatomic, strong) UIImageView * yudingtimeIcon;
@property (nonatomic, strong) UIImageView * yuyuestatrtimeIcon;
@property (nonatomic, strong) UIImageView * dingweiIcon;

@end
