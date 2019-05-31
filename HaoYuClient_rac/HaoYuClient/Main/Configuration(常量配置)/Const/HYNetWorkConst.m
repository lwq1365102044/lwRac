//
//  HYNetWorkConst.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYNetWorkConst.h"

@implementation HYNetWorkConst

/**
 *  网络请求异常key
 */
NSString * const NETREQUEST_ERRORINFO_KEY                                           = @"errorInfo";



//** =========================================================================================== */
//** ============================================个人中心========================================== */
//** =========================================================================================== */

/**
 使用验证码登录
 */
NSString * const LOGINWITHCODE_URL                      = @"/v2/clientAPP/app/login";

/**
 使用密码登录
 */
NSString * const LOGINWITH_PASSWORD_URL                      = @"v2/clientAPP/app/passWord_login";

/**
 获取登录的验证码
 */
NSString * const GETLOGINCODE_URL                      = @"/v2/clientAPP/app/get_code";

/**
 请求我的主页面
 */
NSString * const GETMINEMAININFOR_URL                      = @"v2/clientAPP/app/getUserInfo";

/**
 切换头像
 */
NSString * const CHANGE_HEADERICON_URL                  = @"";
/**
 上传被修改过的信息
 */
NSString *const UPLOAD_USERINFOR_URL                    = @"v2/clientAPP/app/modify_personal_information";

/**
 获取账单列表
 */
NSString *const GET_MINEBILLLISTINFOR_URL                    = @"v2/clientAPP/app/get_renter_list";

/**
 获取合同信息
 */
NSString *const GET_MINEHETONGLISTINFOR_URL                    = @"v2/clientAPP/app/get_contract_list";
/**
 获取合同详情
 */
NSString *const GET_MINEHETONGDEATILINFOR_URL                    = @"v2/clientAPP/app/get_contract_by_id";
/**
 预览合同
 */
NSString *const GET_MINEHETONGPDFINFOR_URL                    = @"/v2/contract/electronic_contract/selcontract";
/**
 维修列表
 */
NSString *const GET_MINEWEIXIULISTINFOR_URL                    = @"v2/clientAPP/app/get_maintain_list";
/**
 申请维修
 */
NSString *const GET_MINEAPPLYWEIXIUINFOR_URL                    = @"v2/clientAPP/app/apply_maintain";
/**
 保洁列表
 */
NSString *const GET_MINEBAOJIELISTINFOR_URL                    = @"v2/clientAPP/app/get_cleaning_list";
/**
 申请保洁
 */
NSString *const GET_MINEAPPLYBAOJIEINFOR_URL                    = @"v2/clientAPP/app/apply_cleaning";
/**
 维修区域
 */
NSString *const GET_MINEWEIXIUQUYUINFOR_URL                    = @"v2/sys/zi_dian/get_list_by_mark";
/**
 上传图片到阿里云 返回图片地址
 */
NSString *const UPLOAD_MINEWEIXIU_IMAGE_URL                    = @"/UploadAllObjectServlet?server=upload&";
/**
 电表信息
 */
NSString *const GET_MINEDIANBAO_INFOR_URL                    = @"/v2/device/mineDianBiao";

/**
 水表信息
 */
NSString *const GET_MINESHUIBAO_INFOR_URL                    = @"/v2/device/mineShuiBiao";

/**
 只能门锁信息
 */
//NSString *const GET_MINELOCKMESSAGE_INFOR_URL                    = @"v2/clientAPP/app/getMyLockMsg";
NSString *const GET_MINELOCKMESSAGE_INFOR_URL                    =  @"/v2/wechatsciencelock/getMyLockMsg";

/**
 远程开锁
 */
NSString *const GET_REMOTERUNLOCK_URL                    = @"v2/clientAPP/app/weChatRemoteUnlocking";
/**
 修改门锁密码
 */
NSString *const CHANGE_MYLOCKPW_URL                    = @"v2/clientAPP/app/updatePwd";
/**
 修改门锁密码 发生验证码
 */
NSString *const CHANGE_MYLOCKPW_SENDCODE_URL                    = @"v2/sciencelock/send_verification_code";
/**
 预约列表
 */
NSString *const GET_YUYUELIST_INFOR_URL                    = @"v2/clientAPP/app/get_reservation_list";
/**
 取消预约
 */
NSString *const CANCLE_YUYUE_ORDER_URL                    = @"v2/clientAPP/app/cancel_appointment";
/**
 预订列表
 */
NSString *const GET_YUDINGLIST_INFOR_URL                    = @"v2/clientAPP/app/get_preordain_list";
/**
 取消预订
 */
NSString *const CANCLE_YUDING_ORDER_URL                    = @"v2/clientAPP/app/cancel_book";
/**
 收藏列表
 */
NSString *const GET_COLLECTLIST_INFOR_URL                    = @"v2/clientAPP/app/get_favorites_list";
/**
 收藏户型
 */
NSString *const ADD_HUXING_COLLECT_URL                    = @"v2/clientAPP/app/collector_houseType";
/**
 取消收藏户型
 */
NSString *const CANCLE_HUXING_COLLECT_URL                    = @"/v2/clientAPP/app/cancel_houseCollection";

/**
 投诉建议
 */
NSString *const TOUSUJIANYI_INFOR_URL                    = @"v2/clientAPP/app/suggestions";
/**
 取消 投诉建议
 */
NSString *const TOUSUJIANYI_CANCLE_INFOR_URL                    = @"v2/clientAPP/app/cancel_complaint";

/**
 投诉建议 列表
 */
NSString *const TOUSUJIANYI_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_complaint_letter_list";

/**
服务评价
 */
NSString *const FUPINGJIA_INFOR_URL                    = @"v2/clientAPP/app/serviceRating";



/**
 户型详情信息
 */
NSString *const HUXINGDEATIL_INFOR_URL                    = @"v2/clientAPP/app/get_roomType_details";

/**
 项目列表
 */
NSString *const HOUSE_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_item_list";
/**
 项目详情
 */
NSString *const HOUSE_DEATIL_INFOR_URL                    = @"v2/clientAPP/app/get_item_details";
/**
 户型列表
 */
NSString *const HUXING_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_room_type_list";

/**
 城市列表
 */
NSString *const HAVEHOUSE_CITY_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_city_list";

/**
 获取项目列表名称
 */
NSString *const GET_PROJECT_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_itemList_by_cityId";
/**
 获取户型列表
 */
NSString *const GET_HUXING_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_roomTypeList_by_itemId";
/**
 获取房间号列表
 */
NSString *const GET_FANGJIANNUMBER_LIST_INFOR_URL                    = @"v2/clientAPP/app/get_houseNo_by_roomTypeId";

/**
 预约房源
 */
NSString *const COMMIT_YUYUEHOUSTE_INFOR_URL                    = @"v2/clientAPP/app/yu_yue";

/**
 预订房源
 */
NSString *const COMMIT_YUDINGHOUSTE_INFOR_URL                    = @"v2/clientAPP/app/book_house";

/**
 获取房源的信息 （预订时，选择房间号后，获取房间号的信息）
 */
NSString *const GET_YUDINGHOUSTE_DEATIL_INFOR_URL                    = @"v2/clientAPP/app/get_house_details";

/**
 签约账单
 */
NSString *const COMMIT_QIANYUEHOUSTE_INFOR_URL                    = @"/v2/compact/chengzu/anticipated_revenue_kangqiaoExpend";

/**
 租客签约
 */
NSString *const ZUKE_QIANYUEHOUSTE_INFOR_URL                    = @"v2/clientAPP/app/sign_contract";

/**
 根据城市id获取区域列 (房源 筛选的 区域列表)
 */
NSString *const GET_QUYU_LIST_BY_CITY_INFOR_URL                    = @"v2/clientAPP/app/get_townList_by_cityId";

/**
 根据城市获取项目列表 (地图找房)
 */
NSString *const GET_PROJECT_LIST_BYCITY_INFOR_URL                    = @"v2/clientAPP/app/get_itemInformation_by_city";


/**
 获取优惠活动信息
 */
NSString *const GET_DISCOUNTFORQIANYUE_INFOR_URL                    = @"v2/clientAPP/app/getDiscount_clientApp";

/**
 获取签约的付款方式
 */
NSString *const GET_QIANYUPAY_TYPE_MARK_URL                    = @"v2/sys/zi_dian/get_list_by_mark";


/**
 获取首页的数据 -- 不再使用
 */
NSString *const GET_HOMEPAGE_INFOR_URL                    = @"v2/web/client_app_popu/get_banner_and_popu_pic_";

/**
 首页推荐房源、户型
 */
NSString *const HOMEPAGE_TUIJIAN_HX_OR_FY_URL               = @"v2/clientAPP/app/business_recommendation";
/**
 首页的热分享
 */
NSString *const HOMEPAGE_HOT_SHARE_URL               = @"/v2/officialWebsit/hot_share/get_list_where";
/**
 首页的热事件
 */
NSString *const HOMEPAGE_HOT_EVENTS_URL               = @"v2/officialWebsit/hot_events/get_where_list";
/**
 首页banner
 */
NSString *const HOMEPAGE_TUIGUANG_BANNER_URL                = @"v2/clientAPP/app/banner_promotion";

///**
// 生成 充值 预支付订单 [微信支付】
// */
//NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_URL                    = @"v2/clientAPP/app/waterMeterPayment";
///**
// 生成 充值 预支付订单 【支付宝支付】
// */
//NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_ALIP_URL                    = @"v2/clientAPP/app/water_or_electric_recharge";


/**
 电表充值记录
 */
NSString *const RECHARFEFOR_DIAN_RECORDLIST_URL                    = @"v2/clientAPP/app/electric_meter_recharge_record";

/**
  水表充值记录
 */
NSString *const RECHARFEFOR_SHUI_RECORDLIST_URL                    = @"v2/clientAPP/app/water_meter_recharge_record";

/**
 生成 账单/定金 预支付订单  【微信】
 */
NSString *const PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_URL                    = @"v2/clientAPP/app/bill_or_deposit_payment";

/**
 预定&账单【支付宝支付】
 */
NSString *const PAYMENT_CREATPREPAYMENT_BILLANDDESPOSIT_ALIP_URL                    = @"v2/clientAPP/app/get_alipay_order";

/**
 预定&账单 有优惠券【支付宝支付】
 */
NSString *const PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_ALIP_URL                    = @"v2/clientAPP/app/get_alipay_order_by_coupon";

/**
 预定&账单 有优惠券【微信】
 */
NSString *const PAYMENT_CREATPREPAYMENT_BILL_DISCOUNT_WEIXIN_URL                    = @"v2/clientAPP/app/bill_or_deposit_payment_by_coupon";

/**
 生成 充值 预支付订单【优惠券】 【微信支付】
 */
NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_WEIXIN_URL                    = @"v2/clientAPP/app/water_Meter_Payment_By_Coupon";

/**
 生成 充值 预支付订单 【优惠券】【支付宝支付】
 */
NSString *const PAYMENT_CREATPREPAYMENT_RECHARGE_DISCOUNT_ALIP_URL                    = @"v2/clientAPP/app/water_or_electric_recharge_coupon";

/**
 客户端消息列表
 */
NSString *const MESSAGE_LIST_URL             = @"v2/clientApps/client_message_pool/get_list";

/**
 预定协议
 */
NSString *const YUDING_XIEYI_URL                     = @"/wechatApps/weixin/homeCenter/agreement.html";

/**
 签约协议
 */
NSString *const  QIANYU_XIEYI_URL                      = @"/wechatApps/weixin/homeCenter/sign.html";

/**
 获取未使用优惠券列表
 */
NSString *const GETCANUSEDISCOUNT_LIST_INFOR_URL        = @"v2/coupon/coupon/get_coupon_list_by_app";

/**
 计算优惠金额
 */
NSString *const GET_USEDISCOUNT_DIKOU_MONEY_URL         = @"v2/coupon/coupon/get_app_dikou_money";

/**
 获取支付水电费优惠券
 */
NSString *const GETCANUSEDISCOUNT_LIST_INFOR_FOR_RECHARGE_URL                     = @"v2/coupon/coupon/get_shudiain_coulist_app";

/**
 水电表充值时 选择优惠券， 当优惠券的总金额大于等于输入的金额时，不再调用支付，直接调用该接口
 */
NSString *const RECHARGE_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL                     = @"v2/costpay/bind_recharge_order/use_couponlist_pay_shuidian";

/**
 检查版本号
 */
NSString *const CHECK_VERSION_URL                                   = @"/v2/clientAPP/app/check_version";

/**
 交房租时 选择优惠券， 当优惠券的总金额大于等于输入的金额时，不再调用支付，直接调用该接口
 */
NSString *const BILL_WHEN_CHOOSEDISOCUNTMONEY_DAYUDENGYU_INPUNTMONEY_URL                     = @"v2/clientAPP/app/use_coupon_pay_balance";

/**
 京东开普勒
 */
NSString *const KEPLER_JD_URL = @"https://click.k.jd.com/union?&mtm_source=kepler-m&mtm_subsource=dc57e5f9f1814c58af3956b02c0114bf&returl=https%3A%2F%2Fu.jd.com%2F6rynLe";

/**
 查询支付订单
 */
NSString *const QUERY_PAYMENT_RESULT_URL     = @"v2/clientAPP/app/check_aliPay";

/**
 修改优惠券的状态
 */
NSString *const UPDATE_COUPON_USESTATUS_URL =   @"/v2/coupon/coupon/update_by_ids";

/**
 注册
 */
NSString *const RESISTER_URL =  @"v2/customer/house_user/registered";
/**
 修改登录密码
 */
NSString *const CHANGE_LOGIN_PASSWORD_URL =  @"v2/clientAPP/app/change_password";

/**
 设置登录密码
 */
NSString *const SET_LOGIN_PASSWORD_URL =  @"v2/clientAPP/app/set_password";

/**
 修改手机号
 */
NSString *const CHANGE_ACCOUNT_PHONE_URL = @"v2/clientAPP/app/change_phone_";
/**
 检查手机是否已经注册
 */
NSString *const CHECK_NEW_PHONE_ISREGISTER_URL = @"v2/customer/house_user/verify_registration";
/** 保洁租客评价 */
NSString *const BAOJIE_ZUEKE_PINGJIA_URL = @"/v2/web/clean/grade";
/** 维修租客评价 */
NSString *const WEIXIU_ZUEKE_PINGJIA_URL = @"/v2/web/repair/grade";
/** 投诉租客评价 */
NSString *const TOUSU_ZUEKE_PINGJIA_URL = @"v2/web/complain_letter/grade";

@end
