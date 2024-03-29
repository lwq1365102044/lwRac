//
//  HYHouseRescourcesModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYHuXingInforModel.h"
#import "HYpicObjModel.h"

@interface hiCityModel :HYBaseModel
@property (nonatomic, copy) NSString * quan;
@property (nonatomic, copy) NSString * cityCode;
@property (nonatomic, copy) NSString * name;
//id
@property (nonatomic, copy) NSString * jian;

@end

@interface sheshiArrModel: HYBaseModel
//1存在；0不存在
@property (nonatomic, copy) NSString * isHave;
//基础设施名称
@property (nonatomic, copy) NSString * name;
//id 基础设施id
//icon地址
@property (nonatomic, copy) NSString * iconUrl;
//基础设施种类
@property (nonatomic, copy) NSString * type;

@end










@interface HYHouseRescourcesModel : HYBaseModel

@property (nonatomic, copy) NSString * itemName;
@property (nonatomic, copy) NSString * roomTypeCount;
@property (nonatomic, copy) NSString * houseItemAddress;
//@property (nonatomic, copy) NSString * minRent;
@property (nonatomic, copy) NSString * iosDedicated;

@property (nonatomic, copy) NSString * houseCount;
@property (nonatomic, strong) HYpicObjModel * picObjcModel;
// id
//项目状态：1正常营业，2暂停业，3停业，4筹建中
@property (nonatomic, assign) NSInteger itemStatus;
//可租房间数
@property (nonatomic, assign) NSInteger kezuNum;

#pragma ---------------房源详情 deatil--------------
//区域id
@property (nonatomic, copy) NSString * hiAreaId;
//图片数组
@property (nonatomic, strong) NSArray * picArrModel;
//经度
@property (nonatomic, copy) NSString * lng;
//纬度
@property (nonatomic, copy) NSString * lat;

//是否删除-0:删除,1:有效,-1:彻底删除
@property (nonatomic, strong) NSString * isDelete;
@property (nonatomic, copy) NSString * gcid;
//部门id
@property (nonatomic, copy) NSString * departmentId;
//设施对象
@property (nonatomic, strong) NSArray * sheshiArrModel;
//门店电话
@property (nonatomic, copy) NSString * mendianPhone;
//门店描述
@property (nonatomic, copy) NSString * hiItemDesc;
/*
 {
"name": "海淀",
"id": "14"
},
 */
@property (nonatomic, strong) NSDictionary * hiArea;
//项目名称
@property (nonatomic, copy) NSString * hiItemName;

//城市对象
@property (nonatomic, strong) hiCityModel * hiCityModel;

//项目周边描述
@property (nonatomic, copy) NSString * hiZhoubianDesc;
//城市id
@property (nonatomic, copy) NSString * hiCityId;
//项目id

//项目详细地址
@property (nonatomic, copy) NSString * hiDetailedAddress;

@property (nonatomic, strong) NSArray * roomTypeArrModel;

#pragma -------------------预订过程中的房源信息----------------------
//单元
@property (nonatomic, copy) NSString * unit;
//户型名称
@property (nonatomic, copy) NSString * huXing;
//@property (nonatomic, copy) NSString * mianJi;
@property (nonatomic, copy) NSString * iosMianJi;
@property (nonatomic, copy) NSString * fangNo;
@property (nonatomic, copy) NSString * louNo;
@property (nonatomic, copy) NSString * iosRent;


/**
 房间配置
 @[@{@"peizhi":@""}]
 */
@property (nonatomic, strong) NSArray * roomTypePeizhi;
//租金
//@property (nonatomic, copy) NSString * rent;
@property (nonatomic, copy) NSString * chaoXiang;
//项目名称
@property (nonatomic, copy) NSString * houseItemName;
//预计签约时间
@property (nonatomic, copy) NSString * signTime;


/**
 费用
 [{@"waterFl":@""},
 {@"yaJin":@""},
 {@"electricFl":@""}]
 */
@property (nonatomic, strong) NSArray * fee;
//合同模板id
@property (nonatomic, copy) NSString * templateId;
//收订id
@property (nonatomic, copy) NSString * houseShouDingId;

@property (nonatomic, strong) NSString * ruzhuTime;
@property (nonatomic, copy) NSString * zukeName;
@property (nonatomic, copy) NSString * zukePhone;
//集中+分散式微信：1是集中，0不是 默认：1
@property (nonatomic, copy) NSString * isJizhong;
//定金 默认是：1000
@property (nonatomic, copy) NSString * money;

@property (nonatomic, copy) NSString * houseId;
@property (nonatomic, copy) NSString * shi;
@property (nonatomic, copy) NSString * ting;


#pragma --------------根据城市ID 获取的项目列表  地图找房 -----------------
//区域id -- hiAreaId
//项目名称 -- hiItemName
// lng  / lat
//部门id
@property (nonatomic, copy) NSString * deptId;
@property (nonatomic, copy) NSString * itemDesc;


//项目id
// 项目电话 -- mendianPhone
//项目地址 -- hiDetailedAddress

#pragma  ------------- 地图找房 ---------
///最高租金
//@property (nonatomic, copy) NSString * maxRent;
@property (nonatomic, copy) NSString * iosMaxRent;
@property (nonatomic, copy) NSString * iosMinRent;

///最低租金
//@property (nonatomic, copy) NSString * minRent;

#pragma  ------------- 签约 ---------
//是否是来自预定 的 签约
@property (nonatomic, assign) BOOL isFramYuDingBool;

#pragma  ------------- 提前预定 ---------
//可租时间 2018年12月25日13:45:58
@property (nonatomic, strong) NSString * kezuTime;
//房间状态 状态: 10：待配置，11：配置中，20：空置，30：预订，40：已租，50：正常退，51：非正常退，60：无效
@property (nonatomic, assign) NSInteger  houseStatus;
//是否提前预定： 1、是 2、否 上行参数
@property (nonatomic, copy) NSString * bookInAdvance;

#warning ++++
@property (nonatomic, strong) UIImage * houseImg_test;



@end
