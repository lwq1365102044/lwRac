//
//  HYRequstGlobalDataTool.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYRequstGlobalDataTool.h"
#import "HYServiceManager.h"
#import "HYCityModel.h"
#import "HYHomePageModel.h"
#import "HYStringTool.h"
#import "HYLocationTool.h"
#import "HYBillModel.h"
#import "HYShuiDianBiaoModel.h"
#import "HYMessageLocalData.h"
@interface HYRequstGlobalDataTool ()

@end

@implementation HYRequstGlobalDataTool
/**
 请求消息信息
 */
- (void)requestMessageInforCallBackBlock:(HYEventCallBackBlock)callBackBlock
                            failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    NSString *user_phone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    if (!user_phone) return;
    PARA_SET(user_phone, @"userPhone");
    PARA_SET(@"ct", @"sortFields");
    PARA_SET(@"desc", @"sortType");
    PARA_SET(@"1", @"pageNo");
    NSString *lastUpdateDate = USERDEFAULTS_GET(SAVE_DB_MESSAGE_LAST_UPDATE_DATE);
    if(lastUpdateDate) PARA_SET(lastUpdateDate, @"queryTime");
    [[HYServiceManager share] postRequestWithurl:MESSAGE_LIST_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        [HYMessageLocalData handleMessageInforDatas:objc isFromMsgPage:_isFromMsgPage];
                                        if(callBackBlock){callBackBlock(objc);}
                                    } failureBlock:^(id error, id requestInfo) {
                                        if(failureBlock){failureBlock(error);}
                                    }];
}

/**
 获取合同信息
 */
- (void)requestUserHeTongInfor
{
    if ([HYUserInfor_LocalData share].isReHT_SuccessBooL) {
        return;
    }
    
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    [[HYServiceManager share] postRequestWithurl:GET_MINEHETONGLISTINFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        NSArray *dataArr = objc[@"result"][@"list"];
                                        [[HYUserInfor_LocalData share] saveHeTongInfor:dataArr];
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

/**
 获取城市列表数据
 */
- (void)requestCityData
{
    NSArray *city_ar = [HYPublic_LocalData share].cityGroupDatas;
    if (city_ar && city_ar.count > 0) {
        return;
    }
    [[HYServiceManager share] postRequestWithurl:HAVEHOUSE_CITY_LIST_INFOR_URL
                                       paramters:nil
                                    successBlock:^(id objc, id requestInfo) {
                                        NSArray *dataArray = objc[@"result"][@"list"];
                                        [self handleCityDatas:dataArray];
                                        [self handleCitySeaction];
                                        
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

- (void)handleCityDatas:(NSArray *)cityArrary
{
    if (!cityArrary) {
        return;
    }
    NSMutableArray *temp_cityGroup = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in cityArrary) {
        HYCityGroupModel *cityGroupModel = [HYCityGroupModel modelWithJSON:dict];
        [temp_cityGroup addObject:cityGroupModel];
    }
    [HYPublic_LocalData share].cityGroupDatas = temp_cityGroup;
    POST_NOTI(@"alearlyGetCitData", nil);
}

/**
 处理 组头
 */
- (void)handleCitySeaction
{
    NSMutableArray *temp_City = [[NSMutableArray alloc] init];
    NSArray *cityGroupArrary = HYPublic_LocalData.share.cityGroupDatas;
    if (!cityGroupArrary) {
        return;
    }
    for (HYCityGroupModel *cityGroupModel  in cityGroupArrary) {
        NSString *firstChara =  [[HYStringTool share] firstCharactorWithString:cityGroupModel.name];
        
        
        BOOL tempBool = NO;
        NSMutableArray *groupArrary = [[NSMutableArray alloc] init];
        for (HYCityModel *cityModle in temp_City) {
            if (cityModle.fristChara && [cityModle.fristChara isEqualToString:firstChara]) {
                [groupArrary addObjectsFromArray:cityModle.cityGroup];
                [groupArrary addObject:cityGroupModel];
                tempBool = YES;
                cityModle.cityGroup = groupArrary;
                break;
            }
        }
        if (!tempBool) {
            HYCityModel *cityModle = [[HYCityModel alloc] init];
            cityModle.fristChara = firstChara;
            [groupArrary addObject:cityGroupModel];
            cityModle.cityGroup = groupArrary;
            [temp_City addObject:cityModle];
        }
    }
    //根据房间号对数组内的对象进行排序
    NSArray *tem_paixu =  [temp_City sortedArrayUsingComparator:^NSComparisonResult(HYCityModel * obj1, HYCityModel * obj2) {
        if ([obj1.fristChara compare:obj2.fristChara options:(NSCaseInsensitiveSearch)] == NSOrderedDescending) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    [HYPublic_LocalData share].cityDatas = tem_paixu;
}

/**
 获取个人信息
 */
- (void)requestUserInforCallBackBlock:(HYEventCallBackBlock)callBackBlock fail:(HYEventCallBackBlock)failBlock
{
    PARA_CREART;
    NSString *token = USERDEFAULTS_GET(USER_TOKEN_KEY);
    if (!token) {
        return;
    }
    [[HYServiceManager share] postRequestWithurl:GETMINEMAININFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
//                                        LWLog(@"++++++++++++%@++++++%@",objc,requestInfo);
                                        NSDictionary *result = objc[@"result"];
                                        [[HYUserInfor_LocalData share] saveUser_InforOfUserInfo:result];
                                        if(callBackBlock){callBackBlock(objc);}
                                    } failureBlock:^(id error, id requestInfo) {
                                        if(failBlock){
                                            failBlock(error);
                                        }
                                    }];
}


/**
 获取优惠券的信息
 chengzuId = nil 时 获取到账号下的所有优惠券
 */
- (void)requestDiscountInforWithChengzuId:(NSString *)chengzuId CallBackBlock:(HYEventCallBackBlock)callBackBlock
                             failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    if(chengzuId){PARA_SET(chengzuId, @"chengzuId");}
    NSString *userId = USERDEFAULTS_GET(USER_INFOR_USERID);
    if(userId) PARA_SET(userId, @"userId");
    NSString *phone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    if(phone) PARA_SET(phone, @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GETCANUSEDISCOUNT_LIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          callBackBlock(objc[@"result"][@"list"]);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 计算优惠金额
 */
- (void)requestMoneyWhenUseDiscountDikouWithjson:(NSArray *)json
                                   CallBackBlock:(HYEventCallBackBlock)callBackBlock
                                    failureBlock:(HYEventCallBackBlock)failureBlock {
    PARA_CREART;
    if (json) {PARA_SET(json, @"json")}
    LWLog(@"\n+++++++++++计算优惠金额para:%@",para);
    [[HYServiceManager share] postRequestAnWithurl:GET_USEDISCOUNT_DIKOU_MONEY_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n+++++++++++计算优惠金额objc:%@",objc);
                                          callBackBlock(objc[@"result"]);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 获取支付水电费优惠券
 houseId    房间id
 money      充值金额
 userId     登录人账号
 */
- (void)requestDiscountInforForRechargeWithHouseId:(NSString *)houseId
                                             money:(NSString *)money
                                     CallBackBlock:(HYEventCallBackBlock)callBackBlock
                                      failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    if (houseId) {PARA_SET(houseId, @"houseId");}
    if (money) {PARA_SET(money, @"money");}
    NSString *userId = USERDEFAULTS_GET(USER_INFOR_USERID);
    if(userId) PARA_SET(userId, @"userId");
    PARA_SET(@"3", @"type");
    NSString *phone = USERDEFAULTS_GET(USER_INFOR_PHONE);
    if(phone) PARA_SET(phone, @"phone");
    LWLog(@"\n+++++++++++获取支付水电费优惠券para:%@",para);
    [[HYServiceManager share] postRequestAnWithurl:GETCANUSEDISCOUNT_LIST_INFOR_FOR_RECHARGE_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          callBackBlock(objc[@"result"][@"list"]);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 账单中的列表信息 （待付款账单，缴费详情中的账单）
 callBackBlock  排序好的模型数组
 */
- (void)requestBillOfNoPayWithindentChengzuId:(NSString *)indentChengzuId
                                CallBackBlock:(HYEventCallBackBlock)callBackBlock
                                 failureBlock:(HYEventCallBackBlock)failureBlock
{
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    if(indentChengzuId) PARA_SET(indentChengzuId, @"indentChengzuId");
    PARA_SET(@"1", @"indentType");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEBILLLISTINFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          
                                          NSMutableArray *datasMutableArray = [[NSMutableArray alloc] init];
                                          NSArray *temp = objc[@"result"][@"list"];
                                          NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
                                          for (NSDictionary *dict in temp) {
                                              HYBillModel *billModel = [HYBillModel modelWithJSON:dict];
                                              NSMutableArray *lastItems ;
                                              NSMutableArray *items = [NSMutableArray array];
                                              lastItems = dataDict[billModel.beginTime];
                                              if (lastItems != nil && lastItems.count > 0) {
                                                  items = lastItems;
                                                  if(billModel.discUseType == DISCOUNT_FANGZU_TYPE){
                                                      [items insertObject:billModel atIndex:0];
                                                  }else{
                                                      [items addObject:billModel];
                                                  }
                                              }else{
                                                  [items addObject:billModel];
                                              }
                                              [dataDict setValue:items forKey:billModel.beginTime];
                                          }
                                          NSArray *allVaules = dataDict.allValues;
                                          [datasMutableArray addObjectsFromArray:allVaules];
                                          
                                          if (datasMutableArray.count == 0 || datasMutableArray == nil) {
                                              callBackBlock(nil);
                                              return;
                                          }
                                          //排序
                                          for (int i = 0 ; i < datasMutableArray.count; i++) {
                                              for (int j = 0  ; j < datasMutableArray.count - 1 - i; j++) {
                                                  NSArray *ar0 = datasMutableArray[j];
                                                  NSArray *ar1 = datasMutableArray[j+1];
                                                  HYBillModel *model0 = ar0.firstObject;
                                                  HYBillModel *model1 = ar1.firstObject;
                                                  if ([model0.beginTime compare:model1.beginTime options:NSCaseInsensitiveSearch] == NSOrderedDescending) {
                                                      NSArray *temp = datasMutableArray[j];
                                                      datasMutableArray[j] = datasMutableArray[j+1];
                                                      datasMutableArray[j+1] = temp;
                                                  }
                                              }
                                          }
                                          callBackBlock(datasMutableArray);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}

/**
 获取充值记录列表
 param : NSString    @{@"id":@""}   电
 : NSArray     @{@"ids":@[]}  冷水/热水
 surfaceType:   1 水； 2 电
 */
- (void)getRechargreRecordInforListWithParam:(id)param
                                 surfaceType:(NSInteger)surfaceType
                               CallBackBlock:(HYEventCallBackBlock)callBackBlock
                                failureBlock:(HYEventCallBackBlock)failureBlock
{
    if (!param) return;
    PARA_CREART;
    NSString *url = RECHARFEFOR_DIAN_RECORDLIST_URL;
    if (surfaceType == 2) {
        if(param) PARA_SET(param,@"id");
    }else if (surfaceType == 1){
        if(param) PARA_SET(param,@"ids");
        url = RECHARFEFOR_SHUI_RECORDLIST_URL;
    }
    [[HYServiceManager share] postRequestAnWithurl:url
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"objec:%@",objc);
                                          NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                                          NSDictionary *result = objc[@"result"];
                                          if ([result isKindOfClass:[NSString class]]) return ;
                                          NSArray *info = result[@"list"];
                                          if ([info isKindOfClass:[NSArray class]]) {
                                              for (NSDictionary *dic in info) {
                                                  HYRechargeRecordListInforModel *record =   [HYRechargeRecordListInforModel modelWithJSON:dic];
                                                  record.surfaceType = surfaceType;
                                                  [dataArray addObject:record];
                                              }
                                          }
                                          callBackBlock(dataArray);
                                      } failureBlock:^(id error, id requestInfo) {
                                          failureBlock(error);
                                      }];
}


@end