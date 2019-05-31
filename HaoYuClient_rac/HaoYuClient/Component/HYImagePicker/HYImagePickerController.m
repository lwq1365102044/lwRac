//
//  HYImagePickerController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYImagePickerController.h"

@implementation HYImagePickerController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

/**
 图片选择器
 
 @param maxCount                maxCount 最大图片数量
 @param callBackBlock           callBackBlock 回调
 @return                        图片选择器
 */
//+ (instancetype)imagePickerControllerWithMaxCount:(NSInteger)maxCount
//                                    callBackBlock:(HYImagePickerCallBackBlock)callBackBlock
//{
//    HYImagePickerController *imageController = [[HYImagePickerController alloc] initWithMaxImagesCount:maxCount
//                                                                                          columnNumber:4
//                                                                                              delegate:nil];
//    [imageController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> * imageArrays, NSArray * array, BOOL isBool) {
//        callBackBlock(imageArrays, array, isBool);
//    }];
//
//    imageController.sortAscendingByModificationDate = NO;
//    imageController.allowTakePicture = NO;
//    imageController.barItemTextColor = HYCOLOR.color_c4;
//    imageController.navigationBar.barStyle = UIBarStyleDefault;
//    imageController.barItemTextFont = SYSTEM_REGULARFONT(16.f);
//    imageController.oKButtonTitleColorNormal = HYCOLOR.color_c6;
//    imageController.oKButtonTitleColorDisabled = [HYCOLOR.color_c6 colorWithAlphaComponent:0.4];
//    imageController.allowPickingVideo = NO;
//
//    return imageController;
//}

/**
 视频选择器
 
 @param callBackBlock           callBackBlock 回调
 @return                        图片选择器
 */
//+ (instancetype)imagePickerWithCallBackBlock:(HYImagePickerVideoCallBackBlock)callBackBlock
//{
//    HYImagePickerController *imageController = [[HYImagePickerController alloc] initWithMaxImagesCount:1
//                                                                                          columnNumber:4
//                                                                                              delegate:nil];
//    [imageController setDidFinishPickingVideoHandle:^(UIImage *image, id obj) {
//        if (callBackBlock) {
//            callBackBlock(image, obj);
//        }
//    }];
//    
//    imageController.sortAscendingByModificationDate = NO;
//    imageController.allowTakePicture = NO;
//    imageController.barItemTextColor = HYCOLOR.color_c4;
//    imageController.navigationBar.barStyle = UIBarStyleDefault;
//    imageController.barItemTextFont = SYSTEM_REGULARFONT(16.f);
//    imageController.oKButtonTitleColorNormal = HYCOLOR.color_c6;
//    imageController.oKButtonTitleColorDisabled = [HYCOLOR.color_c6 colorWithAlphaComponent:0.4];
//    imageController.allowPickingVideo = YES;
//    
//    return imageController;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

@end
