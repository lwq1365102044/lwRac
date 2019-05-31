
/**
 项目中的通知KEY
 */

#import <UIKit/UIKit.h>


//** =========================================================================================== */
//** ============================================Timer========================================== */
//** =========================================================================================== */

/**
 *  定时器调用方法通知
 */
UIKIT_EXTERN NSString * const TIMER_NOTIFICATION;

/**
 监听改变tabbarindex
 */
UIKIT_EXTERN NSString *const CHANGETABBAR_INDEX_KEY;

/**
 签约 填写信息 选择合同起止日期后，获取优惠活动请求
 */
UIKIT_EXTERN NSString *const GET_DISCOUNTINFOR_BY_HETONGSTARADNENDTIEM_KEY;

/**
 获取个人信息后，更新界面信息
 */
UIKIT_EXTERN NSString *const GET_USERINFOR_TOUPDATE_MINEMAININFOR;

/**
 没有网络的情况下， 列表显示无网空白页
 */
UIKIT_EXTERN NSString *const   NONETWORK_FOR_BASETABLEVIEWCONTROLL_SHOWBLANKPAGE_NOTI;

/**
 首页 修改城市后，同时修改 房源列表的 城市筛选
 */
UIKIT_EXTERN NSString *const   HOUSERESOURCE_CITYID_FORCHANGECITY_INHOUMEPAGE_NOTI;

/**
 切换账号后，重新请求个人信息，刷新我的界面数据
 */
UIKIT_EXTERN NSString *const   CHANGER_ACCOUNT_UPDATE_MAIN_REREQUESTDATA_TOUPDATEMAINPAGEUI_NOTI;

/**
 启动APP的时候更新用户信息
 */
UIKIT_EXTERN NSString *const APP_BECOMEACTIVE_UPDATE_ACCOUNTINFOR_NOTI;

/**
 获取的消息信息后，更新navi.item
 */
UIKIT_EXTERN NSString *const GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE;
/**
 获取的推送消息
 */
UIKIT_EXTERN NSString *const GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE_FOR_PUSH;

/**
 充值水电表时 支付时 修改金额后，重新选择优惠券
 */
UIKIT_EXTERN NSString *const CHANGE_INPUTMONEY_FOR_RECHARGE_DISCOUNT_KEY;
/**
 退出登录后重新注册
 */
UIKIT_EXTERN NSString *const REPLACE_REGISTERXGPUSH_NOTI_KEY;

/**
 支付成功后，刷新列表
 */
UIKIT_EXTERN NSString *const PAYMENT_AFTER_REFRESH_BILLLIST_KEY;

/**
 设置登录密码成功
 */
UIKIT_EXTERN NSString *const CREATE_LOGIN_PASSWORD_SUCCESS_KEY;

/**
 修改手机号成功
 */
UIKIT_EXTERN NSString *const CHANGE_ACCOUNT_PHONE_SUCCESS_KEY;
