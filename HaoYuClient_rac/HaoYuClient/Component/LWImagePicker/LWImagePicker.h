//
//  LWImagePicker.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/8/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWImagePicker : NSObject
+ (instancetype)share;
/**
 sourceVc                   来源控制器
 allowsEditing               是否编辑
 callBlock                   返回图片
 */
- (void)imagePickerWithSourceVc:(UIViewController *)sourceVc allowsEditing:(BOOL)allowsEditing callBlock:(HYEventCallBackBlock)callBlock;

@end
