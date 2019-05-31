/**
 *  头文件说明
 *  1、公用常量
 */

#import <UIKit/UIKit.h>

//** =========================================================================================== */
//** ============================================系统=========================================== */
//** =========================================================================================== */

/**
 公司编码 gcid
 */
UIKIT_EXTERN NSString *const  BASE_GCID ;

/**
 输入的字符经过base64编码后 最大长度
 */
UIKIT_EXTERN NSInteger const BASE64STRING_MAXLENG;

/**
 *  系统网络请求超时时间
 */
UIKIT_EXTERN CGFloat const SEVRIES_TIMEOUT;

/**
 *  主题样式
 */
UIKIT_EXTERN NSString * const PROJECT_THEME_DEFAULT;

/**
 *  高亮图片拼接后缀
 */
UIKIT_EXTERN NSString * const PROJECT_THEME_IMAGE_HIG;

/**
 *  普通图片拼接后缀
 */
UIKIT_EXTERN NSString * const PROJECT_THEME_IMAGE_NOR;

/**
 *  禁用图片拼接后缀
 */
UIKIT_EXTERN NSString * const PROJECT_THEME_IMAGE_DIS;

/**
 * NaviBar高度
 */
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_HEIGHT;


/**
 * 网络请求超时时间
 */
UIKIT_EXTERN CGFloat const NETREQUEST_TIMEOUT;


/**
 * string资源文件路径
 */
UIKIT_EXTERN NSString * const RESOURCESBUNDLE_STRING;

/**
 * color资源文件路径
 */
UIKIT_EXTERN NSString * const RESOURCESBUNDLE_COLOR;

/**
 * 本地数据路径(测试使用)
 */
UIKIT_EXTERN NSString * const LOCALEDATAPATH;

//** =========================================================================================== */
//** =========================================第三方资源配置====================================== */
//** =========================================================================================== */

/**
 * 百度统计APP_KEY
 */
UIKIT_EXTERN NSString * const STYTEM_THIRD_BAIDU_STATISTICS_APPKEY;

/**
 * JPush APP_KEY
 */
UIKIT_EXTERN NSString * const STYTEM_THIRD_JUPSH_APPKEY;

/**
 * JPush channel
 */
UIKIT_EXTERN NSString * const STYTEM_THIRD_JUPSH_CHANNEL;

/**
 信鸽推送的APPkey
 */
UIKIT_EXTERN NSString *const SYSTEM_THIRD_XGPUSH_APPKEY;

/**
 信鸽推送 APPID
 */
UIKIT_EXTERN NSInteger const SYSTEM_THIRD_XGPUSH_APPID;

/**
 百度AI 识别身份证  AppKey
 */
UIKIT_EXTERN NSString * const APP_KEY_BAIDUAI_IDCARD;
/**
 百度AI 识别身份证  Secret Key
 */
UIKIT_EXTERN NSString * const SECRET_KEY_BAIDUAI_IDCARD;

/**
 百度地图- KEY
 */
UIKIT_EXTERN NSString * const APP_KEY_BAIDUMAP_LOCATION_KEY;

/**
 bugly  appId  账号：1365--
 */
UIKIT_EXTERN NSString *const BUGLY_APP_ID;

/**
 开普勒
 */
UIKIT_EXTERN NSString *const KEPLER_APP_KEY;
UIKIT_EXTERN NSString *const KEPLER_APP_SECRET;

//** =========================================================================================== */
//** ==========================================正则表达式========================================= */
//** =========================================================================================== */

/**
 * 正则表达式_验证邮箱号码
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_ISMAIL;

/**
 * 正则表达式_验证昵称
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_ISNICKNAEM;

/**
 * 正则表达式_验证密码规则
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_ISPWD;

/**
 * 正则表达式_验证数字
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_ISNUM;

/**
 * 正则表达式_手机号码
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_MOBILE;

/**
 * 中国移动：China Mobile
 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_CM;

/**
 * 中国联通：China Unicom
 * 130,131,132,152,155,156,185,186
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_CU;

/**
 * 中国电信：China Telecom
 * 133,1349,153,180,189
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_CT;

/**
 * 大陆地区固话及小灵通
 * 区号：010,020,021,022,023,024,025,027,028,029
 * 号码：七位或八位
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_PHS;

/**
 * 正则表达式_虚拟号码
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_PHONENUMBER_XNHM;

/**
 * 正则表达式_控制输入不含特殊符号(能够输入汉字、字母、数字)
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_ISSTR;

/**
 * 正则表达式_验证身份证
 */
UIKIT_EXTERN NSString * const REGULAREXPRESSION_IDENTITYCARD;
