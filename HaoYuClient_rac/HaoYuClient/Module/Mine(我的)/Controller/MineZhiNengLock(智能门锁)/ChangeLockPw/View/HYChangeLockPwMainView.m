//
//  HYChangeLockPwMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChangeLockPwMainView.h"
#import "HYVerticalButton.h"
#import "LWSoundWave.h"
@interface HYChangeLockPwMainView ()
@property (nonatomic, strong) HYDefaultLabel *titleLable;
@property (nonatomic, strong) HYBaseView * lockBgView;
@property (nonatomic, strong) HYDefaultLabel * dianliangLable;
@property (nonatomic, strong) HYDefaultLabel * descName;
@property (nonatomic, strong) UIImageView * lock_icon;
@property (nonatomic, strong) HYDefaultLabel *lockwhere;

@end

@implementation HYChangeLockPwMainView

- (void)setLockMesgModel:(HYLockModel *)lockMesgModel
{
    _lockMesgModel = lockMesgModel;
    _titleLable.text = lockMesgModel.fullAdress;
    _dianliangLable.text = [NSString stringWithFormat:@"电量：%@%%",lockMesgModel.electricQuantity];
    _descName.text = [NSString stringWithFormat:@"%@智能门锁",lockMesgModel.lockTypeStr];
    
    NSString *iconName;
    NSInteger dian = [lockMesgModel.electricQuantity integerValue];
    if (dian <= 5){
        iconName = @"dianliang_1";
    }else if (dian >5 && dian <=20){
        iconName = @"dianliang_2";
    }else if (dian >20 && dian <=40){
        iconName = @"dianliang_3";
    }else if (dian >40 && dian <=70){
        iconName = @"dianliang_4";
    }else if (dian >70 && dian <=95){
        iconName = @"dianliang_5";
    }else {
        iconName = @"dianliang_6";
    }
    _lock_icon.image = IMAGENAME(iconName);
    
    if(lockMesgModel.parenthousrid){
        _lockwhere.text = @"大门门锁";
    }else{
        _lockwhere.text = @"房间门锁";
    }
}
- (void)clickBtn:(UIButton *)sender
{
    if (self.callBlock) {
        self.callBlock(sender);
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        
//        [LWSoundWave startAnimationWithanimationView:self.lockBgView animationSuperView:self];
    }
    return self;
}
- (void)setUI
{
    _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    _titleLable.numberOfLines = 2;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    HYDefaultLabel *lockwhere = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                    text:@"大门门锁"
                                               textColor:HYCOLOR.color_c4];
    _lockwhere = lockwhere;
    _lockwhere.backgroundColor = [UIColor clearColor];
    HYDefaultLabel *descName = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                    text:@"果加智能门锁"
                                               textColor:HYCOLOR.color_c2];
    _alerName = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                        text:@"左右滑动切换父子门锁"
                                                   textColor:HYCOLOR.color_c2];
    _alerName.hidden = YES;
    
    HYVerticalButton *remoteBtn = [HYVerticalButton buttonVerImageAndTitleWithTitle:@"远程开锁"
                                                                         imageNamed:@"remoteOpenDoorIcon"
                                                                             target:self
                                                                           selector:@selector(clickBtn:)];
    remoteBtn.tag = self.tag;
    HYVerticalButton *changePWBtn = [HYVerticalButton buttonVerImageAndTitleWithTitle:@"修改密码"
                                                                         imageNamed:@"changeDoorPwIcon"
                                                                             target:self
                                                                           selector:@selector(clickBtn:)];
    [self addSubview:_titleLable];
    [self addSubview:self.lockBgView];
    [self addSubview:lockwhere];
    [self addSubview:descName];
    [self addSubview:_alerName];
    [self addSubview:remoteBtn];
    [self addSubview:changePWBtn];
    _descName = descName;
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN*3);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN*2);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*2);
    }];
    [_lockBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(120), ADJUST_PERCENT_FLOAT(120)));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-MARGIN*12);
    }];
    [lockwhere mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lockBgView.mas_bottom).mas_offset(MARGIN*4);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [descName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lockwhere.mas_bottom).mas_offset(MARGIN*2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [_alerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descName.mas_bottom).mas_offset(MARGIN*2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [remoteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*5);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN*3);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(80));
    }];
    [changePWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(remoteBtn.mas_centerY);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*3);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(80));
    }];
    
    [_lockBgView setBoundWidth:0 cornerRadius:ADJUST_PERCENT_FLOAT(60)];
}

- (HYBaseView*)lockBgView
{
    if (!_lockBgView) {
        _lockBgView = [[HYBaseView alloc] init];
        _lockBgView.backgroundColor = [UIColor ex_colorWithHexString:@"0xaee2c4" alpha:1];
        UIImageView *lock = [[UIImageView alloc] init];
        [_lockBgView addSubview:lock];
        _lock_icon = lock;
        lock.image = IMAGENAME(@"dianliang_1");
        _dianliangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                   text:@"电量:"
                                              textColor:HYCOLOR.color_c0];
        _dianliangLable.backgroundColor = [UIColor clearColor];
        [_lockBgView addSubview:_dianliangLable];
        [lock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(50), ADJUST_PERCENT_FLOAT(50)));
            make.centerX.mas_equalTo(_lockBgView.mas_centerX);
            make.centerY.mas_equalTo(_lockBgView.mas_centerY).mas_offset(-ADJUST_PERCENT_FLOAT(5));
        }];
        [_dianliangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_lockBgView.mas_centerX);
            make.top.mas_equalTo(lock.mas_bottom).mas_offset(MARGIN/2);
        }];
    }
    return _lockBgView;
}
@end
