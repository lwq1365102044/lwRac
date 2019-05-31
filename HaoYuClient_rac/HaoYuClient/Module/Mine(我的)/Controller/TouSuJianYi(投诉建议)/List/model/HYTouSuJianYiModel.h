//
//  HYTouSuJianYiModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYTouSuJianYiModel : HYBaseModel
//投诉内容
@property (nonatomic, copy) NSString * repairContent;
//反馈内容
@property (nonatomic, copy) NSString * repairDetail;
@property (nonatomic, copy) NSString * title;
//租客姓名
@property (nonatomic, copy) NSString * customer;
//状态-1待处理 2已派单 3已完成 4 已取消 5已验收
@property (nonatomic, copy) NSString * status;

@property (nonatomic, copy) NSString * customerCalls;
//处理时间
@property (nonatomic, copy) NSString * completionTime;
//投诉id

@property (nonatomic, strong) NSArray * resultPic;
@property (nonatomic, strong) NSArray * picurlArray;

@property (nonatomic, strong) NSString * grade;

@end
