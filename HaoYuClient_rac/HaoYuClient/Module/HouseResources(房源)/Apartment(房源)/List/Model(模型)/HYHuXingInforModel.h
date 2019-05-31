//
//  HYHuXingInforModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/13.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYpicObjModel.h"

///**
// 户型详情中 朝向
// */
//@interface chaoxiang :HYBaseModel
//@property (nonatomic, copy) NSString * chaoxiang;
//@end


/**
 项目对象
 */
@interface itemJsonModel : HYBaseModel
//项目名称
@property (nonatomic, copy) NSString * hiItemName;
//经度
@property (nonatomic, copy) NSString * lng;
//部门id
@property (nonatomic, copy) NSString * deptId;
//项目id
//门店电话
@property (nonatomic, copy) NSString * mendianPhone;
//纬度
@property (nonatomic, copy) NSString * lat;
//项目详细地址
@property (nonatomic, copy) NSString * hiDetailedAddress;

@end


//
@interface zhuangXiuModel : HYBaseModel
@property (nonatomic, copy) NSString * key;
// id customId
@end



//户型对象
@interface huXingModel : HYBaseModel
//字典id customId
//字典类型标识
@property (nonatomic, copy) NSString * mark;
@property (nonatomic, copy) NSString * key;
@end



@interface HYHuXingInforModel : HYBaseModel
//项目详细地址
@property (nonatomic, copy) NSString * houseItemAddress;

//户型对象
@property (nonatomic, strong) huXingModel * huxingModel;

@property (nonatomic, strong) zhuangXiuModel * zhuangXiuModel;

//公司编码
@property (nonatomic, copy) NSString * gcid;
//户型名称
@property (nonatomic, copy) NSString * roomTypeName;
//项目id
@property (nonatomic, copy) NSString * houseItemId;
//户型id
@property (nonatomic, copy) NSString * huXingId;
//装修id
@property (nonatomic, copy) NSString * zhuangXiuId;
//房型介绍
@property (nonatomic, copy) NSString * roomTypeIntro;
//最低租金
//@property (nonatomic, copy) NSString * minZujin;
@property (nonatomic, copy) NSString * iosMinZujin;

//最大租金
//@property (nonatomic, copy) NSString * maxZujin;
@property (nonatomic, copy) NSString * iosMaxZujin;

//室
@property (nonatomic, copy) NSString * shi;
//最高租金
//@property (nonatomic, copy) NSString * maxMianji;
@property (nonatomic, copy) NSString * iosMaxMianji;

//厅
@property (nonatomic, copy) NSString * ting;

//图片对象
@property (nonatomic, strong) HYpicObjModel * picObjModel;

/**
 户型详情中 门店联系方式
 */
@property (nonatomic, copy) NSString * itemPhone;

//户型id  customId

//出租价
@property (nonatomic, copy) NSString * rentPrice;
//最小面积
//@property (nonatomic, copy) NSString * minMianji;
@property (nonatomic, copy) NSString * iosMinMianji;

@property (nonatomic, copy) NSString * iosRoomTypeArea;


//图片集合
@property (nonatomic, copy) NSString * pics;
//面积
//@property (nonatomic, copy) NSString * mianji;
//收藏状态：1已收藏、0未收藏
@property (nonatomic, copy) NSString * collectionStatus;
//门店联系方式
@property (nonatomic, copy) NSString * mendianPhone;

@property (nonatomic, copy) NSString * collectionId;

//户型详情中新增 预约预定需要
@property (nonatomic, copy) NSString * itemName;
@property (nonatomic, copy) NSString * itemId;


//项目状态：1正常营业，2暂停业，3停业，4筹建中 2018年11月13日14:15:32
@property (nonatomic, assign) NSInteger itemStatus;
//可租房间数 2018年11月13日14:15:35
@property (nonatomic, assign) NSInteger kezuNum;

//------------户型 列表

//房型面积
//@property (nonatomic, strong) NSString * roomTypeArea;

//项目对象
@property (nonatomic, strong) itemJsonModel * itemModel;

@property (nonatomic, copy) NSString * minPrice;


@property (nonatomic, strong) NSArray * roomTypePeizhi;
@property (nonatomic, strong) NSArray * chaoxiang;

//户型详情中的图片
@property (nonatomic, strong) NSArray * picsModel;
/**
 户型图
 */
@property (nonatomic, copy) NSString * housePlan;


@end

