//
//  HYNetWorkConst.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYNetWorkConst : NSObject

//** =========================================================================================== */
//** ============================================key=========================================== */
//** =========================================================================================== */

/**
 *  网络请求异常key
 */
UIKIT_EXTERN NSString * const NETREQUEST_ERRORINFO_KEY;


//** =========================================================================================== */
//** ============================================个人中心========================================== */
//** =========================================================================================== */

/**
 使用验证码登录
 */
UIKIT_EXTERN NSString * const LOGINWITHCODE_URL;
/**
 获取登录的验证码
 */
UIKIT_EXTERN NSString * const GETLOGINCODE_URL;

/**
 请求我的主页面
 */
UIKIT_EXTERN NSString * const GETMINEMAININFOR_URL;

/**
 切换头像
 */
UIKIT_EXTERN NSString * const CHANGE_HEADERICON_URL;

/**
 上传被修改过的信息
 */
UIKIT_EXTERN NSString *const UPLOAD_USERINFOR_URL;

/**
 获取账单列表
 */
UIKIT_EXTERN NSString *const GET_MINEBILLLISTINFOR_URL;

/**
 获取合同信息
 */
UIKIT_EXTERN NSString *const GET_MINEHETONGLISTINFOR_URL;
/**
 获取合同详情
 */
UIKIT_EXTERN NSString *const GET_MINEHETONGDEATILINFOR_URL;
/**
 预览合同
 */
UIKIT_EXTERN NSString *const GET_MINEHETONGPDFINFOR_URL;

/**
 维修列表
 */
UIKIT_EXTERN NSString *const GET_MINEWEIXIULISTINFOR_URL;
/**
 申请维修
 */
UIKIT_EXTERN NSString *const GET_MINEAPPLYWEIXIUINFOR_URL;
/**
 保洁列表
 */
UIKIT_EXTERN NSString *const GET_MINEBAOJIELISTINFOR_URL;
/**
 申请保洁
 */
UIKIT_EXTERN NSString *const GET_MINEAPPLYBAOJIEINFOR_URL;
/**
 维修区域
 */
UIKIT_EXTERN NSString *const GET_MINEWEIXIUQUYUINFOR_URL;
/**
 维修 上传图片
 */
UIKIT_EXTERN NSString *const UPLOAD_MINEWEIXIU_IMAGE_URL;

/**
 电表信息
 */
UIKIT_EXTERN NSString *const GET_MINEDIANBAO_INFOR_URL;
/**
 水表信息
 */
UIKIT_EXTERN NSString *const GET_MINESHUIBAO_INFOR_URL;

/**
 只能门锁信息
 */
UIKIT_EXTERN NSString *const GET_MINELOCKMESSAGE_INFOR_URL;
/**
 远程开锁
 */
UIKIT_EXTERN NSString *const GET_REMOTERUNLOCK_URL;
/**
 修改门锁密码
 */
UIKIT_EXTERN NSString *const CHANGE_MYLOCKPW_URL;
/**
 修改门锁密码 发生验证码
 */
UIKIT_EXTERN NSString *const CHANGE_MYLOCKPW_SENDCODE_URL;

/**
 预约列表
 */
UIKIT_EXTERN NSString *const GET_YUYUELIST_INFOR_URL;
/**
 取消预约
 */
UIKIT_EXTERN NSString *const CANCLE_YUYUE_ORDER_URL;
/**
 预订列表
 */
UIKIT_EXTERN NSString *const GET_YUDINGLIST_INFOR_URL;
/**
 取消预订
 */
UIKIT_EXTERN NSString *const CANCLE_YUDING_ORDER_URL;
/**
 收藏列表
 */
UIKIT_EXTERN NSString *const GET_COLLECTLIST_INFOR_URL;
/**
 收藏户型
 */
UIKIT_EXTERN NSString *const ADD_HUXING_COLLECT_URL;
/**
 取消收藏户型
 */
UIKIT_EXTERN NSString *const CANCLE_HUXING_COLLECT_URL;
/**
 投诉建议
 */
UIKIT_EXTERN NSString *const TOUSUJIANYI_INFOR_URL;
/**
 取消 投诉建议
 */
UIKIT_EXTERN NSString *const TOUSUJIANYI_CANCLE_INFOR_URL;
/**
 投诉建议 列表
 */
UIKIT_EXTERN NSString *const TOUSUJIANYI_LIST_INFOR_URL;
/**
 服务评价
 */
UIKIT_EXTERN NSString *const FUPINGJIA_INFOR_URL;
/**
 户型详情信息
 */
UIKIT_EXTERN NSString *const HUXINGDEATIL_INFOR_URL;
/**
 项目列表
 */
UIKIT_EXTERN NSString *const HOUSE_LIST_INFOR_URL; 
/**
 项目详情
 */
UIKIT_EXTERN NSString *const HOUSE_DEATIL_INFOR_URL;
/**
 户型列表
 */
UIKIT_EXTERN NSString *const HUXING_LIST_INFOR_URL;

/**
 城市列表
 */
UIKIT_EXTERN NSString *const HAVEHOUSE_CITY_LIST_INFOR_URL;

/**
 获取项目列表名称
 */
UIKIT_EXTERN NSString *const GET_PROJECT_LIST_INFOR_URL;
/**
 获取户型列表
 */
UIKIT_EXTERN NSString *const GET_HUXING_LIST_INFOR_URL;
/**
 获取房间号列表
 */
UIKIT_EXTERN NSString *const GET_FANGJIANNUMBER_LIST_INFOR_URL;
/**
 预约房源
 */
UIKIT_EXTERN NSString *const COMMIT_YUYUEHOUSTE_INFOR_URL;
/**
 预订房源
 */
UIKIT_EXTERN NSString *const COMMIT_YUDINGHOUSTE_INFOR_URL;
/**
 获取房源的信息 （预订时，选择房间号后，获取房间号的信息）
 */
UIKIT_EXTERN NSString *const GET_YUDINGHOUSTE_DEATIL_INFOR_URL;
/**
 签约账单
 */
UIKIT_EXTERN NSString *const COMMIT_QIANYUEHOUSTE_INFOR_URL;
/**
 租客签约
 */
UIKIT_EXTERN NSString *const ZUKE_QIANYUEHOUSTE_INFOR_URL;
/**
 根据城市id获取区域列 (房源 筛选的 区域列表)
 */
UIKIT_EXTERN NSString *const GET_QUYU_LIST_BY_CITY_INFOR_URL;

/**
 根据城市获取项目列表 (地图找房)
 */
UIKIT_EXTERN NSString *const GET_PROJECT_LIST_BYCITY_INFOR_URL;

/**
 获取优惠活动信息
 */
UIKIT_EXTERN NSString *const GET_DISCOUNTFORQIANYUE_INFOR_URL;

/**
 获取签约的付款方式
 */
UIKIT_EXTERN  NSString *const GET_QIANYUPAY_TYPE_MARK_URL;

/**
 获取首页的数据 -- 不再使用
 */
UIKIT_EXTERN NSString *const GET_HOMEPAGE_INFOR_URL;
/**
 首页推荐房源、户型
 */
UIKIT_EXTERN NSString *const HOMEPAGE_TUIJIAN_HX_OR_FY_URL;
/**
 首页banner
 */
UIKIT_EXTERN NSString *const HOMEPAGE_TUIGUANG_BANNER_URL;
/**
 首页的热分享
 */
UIKIT_EXTERN NSString *const HOMEPAGE_HOT_SHARE_URL;
/**
 首页的热事件
 */
UIKIT_EXTERN NSString *const HOMEPAGE_HOT_EVENTS_URL;
///**
// 生成 充值 预支付订单 微信支付
// */
//UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_URL;
//
///**
// 生成 充值 预支付订单 支付宝支付
// */
//UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_ALIP_URL;

/**
 电表充值记录
 */
UIKIT_EXTERN NSString *const RECHARFEFOR_DIAN_RECORDLIST_URL;
/**
 水表充值记录
 */
UIKIT_EXTERN NSString *const RECHARFEFOR_SHUI_RECORDLIST_URL;

/**
 生成 账单/定金 预支付订单 【微信】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_URL;

/**
 预定&账单【支付宝支付】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_ALIP_URL;

/**
 预定&账单 有优惠券【支付宝支付】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_ALIP_URL;

/**
 预定&账单 有优惠券【微信】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_WEIXIN_URL;

/**
 生成 充值 预支付订单【优惠券】 【微信支付】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_WEIXIN_URL;

/**
 生成 充值 预支付订单 【优惠券】【支付宝支付】
 */
UIKIT_EXTERN NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_ALIP_URL;

/**
 客户端消息列表
 */
UIKIT_EXTERN NSString *const MESSAGE_LIST_URL;

/**
 预定协议
 */
UIKIT_EXTERN NSString *const YUDING_XIEYI_URL;

/**
 签约协议
 */
UIKIT_EXTERN NSString *const  QIANYU_XIEYI_URL;

/**
 获取未使用优惠券列表
 */
UIKIT_EXTERN NSString *const GETCANUSEDISCOUNT_LIST_INFOR_URL;

/**
 计算优惠金额
 */
UIKIT_EXTERN NSString *const GET_USEDISCOUNT_DIKOU_MONEY_URL;

/**
 获取支付水电费优惠券
 */
UIKIT_EXTERN NSString *const GETCANUSEDISCOUNT_LIST_INFOR_FOR_RECHARGE_URL;

/**
 水电表充值时 选择优惠券， 当优惠券的总金额大于等于输入的金额时，不再调用支付，直接调用该接口
 */
UIKIT_EXTERN NSString *const RECHARGE_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL;

/**
 检查版本号
 */
UIKIT_EXTERN NSString *const CHECK_VERSION_URL;

/**
 交房租时 选择优惠券， 当优惠券的总金额大于等于输入的金额时，不再调用支付，直接调用该接口
 */
UIKIT_EXTERN NSString *const BILL_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL;
/**
 京东开普勒
 */
UIKIT_EXTERN NSString *const KEPLER_JD_URL;

/**
 查询支付订单
 */
UIKIT_EXTERN NSString *const QUERY_PAYMENT_RESULT_URL;
/**
 修改优惠券的状态
 */
UIKIT_EXTERN NSString *const UPDATE_COUPON_USESTATUS_URL;
/**
 注册
 */
UIKIT_EXTERN NSString *const RESISTER_URL;

/**
 使用密码登录
 */
UIKIT_EXTERN NSString * const LOGINWITH_PASSWORD_URL;
/**
 修改登录密码
 */
UIKIT_EXTERN NSString *const CHANGE_LOGIN_PASSWORD_URL;
/**
 设置登录密码
 */
UIKIT_EXTERN NSString *const SET_LOGIN_PASSWORD_URL;

/**
 修改手机号
 */
UIKIT_EXTERN NSString *const CHANGE_ACCOUNT_PHONE_URL;

/**
 检查手机是否已经注册
 */
UIKIT_EXTERN NSString *const CHECK_NEW_PHONE_ISREGISTER_URL;

/** 保洁租客评价 */
UIKIT_EXTERN NSString *const BAOJIE_ZUEKE_PINGJIA_URL;

/** 维修租客评价 */
UIKIT_EXTERN NSString *const WEIXIU_ZUEKE_PINGJIA_URL;

/** 投诉租客评价 */
UIKIT_EXTERN NSString *const TOUSU_ZUEKE_PINGJIA_URL;

@end
