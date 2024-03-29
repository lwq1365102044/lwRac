//
//  HYMessageModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMessageModel : HYBaseModel

#pragma +++++++++++ 消息列表 +++++++++++++++++

@property (nonatomic, copy) NSString * et;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * etId;
@property (nonatomic, copy) NSString * ct;
@property (nonatomic, assign) NSInteger isDelete;
@property (nonatomic, copy) NSString * userPhone;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * houseId;
@property (nonatomic, copy) NSString * ctId;
@property (nonatomic, assign) NSInteger type;

//@property (nonatomic, copy) NSString * testdate;

@end
