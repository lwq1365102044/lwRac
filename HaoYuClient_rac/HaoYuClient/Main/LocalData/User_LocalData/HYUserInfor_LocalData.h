//
//  HYUserInfor_LocalData.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "XGPush.h"
@interface HYUserInfor_LocalData : NSObject

+ (instancetype)share;

/**
 如果未登录状态下，跳转登录界面
 如果已经登录，不做操作
 */
+ (void)LoginWithVC:(UIViewController *)VC;

/**
 返回是否登录
 */
- (BOOL)isLogin;
/**
 退出登录
 */
- (void)LoginOut;
/**
 保存登录信息
 */
- (void)saveLoginInfor:(id)info;
/**
 根据获取信息接口
 */
- (void)saveUser_InforOfUserInfo:(id)info;

/**
 保存 个人信息
 */
- (void)saveUser_Info:(id)info;

/**
 本地头像
 */
@property (nonatomic, strong) UIImage * User_HeaderImageData_Local;
///**
// 用户id
// */
//@property (nonatomic, strong) NSString * hy_user_id;
///**
// 登录信息有效性校验值
// */
//@property (nonatomic, strong) NSString * hy_token;
///**
// 头像url
// */
//@property (nonatomic, strong) NSString * hy_headpic_url;
///**
// 用户名
// */
//@property (nonatomic, strong) NSString * hy_user_name;
///**
// 个性签名
// */
//@property (nonatomic, strong) NSString * hy_user_sign;
///**
// 用户手机号码
// */
//@property (nonatomic, strong) NSString * hy_user_phone_number;
///**
// 用户邮箱
// */
//@property (nonatomic, strong) NSString * hy_user_mail;


/**
 异步保存头像
 */
- (void)saveUser_Headericon_Local:(UIImage *)icon;

/**
 为登录时，添加收藏
 */
//- (void)addCollectWithID:(NSString *)ID;
/**
 获取收藏数组
 */
- (NSArray *)getCollectIDs;
/**
 保存合同
 */
- (void)saveHeTongInfor:(NSArray *)hetongInfor;
//该次启动 合同获取成功表示，
@property (nonatomic, assign) BOOL isReHT_SuccessBooL;

//所有的合同列表
- (NSArray *)getHeTongInfor;
/**
 status = 2
 */
@property (nonatomic, strong) NSArray * getHeTong2Infor;

@end
