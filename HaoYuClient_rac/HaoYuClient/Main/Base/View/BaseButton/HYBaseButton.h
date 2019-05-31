//
//  HYBaseButton.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+LWdelay.h"
@interface HYBaseButton : UIButton

/**
 初始化Button
 
 @param titleStringKey                      文字的key
 @param titleColor                          文字颜色
 @param titleFont                           文字字体
 @param backgroundImageNor                  背景图片普通
 @param backgroundImageHig                  背景图片高亮
 @parma backgroundImageDis                  背景禁用图片
 @param target                              响应对象
 @param selector                            事件
 @return                                    button对象
 */
+ (instancetype)buttonWithTitleStringKey:(NSString *)titleStringKey
                              titleColor:(UIColor *)titleColor
                               titleFont:(UIFont *)titleFont
                      backgroundImageNor:(UIImage *)backgroundImageNor
                      backgroundImageDis:(UIImage *)backgroundImageDis
                      backgroundImageHig:(UIImage *)backgroundImageHig
                                  target:(id)target
                                selector:(SEL)selector;

/**
 初始化Button
 
 @param titleStringKey                      文字的key
 @param titleColor                          文字颜色
 @param titleFont                           文字字体
 @param imageDis                            图片普通
 @param imageHig                            图片高亮
 @parma imageDis                            禁用图片
 @param target                              响应对象
 @param selector                            事件
 @return                                    button对象
 */
+ (instancetype)buttonWithTitleStringKey:(NSString *)titleStringKey
                              titleColor:(UIColor *)titleColor
                               titleFont:(UIFont *)titleFont
                                imageNor:(UIImage *)imageNor
                                imageDis:(UIImage *)imageDis
                                imageHig:(UIImage *)imageHig
                                  target:(id)target
                                selector:(SEL)selector;
@end