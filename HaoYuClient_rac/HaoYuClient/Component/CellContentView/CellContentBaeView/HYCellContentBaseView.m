//
//  HYCellContentBaseView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYCellContentBaseView.h"
#import "BlocksKit+UIKit.h"
@interface HYCellContentBaseView ()<UITextFieldDelegate>

@end
@implementation HYCellContentBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor                      = HYCOLOR.color_c0;
        self.leftLable                            = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        self.rightLable                           = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
        self.rightLable.textAlignment             = NSTextAlignmentRight;
        self.arrowImageview                       = [[UIImageView alloc] init];
        self.bottomLine                           = [[UIView alloc] init];
        self.bottomLine.backgroundColor           = HYCOLOR.color_c6;
        self.rightTextField                       = [HYDefaultTextField creatDefaultTextField:@""
                                                                                          font:SYSTEM_REGULARFONT(14)
                                                                                     textColor:HYCOLOR.color_c4];
        self.rightTextField.textFiled.textAlignment         = NSTextAlignmentRight;
        self.rightImageView                       = [[UIImageView alloc] init];
        self.arrowImageview.image                 = IMAGENAME(@"arrow_right_nor");
        self.rightImageView.contentMode           = UIViewContentModeScaleAspectFill;
        [self addSubview:self.leftLable];
        [self addSubview:self.rightLable];
        [self addSubview:self.arrowImageview];
        [self addSubview:self.bottomLine];
        [self addSubview:self.rightTextField];
        [self addSubview:self.rightImageView];
        
        self.rightTextField.textFiled.textAlignment = NSTextAlignmentRight;
        WEAKSELF(self);
        
        self.rightTextField.textFiled.bk_didEndEditingBlock = ^(UITextField *tf) {
            if (weakself.CallBackBlock) {
                weakself.CallBackBlock(weakself);
            }
        };
    }
    return self;
}

@end
