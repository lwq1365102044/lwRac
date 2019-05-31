//
//  HYStringKeyConst.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYStringKeyConst : NSObject
/**
 保存当前版本号 便于比较是否显示版本新特性
 */
UIKIT_EXTERN NSString * const CURRENTVERSIONNUMBER_STRINGKEY;

/**
 保存在本地的token
 */
UIKIT_EXTERN NSString *const USER_TOKEN_KEY;

#pragma ----------个人信息 ----------
UIKIT_EXTERN NSString *const USER_INFOR_NAME;
UIKIT_EXTERN NSString *const USER_INFOR_QIANMING;
UIKIT_EXTERN NSString *const USER_INFOR_PHONE;
UIKIT_EXTERN NSString *const USER_INFOR_MAIL;
UIKIT_EXTERN NSString *const USER_INFOR_USERID;
UIKIT_EXTERN NSString *const USER_INFOR_HEADERICON_URL;
UIKIT_EXTERN NSString *const USER_HEADER_ICON;
UIKIT_EXTERN NSString *const USER_NOLGOIN_COLLECTIDS;//收藏
UIKIT_EXTERN NSString *const USER_INFOR_PASSWORD_KEY;//密码

/**
 用户合同信息（模型数组）
 */
UIKIT_EXTERN NSString *const USER_HETONGMODEL_INFOR;

/**
 是否有未读消息
 */
UIKIT_EXTERN NSString *const ISHAVENOTLOOKMESSAGE;
/**
 消息的最新的消息ID
 */
//UIKIT_EXTERN NSString *const MESSAGELASTNEWID;
/**
 设置消息推送时的账号标签
 */
UIKIT_EXTERN NSString *const MESSAGE_TAGS_KEYS;
/**
 记录上次更新消息的时间
 */
UIKIT_EXTERN NSString *const SAVE_DB_MESSAGE_LAST_UPDATE_DATE;

/**
 记录当前的所有连接的服务器类型
 */
UIKIT_EXTERN NSString *const SAVE_CURRENT_SERVICETYPE_KEY;

@end
