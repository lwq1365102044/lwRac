//
//  HYBillModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/6.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface houseItemModel : HYBaseModel
@property (nonatomic, strong) NSString * hiItemName;
//@property (nonatomic, copy) NSString * customId;
@property (nonatomic, copy) NSString * departId;
@end

@interface houseModel : HYBaseModel
@property (nonatomic, copy) NSString * louNo;
@property (nonatomic, copy) NSString * houseItemId;
@property (nonatomic, copy) NSString * customID;
@property (nonatomic, strong) NSString * fangNo;
@end

@interface typeModel : HYBaseModel
@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) NSString * mark;

@end

@interface HYBillModel : HYBaseModel
@property (nonatomic, strong) NSString * beginTime;
@property (nonatomic, strong) NSString * endTime;
//@property (nonatomic, strong) NSString * money;
//替换money
@property (nonatomic, copy) NSString * iosDedicated;



@property (nonatomic, strong) NSDictionary * house;
@property (nonatomic, strong) NSDictionary * houseItem;
@property (nonatomic, strong) NSDictionary * type;

@property (nonatomic, strong) houseModel * houseModel;
@property (nonatomic, strong) houseItemModel * houseItemModel;
@property (nonatomic, strong) typeModel * typeMdodel;

@property (nonatomic, copy) NSString * roomTypePic;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * deptId;

/**
 对应的是优惠券的使用类型
 */
@property (nonatomic, assign) HYDiscountUseType discUseType;

@property (nonatomic, strong) NSArray * selectDiscModels;

@property (nonatomic, assign) BOOL cellIsSelect;

@end
