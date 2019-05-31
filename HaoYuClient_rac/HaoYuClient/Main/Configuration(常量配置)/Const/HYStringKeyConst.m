//
//  HYStringKeyConst.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYStringKeyConst.h"

@implementation HYStringKeyConst
/**
 保存当前版本号 便于比较是否显示版本新特性
 */
NSString * const CURRENTVERSIONNUMBER_STRINGKEY                        = @"CURRENTVERSIONNUMBER_STRINGKEY";


#pragma ------------------------------------- 个人信息 --------------------------------------
NSString *const USER_TOKEN_KEY                          =  @"USER_TOKEN_KEY";// 保存在本地的token
NSString *const USER_INFOR_NAME                         = @"USER_INFOR_NAME";//用户名
NSString *const USER_INFOR_QIANMING                     = @"USER_INFOR_QIANMING"; //个性签名
NSString *const USER_INFOR_PHONE                        = @"USER_INFOR_PHONE";//用户手机号码
NSString *const USER_INFOR_MAIL                         = @"USER_INFOR_MAIL";//邮箱
NSString *const USER_INFOR_USERID                       = @"USER_INFOR_USERID";//user_id
NSString *const USER_INFOR_HEADERICON_URL               = @"USER_INFOR_HEADERICON_URL";//头像url
NSString *const USER_INFOR_PASSWORD_KEY                 = @"USER_INFOR_PASSWORD_KEY"; //密码
NSString *const USER_HEADER_ICON                        = @"USER_HEADER_ICON";//头像data
NSString *const USER_NOLGOIN_COLLECTIDS                 = @"USER_NOLGOIN_COLLECTIDS";//收藏
/**
 用户合同信息（模型数组）
 */
NSString *const USER_HETONGMODEL_INFOR                 = @"USER_HETONGMODEL_INFOR";
/**
 是否有未读消息
 */
NSString *const ISHAVENOTLOOKMESSAGE                    = @"ISHAVENOTLOOKMESSAGE";

/**
 消息的最新的消息ID
 */
//NSString *const MESSAGELASTNEWID                    = @"MESSAGELASTNEWID";
/**
 设置消息推送时的账号标签
 */
NSString *const MESSAGE_TAGS_KEYS                   = @"MESSAGE_TAGS_KEYS";

/**
 记录上次更新消息的时间
 */
NSString *const SAVE_DB_MESSAGE_LAST_UPDATE_DATE    = @"SAVE_DB_MESSAGE_LAST_UPDATE_DATE";

/**
 记录当前的所有连接的服务器类型
 */
NSString *const SAVE_CURRENT_SERVICETYPE_KEY = @"SAVE_CURRENT_SERVICETYPE_KEY";

@end
