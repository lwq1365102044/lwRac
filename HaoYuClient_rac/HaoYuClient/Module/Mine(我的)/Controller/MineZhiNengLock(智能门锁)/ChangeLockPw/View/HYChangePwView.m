//
//  HYChangePwView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChangePwView.h"
#import "HYLeftRightArrowView.h"
#import "HYDefaultTextField.h"
@interface HYChangePwView  ()
@property (nonatomic, strong) HYLeftRightArrowView * PwView;
@property (nonatomic, copy) HYBaseView * codeView;
@property (nonatomic, strong) HYDefaultLabel * codeBtn;
@property (nonatomic, strong)  HYDefaultTextField* codeTextField;
@property (nonatomic, assign) NSInteger  number;

@end
@implementation HYChangePwView

- (void)clickComBtn
{
    [self endEditing:YES];
    PARA_CREART;
    PARA_SET([_PwView.rightTextField.text isNullToString], @"password");
    PARA_SET([_codeTextField.textFiled.text isNullToString], @"code");
    
    if (self.callBlock) {
        self.callBlock(para);
    }
}

- (void)startTimer
{
    [[HYTimerManager shareTimer] startTimerWithTimeInterVal:1.0];
    [[HYTimerManager shareTimer] callBackBlock:^(id sender) {
        _number --;
        _codeBtn.userInteractionEnabled = NO;
        if (_number <= 0) {
            _codeBtn.userInteractionEnabled = YES;
            [[HYTimerManager shareTimer] stopTimer];
            _codeBtn.text = @"获取验证码";
            return ;
        }
        _codeBtn.text = [NSString stringWithFormat:@"%lds",(long)_number];
    }];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubUI];
    }
    return self;
}

- (void)setSubUI{
    _number = 60;
    _PwView = [HYLeftRightArrowView creatLeftRightTextFieldArrowViewWithLeftStr:@"新密码"
                                                                       rightStr:@"请输入新密码"
                                                                  showArrowIcon:NO
                                                                  CallBackBlock:^(id sender) {
                                                                    
                                                                  }];
    _PwView.rightTextField.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    _PwView.rightTextField.maxCount = 6;
    [_PwView.rightTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_PwView.mas_right).mas_offset(-MARGIN*2);
    }];
    
    HYFillLongButton *comBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"提交"
                                                                      target:self
                                                                    selector:@selector(clickComBtn)];
    
    [self addSubview:_PwView];
    [self addSubview:self.codeView];
    [self addSubview:comBtn];
    
    [_PwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN*2);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(44));
    }];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_PwView);
        make.top.mas_equalTo(_PwView.mas_bottom).mas_offset(MARGIN);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(44));
    }];
    [comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
        make.width.mas_offset(SCREEN_WIDTH * 0.7);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_codeView.mas_bottom).mas_offset(MARGIN*4);
    }];
    
    WEAKSELF(self);
    [_codeBtn bk_whenTapped:^{
        if (weakself.getCodeBlock) {
            weakself.getCodeBlock();
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (HYBaseView*)codeView
{
    if (!_codeView) {
        _codeView = [[HYBaseView alloc] init];
        
        _codeBtn = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                            text:@"获取验证码"
                                       textColor:HYCOLOR.color_c4];
        _codeTextField = [HYDefaultTextField creatDefaultTextField:@"验证码"
                                                              font:SYSTEM_REGULARFONT(14)
                                                         textColor:HYCOLOR.color_c4];
        _codeTextField.textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.maxCount = 6;
        _codeBtn.textAlignment = NSTextAlignmentCenter;
        _codeBtn.userInteractionEnabled = YES;
        [_codeView addSubview:_codeBtn];
        [_codeView addSubview:_codeTextField];
        [_codeBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(70), ADJUST_PERCENT_FLOAT(30)));
            make.centerY.mas_equalTo(_codeView.mas_centerY);
            make.right.mas_equalTo(_codeView.mas_right).mas_offset(-MARGIN*2);
        }];
        [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_codeBtn.mas_left);
            make.left.mas_equalTo(_codeView.mas_left).mas_offset(MARGIN);
            make.top.bottom.mas_equalTo(_codeView);
        }];
        UIView *lineview = [[UIView alloc] init];
        lineview.backgroundColor = HYCOLOR.color_c6;
        [_codeView addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0.5);
            make.left.right.bottom.mas_equalTo(_codeView);
        }];
    }
    return _codeView;
}
@end
