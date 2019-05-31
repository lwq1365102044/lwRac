
#import "HYProjectConst.h"

//** =========================================================================================== */
//** ============================================系统=========================================== */
//** =========================================================================================== */

/**
 公司编码 gcid
 */
NSString *const  BASE_GCID                                  = @"0371070";

/**
 输入的字符经过base64编码后 最大长度  
 */
NSInteger const BASE64STRING_MAXLENG                        = 700;

/**
 *  系统网络请求分页页面大小
 */
NSInteger const SEVRIES_PAGESIZE                            = 8;

/**
 *  系统网络请求超时时间
 */
CGFloat const SEVRIES_TIMEOUT                               = 20.f;

/**
 *  主题样式
 */
NSString * const PROJECT_THEME_DEFAULT                      = @"Default";

/**
 *  高亮图片拼接后缀
 */
NSString * const PROJECT_THEME_IMAGE_HIG                    = @"h";

/**
 *  普通图片拼接后缀
 */
NSString * const PROJECT_THEME_IMAGE_NOR                    = @"n";

/**
 *  禁用图片拼接后缀
 */
NSString * const PROJECT_THEME_IMAGE_DIS                    = @"d";


/**
 * NaviBar高度
 */
CGFloat const NAVIGATION_BAR_HEIGHT                         = 44.f;

/**
 * 图片资源文件路径
 */
NSString * const RESOURCESBUNDLE_IMAGE                      = @"Image.bundle";

/**
 * string资源文件路径
 */
NSString * const RESOURCESBUNDLE_STRING                     = @"String.bundle";

/**
 * color资源文件路径
 */
NSString * const RESOURCESBUNDLE_COLOR                      = @"Color.bundle";

/**
 * 本地数据路径(测试使用)
 */
NSString * const LOCALEDATAPATH                             = @"/Users/zhengjian/Desktop/Order.json";

//** =========================================================================================== */
//** =========================================第三方资源配置====================================== */
//** =========================================================================================== */

/**
 * 百度统计APP_KEY
 */
NSString * const STYTEM_THIRD_BAIDU_STATISTICS_APPKEY       = @"8d67a39089";

/**
 * JPush APP_KEY
 */
NSString * const STYTEM_THIRD_JUPSH_APPKEY                  = @"89521e675af3dc424e33e534";

/**
 * JPush channel
 */
NSString * const STYTEM_THIRD_JUPSH_CHANNEL                 = @"Publish channel";

/**
 信鸽推送的APPkey
 */
NSString *const SYSTEM_THIRD_XGPUSH_APPKEY                  = @"I6A2SLA1I83A";
/**
 信鸽推送 APPID
 */
NSInteger const SYSTEM_THIRD_XGPUSH_APPID                     =  2200320758;

/**
 百度AI 识别身份证  AppKey  (15311305641  50000次/天免费 不保证并发)
 */
NSString * const APP_KEY_BAIDUAI_IDCARD    = @"1khlsVXfX1l0ApcnRXT0T8OU";

/**
 百度AI 识别身份证  Secret Key
 */
NSString * const SECRET_KEY_BAIDUAI_IDCARD    = @"N3X9I2gh26sgMOFDx5hh2pKKw0bfR2SU";


/**
 百度地图- KEY  (2652789506)
 */
NSString * const APP_KEY_BAIDUMAP_LOCATION_KEY           = @"QQR6cm8w9awXQGZOTuAxvknZ5qROHLjU";

/**
 bugly  appId  账号：--15311305641--
 */
NSString *const BUGLY_APP_ID                              =  @"804387e76b";

/**
 开普勒 
 */
NSString *const KEPLER_APP_KEY                              = @"dc57e5f9f1814c58af3956b02c0114bf";
NSString *const KEPLER_APP_SECRET                           = @"97720b943cdb4f11b4d90510fa106131";


//** =========================================================================================== */
//** ==========================================正则表达式========================================= */
//** =========================================================================================== */

/**
 * 正则表达式_验证邮箱号码
 */
//NSString * const REGULAREXPRESSION_ISMAIL                   = @"^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$";
NSString * const REGULAREXPRESSION_ISMAIL                     = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
/**
 * 正则表达式_验证昵称
 * 昵称正则匹配  支持中文、字母、数字、'-''_'的组合，4-10个字符"
 */
NSString * const REGULAREXPRESSION_ISNICKNAEM               = @"^[\u4e00-\u9fa5-_a-zA-Z0-9]{4,10}$";

/**
 * 正则表达式_验证密码规则(数字或字母)
 */
NSString * const REGULAREXPRESSION_ISPWD                    = @"^[A-Za-z0-9]{6,12}$";

/**
 * 正则表达式_验证数字
 */
NSString * const REGULAREXPRESSION_ISNUM                    = @"^(0|[1-9][0-9]*)$";

/**
 * 正则表达式_手机号码
 *  [1]\d{10}
 */
//NSString * const REGULAREXPRESSION_PHONENUMBER_MOBILE       = @"^1(3[0-9]|5[0-35-9]|7[025-9]|8[025-9])\\d{8}$";
NSString * const REGULAREXPRESSION_PHONENUMBER_MOBILE       = @"[1]\\d{10}";
//NSString * const REGULAREXPRESSION_PHONENUMBER_MOBILE       = @"^((13[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";


/**
 * 正则表达式_控制输入不含特殊符号(能够输入汉字、字母、数字)
 */
NSString * const REGULAREXPRESSION_ISSTR                    = @"^[\\u4E00-\\u9FA5\\uF900-\\uFA2D\\w]{0,50}";

/**
 * 正则表达式_验证身份证  测试通过
 */
NSString * const REGULAREXPRESSION_IDENTITYCARD             = @"^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$";

