//
//  HYZuYue_PersonInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYZuYue_PersonInforView.h"
#import "HYZuYue_InforBaseView.h"
@interface HYZuYue_PersonInforView ()
@property (nonatomic, strong) HYZuYue_InforBaseView * baseView;
@end
@implementation HYZuYue_PersonInforView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _baseView = [[HYZuYue_InforBaseView alloc] init];
        _baseView.titleLable.text = @"个人信息";
//        _baseView.dataArray = @[@{@"left":@"姓名",@"right":[HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_NAME)]},
//                                @{@"left":@"手机号",@"right":[HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)]},];

        [_baseView setBoundWidth:1 cornerRadius:6 boardColor:HYCOLOR.color_c6];
        
        _nameView = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"*姓名"
                                                                             rightStr:@"请输入姓名"
                                                                        showArrowIcon:NO
                                                                        CallBackBlock:^(id sender) {
                                                                            
                                                                        }];
        _phoneView = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"*手机号"
                                                                             rightStr:@"请输入手机号"
                                                                        showArrowIcon:NO
                                                                        CallBackBlock:^(id sender) {
                                                                            
                                                                        }];
        _phoneView.rightTextField.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _phoneView.rightTextField.textFiled.text = USERDEFAULTS_GET(USER_INFOR_PHONE);
        [_baseView addSubview:_nameView];
        [_baseView addSubview:_phoneView];
        [self addSubview:_baseView];
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_nameView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_baseView.titleLable.mas_bottom).mas_offset(MARGIN);
            make.left.right.mas_equalTo(_baseView);
            make.height.mas_offset(MARGIN*5);
        }];
        [_phoneView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameView.mas_bottom).mas_offset(0);
            make.left.right.mas_equalTo(_baseView);
            make.height.mas_offset(MARGIN*5);
            make.bottom.mas_equalTo(_baseView.mas_bottom).mas_offset(-MARGIN);
        }];
    }
    return self;
}

@end
