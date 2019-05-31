//
//  HYContractModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/6.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineModel.h"

@interface HYContractModel : HYMineModel
/**
 房型图
 */
@property (nonatomic, strong) NSDictionary * roomTypePic;

/**
 房间号
 */
@property (nonatomic, copy) NSString * houseNo;

/**
 是否集中：0不是,1是
 */
@property (nonatomic, copy) NSString * isJiZhong;

/**
 租金
 */
//@property (nonatomic, copy) NSString * rent;
@property (nonatomic, copy) NSString * iosDedicated;

/**
 是否合租：0不是,1是
 */
@property (nonatomic, copy) NSString * isShared;
/**
 合同id
 */
@property (nonatomic, copy) NSString * chengzuId;

@property (nonatomic, copy) NSString * shi;

@property (nonatomic, copy) NSString * ting;
/**
 租客姓名
 */
@property (nonatomic, copy) NSString * zukeName;

@property (nonatomic, copy) NSString * zukePhone;

@property (nonatomic, copy) NSString * statusStr;

/**
 电表id
 */
@property (nonatomic, copy) NSString * electricityId;
/**
 水表 id
 */
@property (nonatomic, copy) NSString * waterId;
//热水表
@property (nonatomic, copy) NSString * hotWaterId;

//同住人
@property (nonatomic, strong) NSArray * chengZuZuKeList;

@property (nonatomic, strong) NSDictionary * picObj;

/**
合同详情:
 status true number
 状态 0:签署合同、1:交首期款、2:在租中、3:到期退房、4:退回押金
 合同列表：
 status true number
 0:待签字、1:待生效、2:在租中、3:已到期、4:已退租、5:已作废
 */

//项目状态：1正常营业，2暂停业，3停业，4筹建中
@property (nonatomic, copy) NSString * itemStatus;

//支付 2018年12月26日13:56:19
@property (nonatomic, copy) NSString * deptId;

//1是电子 2 是纸质
@property (nonatomic, copy) NSString * isElectron;

/** 父房间的id */
@property (nonatomic, copy) NSString * parentHouseId;

@end
