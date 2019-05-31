//
//  HYYuDingXuanFangView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYHouseRescourcesModel.h"
@interface HYYuDingXuanFangView : HYBaseView
@property (nonatomic, copy) HYEventCallBackBlock clickProjectBlock;
@property (nonatomic, copy) HYEventCallBackBlock clickHuxignBlock;
@property (nonatomic, copy) HYEventCallBackBlock clickFangJianHaoBlock;
@property (nonatomic, copy) HYEventCallBackBlock requestHouseInforBlock;

@property (nonatomic, strong) NSMutableDictionary * param;
//项目数据
@property (nonatomic, strong) NSArray * projectDatas;
// 户型数据
@property (nonatomic, strong) NSArray * huxingDatas;

@property (nonatomic, strong) NSArray * fangjianhaoDatas;

/**
 房源信息
 */
@property (nonatomic, strong) HYHouseRescourcesModel * houseInfor_M;
/**
 检查参数是否合法
 */
- (BOOL)isCheckPara;

@property (nonatomic, assign) BOOL isFromYuDing;

/**
 来之户型详情的 预约
 */
- (void)setDatasWhenFromDeatil:(id)dataModel;
@end
