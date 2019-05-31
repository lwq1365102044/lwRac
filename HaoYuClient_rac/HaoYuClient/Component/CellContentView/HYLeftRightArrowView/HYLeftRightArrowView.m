//
//  HYLeftRightArrowView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYLeftRightArrowView.h"

@interface HYLeftRightArrowView()
{
    CGSize imageSize;
}

@end

@implementation HYLeftRightArrowView

/**
 right Lable
 leftStr    左边文字
 rightStr   右边文字
 */
+ (instancetype)creatLeftRightLableArrowViewWithLeftStr:(NSString *)leftStr
                                               rightStr:(NSString *)rightStr
                                          showArrowIcon:(BOOL)showArrow
                                          CallBackBlock:(HYEventCallBackBlock)CallBackBlock
{
    HYLeftRightArrowView *temp              = [[HYLeftRightArrowView alloc] init];
    temp.ViewType                           = rightLableType;
    temp.isHiddenR_icon                     = !showArrow;
    [temp setUI];
    temp.CallBackBlock                      = CallBackBlock;
    temp.rightTextField.hidden              = YES;
    temp.rightLable.hidden                  = NO;
    temp.arrowImageview.hidden              = !showArrow;
    temp.leftLable.text                     = leftStr;
    temp.rightLable.text                    = rightStr;
    return temp;
}

/**
 right TextField
 leftStr    左边文字
 rightStr   右边站位文字
 */
+ (instancetype)creatLeftRightTextFieldArrowViewWithLeftStr:(NSString *)leftStr
                                                   rightStr:(NSString *)rightStr
                                              showArrowIcon:(BOOL)showArrow
                                              CallBackBlock:(HYEventCallBackBlock)CallBackBlock
{
    HYLeftRightArrowView *temp               = [[HYLeftRightArrowView alloc] init];
    temp.ViewType                           = rightTextFieldType;
    temp.isHiddenR_icon                     = !showArrow;
    [temp setUI];
    temp.CallBackBlock                      = CallBackBlock;
    temp.rightTextField.hidden               = NO;
    temp.rightLable.hidden                   = YES;
    temp.arrowImageview.hidden               = !showArrow;
    temp.leftLable.text                      = leftStr;
    temp.rightTextField.textFiled.placeholder          = rightStr;
    return temp;
}

/**
 right imageview
 leftStr    左边文字
 imageName  右边图片名称
 */
+ (instancetype)creatLeftRightImageViewArrowViewWithLeftStr:(NSString *)leftStr
                                                  imageName:(NSString *)imageName
                                                  imageSize:(CGSize)imageSize
                                              showArrowIcon:(BOOL)showArrow
                                              CallBackBlock:(HYEventCallBackBlock)CallBackBlock
{
    HYLeftRightArrowView *temp               = [[HYLeftRightArrowView alloc] init];
    temp->imageSize                         = imageSize;
    temp.ViewType                           = rightIconType;
    temp.isHiddenR_icon                     = !showArrow;
    [temp setUI];
    temp.CallBackBlock                      = CallBackBlock;
    temp.rightTextField.hidden               = YES;
    temp.rightLable.hidden                   = YES;
    temp.arrowImageview.hidden               = !showArrow;
    temp.leftLable.text                      = leftStr;
    temp.rightImageView.image                = IMAGENAME(imageName);
    return temp;
}

- (void)setUI
{
    [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
//        make.width.mas_offset(ADJUST_PERCENT_FLOAT(120));
    }];
    CGFloat tem = ADJUST_PERCENT_FLOAT(36);
    if (self.isHiddenR_icon) {
        tem = MARGIN;
    }
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.leftLable.mas_right).mas_offset(MARGIN*2);
        make.width.mas_greaterThanOrEqualTo(@120);
        make.right.mas_equalTo(self.mas_right).mas_offset(-tem);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2);
        make.top.mas_equalTo(self.mas_top).mas_offset(2);
        make.width.mas_greaterThanOrEqualTo(@120);
        make.left.mas_equalTo(self.leftLable.mas_right).mas_offset(MARGIN*2);
        make.right.mas_equalTo(self.mas_right).mas_offset(-tem);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(imageSize.width), ADJUST_PERCENT_FLOAT(imageSize.height)));
        make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(36));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(9), ADJUST_PERCENT_FLOAT(15)));
        make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0.5);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-1);
    }];
    
    if (self.ViewType != rightTextFieldType ) {
        [self bk_whenTapped:^{
            if (self.CallBackBlock) {
                self.CallBackBlock(self);
            }
        }];
    }
}
- (void)updateConst
{}
@end
