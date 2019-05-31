//
//  HYAddPhotoView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/4.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@protocol addPhotoDelegate <NSObject>
/**
 选择图片
 */
- (void)gotoChooseImages;

//删除图片
- (void)deleImage:(UIImage *)image;
//重新上传
- (void)reUploadImage:(UIImage *)image;

@end

@interface HYAddPhotoView : HYBaseView
- (void)chooseImages:(NSArray *)imgs;
/**
 图片数组
 */
@property (nonatomic, strong) NSMutableArray * ImagesDataArr;
@property (nonatomic, weak) id<addPhotoDelegate>  delegate;
@property (nonatomic, strong) HYDefaultLabel * titleLable;
@end