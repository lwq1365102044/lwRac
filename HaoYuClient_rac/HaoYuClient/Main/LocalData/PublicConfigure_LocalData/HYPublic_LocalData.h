//
//  HYPublic_LocalData.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYCityModel.h"
@interface HYPublic_LocalData : NSObject

+ (instancetype)share;
/**
 是否是新安装此版本
 */
@property(nonatomic,assign) BOOL isFristInstall;

/**
 保存当前版本号
 */
- (void)saveCurrentVersionNumber;

/**
 城市列表 (HYCityModel 数组) 组头
 */
@property (nonatomic, strong) NSArray * cityDatas;
/**
 城市组列表 （HYCityGroupModel 数组）
 */
@property (nonatomic, strong) NSArray * cityGroupDatas;

/**
 定位 到的城市 数据模型
 */
@property (nonatomic, strong) HYCityGroupModel * location_City_M;
/**
 上次定位到的城市 数据模型
 */
@property (nonatomic, strong) HYCityGroupModel * last_location_City_M;
/**
 默认的城市（北京市） 数据模型
 */
@property (nonatomic, strong) HYCityGroupModel * default_location_City_M;

@property (nonatomic, strong) NSString * location_City;
@property (nonatomic, strong) NSString * location_City_Id;

//根据城市ID 获取的区域列表数据
@property (nonatomic, strong) NSArray * QuYu_ByCityId_Arr_M;

/**
 付款方式 mark data : [{}]
 */
@property (nonatomic, strong) NSArray * payTypeMarkArray;

//删除全局数据
- (void)deleGlobalDatas;

/**
 是否有 新的未读消息
 */
@property (nonatomic, assign) BOOL isHaveNewMsg;

/**
 是否定位成功，是否能够开启地图导航
 */
@property (nonatomic, assign) BOOL isSucessLoaction;

/**
 优惠券匹配 Mark {"mark":""}
 */
@property (nonatomic, strong) NSDictionary * payTypeMarkDictionary;


@property (nonatomic, strong) NSString * currentBaseURL;

@end


