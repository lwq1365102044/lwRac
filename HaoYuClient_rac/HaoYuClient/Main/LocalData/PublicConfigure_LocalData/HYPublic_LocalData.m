//
//  HYPublic_LocalData.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYPublic_LocalData.h"
#import "HYQuYuModel.h"
#import "HYBaseUrlUtils.h"
#define  BEIJING_CITYID @"d94bba14-dec1-11e5-bcc3-00163e1c066c"
@implementation HYPublic_LocalData
+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static HYPublic_LocalData *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HYPublic_LocalData alloc]init];
        
        HYCityGroupModel *citymodel = [[HYCityGroupModel alloc] init];
        citymodel.cityID = BEIJING_CITYID;
        citymodel.name = @"北京市";
        instance.default_location_City_M = citymodel;
    });
    return instance;
}

/**
 保存当前版本号
 */
- (void)saveCurrentVersionNumber
{
    NSString *current = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [SYSTEM_USERDEFAULTS setObject:current forKey:CURRENTVERSIONNUMBER_STRINGKEY];
}

/**
 是否是新安装此版本
 */
- (BOOL)isFristInstall
{
    NSString *currentVersionNumber = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *lastVersionNumber = [SYSTEM_USERDEFAULTS objectForKey:CURRENTVERSIONNUMBER_STRINGKEY];
    if ([currentVersionNumber isEqualToString:lastVersionNumber]) {
        return NO;
    }
    return YES;
}

- (NSString *)location_City_Id
{
    _location_City_Id = _location_City_M.cityID;
    if (!_location_City_Id) {
        if (!_cityGroupDatas || _cityGroupDatas.count == 0) {
            return BEIJING_CITYID;
        }
        for (HYCityGroupModel *city_m in _cityGroupDatas) {
            if ([_location_City isEqualToString:city_m.name]) {
                [self updateLoca_info:city_m];
                return _location_City_Id;
            }
        }
        for (HYCityGroupModel *city_m in _cityGroupDatas) {
            if ([city_m.name isEqualToString:@"北京市"]) {
                [self updateLoca_info:city_m];
                return _location_City_Id;
            }
        }
        [self updateLoca_info:_cityGroupDatas.firstObject];
        return _location_City_Id;
    }
    return _location_City_Id;
}

- (void)updateLoca_info:(HYCityGroupModel *)city_m
{
    _location_City_M = city_m;
    _location_City = city_m.name;
    _location_City_Id = city_m.cityID;
}

- (NSArray *)QuYu_ByCityId_Arr_M
{
    HYQuYuModel *quyu_M =  _QuYu_ByCityId_Arr_M.firstObject;
    if ([quyu_M.cityName isEqualToString:_location_City]) {
        
        return _QuYu_ByCityId_Arr_M;
    }else{
        return nil;
    }
    return nil;
}

- (void)setLocation_City_M:(HYCityGroupModel *)location_City_M
{
    _location_City_M = location_City_M;
    if(_location_City_M) _last_location_City_M = location_City_M;
}

- (HYCityGroupModel *)last_location_City_M
{
    if (_last_location_City_M) {
        return  _last_location_City_M;
    }else{
        return _default_location_City_M;
    }
}

//删除全局数据
- (void)deleGlobalDatas
{
    self.cityDatas = nil;
    self.cityGroupDatas = nil;
    self.location_City_M = nil;
    self.location_City_Id = nil;
    [HYUserInfor_LocalData share].isReHT_SuccessBooL = NO;
    [SYSTEM_USERDEFAULTS setBool:NO forKey:ISHAVENOTLOOKMESSAGE];
}

/**
 是否有 新的未读消息
 */
- (BOOL)isHaveNewMsg
{
    return [SYSTEM_USERDEFAULTS boolForKey:ISHAVENOTLOOKMESSAGE];
}

- (NSString *)currentBaseURL
{
    if (!_currentBaseURL) {
        _currentBaseURL = [[HYBaseUrlUtils alloc] init].currentServiceURL;
    }
    return _currentBaseURL;
}

@end
