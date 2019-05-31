//
//  LWProjectMacro.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#ifndef LWProjectMacro_h
#define LWProjectMacro_h

//** =========================================================================================== */
//** ===========================================系统尺寸========================================== */
//** =========================================================================================== */

/**
 * 状态栏高度
 */
#define  STATUS_BAR_HEIGHT                                              ((iPhoneX) ? 44.f : 20.f)

/**
 * 状态栏 ＋ 导航栏 高度
 */
#define NAVIGATOR_HEIGHT                                    ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#define  TABBAR_HIEGHT self.tabBarController.tabBar.height

/**
 * 屏幕 rect
 */
#define SCREEN_RECT                                                     [UIScreen mainScreen].bounds

/**
 * 屏幕宽
 */
#define SCREEN_WIDTH                                                    ([UIScreen mainScreen].bounds.size.width)

/**
 * 屏幕高
 */
#define SCREEN_HEIGHT                                                   ([UIScreen mainScreen].bounds.size.height)

/**
 * 屏幕显示内容净高度
 */
#define CONTENT_HEIGHT                                                  (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

/**
 * 屏幕分辨率
 */
#define SCREEN_RESOLUTION                                               (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

/**
 * 屏幕缩放因子
 */
#define SCREEN_SCALE                                                    ([UIScreen mainScreen].scale)

/**
 适配底图距离的按钮
 */
#define ADJUST_PERCENT_BOTTOM(float) ([HYProjectThemeSizeFactory projectSizeFatoryAdjustPercentFloat:(iPhoneX) ? float + 20 : float])

/**
 *  屏幕适配比例，以iPhone6为基准
 */
#define ADJUST_PERCENT_FLOAT(float)                                     ([HYProjectThemeSizeFactory projectSizeFatoryAdjustPercentFloat:float])

/**
 *  获取字并根据大小适配_系统字体
 */
#define SYSTEM_FONT(float)                                              [UIFont systemFontOfSize: ADJUST_PERCENT_FLOAT(float)]

/**
 *  获取字并根据大小适配_Regular
 */
#define SYSTEM_REGULARFONT(float)                                       [UIFont systemFontOfSize:ADJUST_PERCENT_FLOAT(float) weight:UIFontWeightRegular]

/**
 *  获取字并根据大小适配_Light
 */
#define SYSTEM_LIGHTFONT(float)                                         [UIFont systemFontOfSize:ADJUST_PERCENT_FLOAT(float) weight:UIFontWeightLight]

/**
 *  获取字并根据大小适配_Medium
 */
#define SYSTEM_MEDIUMFONT(float)                                        [UIFont systemFontOfSize:ADJUST_PERCENT_FLOAT(float) weight:UIFontWeightMedium]

// add by 2017年10月10日17:07:38 liu 添加bold字体
/**
 *  获取字并根据大小适配_Bold
 */
#define SYSTEM_BOLDFONT(float)                                        [UIFont systemFontOfSize:ADJUST_PERCENT_FLOAT(float) weight:UIFontWeightBold]
//** =========================================================================================== */
//** =========================================系统路径&单例======================================= */
//** =========================================================================================== */

/**
 * 沙盒Temp文件夹路径
 */
#define SYSTEM_SENDBOX_TEMP                                             NSTemporaryDirectory()

/**
 * 沙盒Document路径
 */
#define SYSTEM_SENDBOX_DOCUMENT                                         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 * 沙盒Cache路径
 */
#define SYSTEM_SENDBOX_CACHE                                            [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 * 主窗口
 */
#define SYSTEM_KEYWINDOW                                                [UIApplication sharedApplication].keyWindow

/**
 * 系统偏好设置单例
 */
#define SYSTEM_USERDEFAULTS                                             [NSUserDefaults standardUserDefaults]

/**
 * 系统通知中心
 */
#define SYSTEM_NOTIFICATIONCENTER                                       [NSNotificationCenter defaultCenter]

//** =========================================================================================== */
//** =======================================设备&系统版本判断====================================== */
//** =========================================================================================== */

/**
 * 判断是否是iPhone
 */
#define IS_IPHONE                                                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])

/**
 * 判断是否为iPad
 */
#define IS_IPAD                                                         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])

/**
 * 判断是否为ipod
 */
#define IS_IPOD                                                         ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/**
 * 判断是否为 iPhone 5SE
 */
#define iPhone5SE                                                       SCREEN_RECT.size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

/**
 * 判断是否为iPhone 6/6s/7
 */
#define iPhone6_6s                                                      SCREEN_RECT.size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

/**
 * 判断是否为iPhone 6Plus/6sPlus/7Plus
 */
#define iPhone6Plus_6sPlus                                              SCREEN_RECT.size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

/**
 判断是否iponeX
 */
#define iPhoneX                                                          [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& IS_IPHONE

/**
 * 判断是否相同版本
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                                      ([SYSTEM_VERSIONSTRING compare:v options:NSNumericSearch] == NSOrderedSame)

/**
 * 判断是否大于版本
 */
#define SYSTEM_VERSION_GREATER_THAN(v)                                  ([SYSTEM_VERSIONSTRING compare:v options:NSNumericSearch] == NSOrderedDescending)

/**
 * 判断大于等于版本
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                      ([SYSTEM_VERSIONSTRING compare:v options:NSNumericSearch] != NSOrderedAscending)

/**
 * 判断小于版本
 */
#define SYSTEM_VERSION_LESS_THAN(v)                                     ([SYSTEM_VERSIONSTRING compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 * 判断小于等于版本
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                         ([SYSTEM_VERSIONSTRING compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 * 是否大于等于iOS6.0
 */
#define IS_IOS6                                                         ((SYSTEM_VERSION >= 6.0) ? YES : NO)

/**
 * 是否大于等于iOS7.0
 */
#define IS_IOS7                                                         ((SYSTEM_VERSION >= 7.0) ? YES : NO)

/**
 * 是否大于等于iOS8.0
 */
#define iOS8                                                            ((SYSTEM_VERSION >= 8.0) ? YES : NO)

/**
 * 是否大于等于iOS9.0
 */
#define iOS9                                                            ((SYSTEM_VERSION >= 9.0) ? YES : NO)

/**
 * 是否大于等于iOS10
 */
#define iOS10                                                           ((SYSTEM_VERSION >= 10.0) ? YES : NO)

/**
 * 是否大于等于iOS11
 */
#define iOS11                                                           ((SYSTEM_VERSION >= 11.0) ? YES : NO)

//** =========================================================================================== */
//** ============================================工具宏========================================== */
//** =========================================================================================== */

/**
 * 打印Log宏
 */
//#ifdef DEBUG
//# define LWLog(fmt, ...) NSLog((@"\n[文件名:%s]\n""[函数名:%s]\n""[行号:%d] \n %s"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__,[[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String]);
//#else
//# define LWLog(...);
//#endif

#ifdef DEBUG

#define LWLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

#else

# define LWLog(...);

#endif

#define ALERT_MSG(msg) static UIAlertView *alert; alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];\

/**
 创建para字典
 */
#define PARA_CREART \
NSMutableDictionary* para = [NSMutableDictionary dictionary];\


#define PARA_SET(value,key) \
[para setValue:value forKey:key];

/**
 保存数据（value,key）
 */
#define  USERDEFAULTS_SET(value,key)\
[SYSTEM_USERDEFAULTS setObject:value forKey:key];
/**
 获取本地信息
 */
#define  USERDEFAULTS_GET(key) [SYSTEM_USERDEFAULTS objectForKey:key]
/**
 移除本地保存信息
 */
#define  USERDEFAULTS_RE(key)  [SYSTEM_USERDEFAULTS removeObjectForKey:key]

/**
 ----发送通知----
 */
#define POST_NOTI(key,obj) [SYSTEM_NOTIFICATIONCENTER postNotificationName:key object:obj];
#define ADD_NOTI(selectorName,key) [SYSTEM_NOTIFICATIONCENTER addObserver:self selector:@selector(selectorName) name:key object:nil];
#define REMOVIE_NOTI(key) [SYSTEM_NOTIFICATIONCENTER removeObserver:self name:key object:nil];

/**
 获取本地图片
 */
#define  IMAGENAME(name) [UIImage imageNamed:name]

/**
 * 获取系统版本字符串
 */
#define SYSTEM_VERSIONSTRING                                                [[UIDevice currentDevice] systemVersion]

/**
 * 获取系统版本
 */
#define SYSTEM_VERSION                                                      ([[[UIDevice currentDevice] systemVersion] floatValue])

/**
 * 获取APP名称
 */
#define APPNAME                                                             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

/**
 * 获取APP版本
 */
#define APPVERSION                                                          ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

/**
 * 获取APP build版本
 */
#define APPBUILDVERSION                                                     ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

/**
 * 弱化指针
 */
#define WEAKSELF(type)                                                      __weak typeof(type) weak##type = type;

/**
 * 获取本地文件(测试使用)
 */
#define LOADLOCALDATA_DATA                                                  [NSData dataWithContentsOfFile:LOCALEDATAPATH]

/**
 *  加载颜色
 */
#define HYCOLOR                                                             [[HYProjectThemeManager sharedManager] themeColorFatory]

/**
 *  处理图片URLString
 */
#define HYIMAGEURLSTRING(type, urlString)                                   [[HYProjectThemeManager sharedManager] resetImageURLStringWithImageType:type URLString:urlString]

/**
 *  RGB
 */
#define RGB(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

/**
 *  Alert
 */
//提示窗
#define ALERT(message)\
[JKAlert alertText:message duration:0.5];\


//StringWithFormat
#define StringWithFormat(Object) [NSString stringWithFormat:@"%@",Object]


#endif /* LWProjectMacro_h */
