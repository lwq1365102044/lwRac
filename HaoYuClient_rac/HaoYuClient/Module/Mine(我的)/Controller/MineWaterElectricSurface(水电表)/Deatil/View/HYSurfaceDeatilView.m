//
//  HYSurfaceDeatilView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYSurfaceDeatilView.h"
#import "HYVerticalLable.h"
#import "HYSegmentView.h"
@interface HYSurfaceDeatilView ()<SegmentBtnViewDelegate>
{
    CGFloat MARGIN ;
    UIColor * lineColor;
}
@property (nonatomic, strong) HYBaseView * bgView;

@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) HYBaseView * topView;
@property (nonatomic, strong) HYDefaultLabel * top_titleLable;
@property (nonatomic, strong) HYDefaultLabel * top_allcountLable;
@property (nonatomic, strong) HYDefaultLabel * top_allcount_descLable;

@property (nonatomic, strong) HYVerticalLable * yesterDay_dianfeiLable;
@property (nonatomic, strong) HYVerticalLable * yesterDay_diancountLable;
@property (nonatomic, strong) HYVerticalLable * dianfeishengyuLable;
@property (nonatomic, strong) HYVerticalLable * dianliangshengyuLable;
@property (nonatomic, strong) HYSegmentView * segmentedControl;
@property (nonatomic, assign) NSInteger segmentedIndex;
@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation HYSurfaceDeatilView

- (void)setSurfaceDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    HYShuiDianBiaoModel *dataModel = dataArray[_segmentedIndex];
    _titleLable.text = dataModel.fullAdress;
    if ([_typeStr isEqualToString:@"电表"]) {
        _top_allcountLable.text = dataModel.sumDian;
        _yesterDay_dianfeiLable.bottomLable.text = dataModel.dianFei;
        _yesterDay_diancountLable.bottomLable.text = dataModel.dianLiang;
        _dianfeishengyuLable.bottomLable.text = dataModel.dianYuE;
        _dianliangshengyuLable.bottomLable.text = dataModel.dianYuLiang;
    }else if ([_typeStr isEqualToString:@"水表"]){
        _segmentedControl.hidden    = !(dataArray.count > 1);
        _top_titleLable.hidden      = (dataArray.count > 1);
        
        _top_allcountLable.text = dataModel.sumShui;
        _yesterDay_dianfeiLable.bottomLable.text = dataModel.shuiFei;
        _yesterDay_diancountLable.bottomLable.text = dataModel.shuiLiang;
        _dianfeishengyuLable.bottomLable.text = dataModel.shuiYuE;
        self.dianliangshengyuLable.bottomLable.text = dataModel.shuiYuLiang;
    }
}

- (void)SegmentView:(HYSegmentView *)segmentView selectIndex:(NSInteger)selectIndex
{
    _segmentedIndex = selectIndex;
    if ([self.delegate respondsToSelector:@selector(switchWaterSufaceWithSegIndex:)]) {
        [self.delegate switchWaterSufaceWithSegIndex:_segmentedIndex];
    }
    [self setSurfaceDataArray:_dataArray];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        MARGIN          = ADJUST_PERCENT_FLOAT(10);
        lineColor       = HYCOLOR.color_c6;
        [self setUI];
        _segmentedIndex = 0;
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
}

- (void)setTypeStr:(NSString *)typeStr
{
    _typeStr = typeStr;
    NSString *top_des ;
    NSString *yes_pri;
    NSString *yes_count;
    NSString *pri;
    NSString *count;
    NSString *paystr;
    if ([typeStr isEqualToString:@"水表"]) {
        top_des                 = @"累计用水量（m³）";
        yes_pri                 = @"昨天水费（元）";
        yes_count               = @"昨天水量（m³）";
        pri                     = @"水费余额（元）";
        count                   = @"水量余额（m³）";
        paystr                  = @"充值水费";
    }else if ([typeStr isEqualToString:@"电表"]){
        top_des                 = @"累计用电量（kw·h）";
        yes_pri                 = @"昨天电费（元）";
        yes_count               = @"昨天电量（kw·h）";
        pri                     = @"电费余额（元）";
        count                   = @"电量余额（kw·h）";
        paystr                  = @"充值电费";
    }
    _top_titleLable.text                         = typeStr;
    _top_allcount_descLable.text                 = top_des;
    _yesterDay_dianfeiLable.topLable.text        = yes_pri;
    _yesterDay_diancountLable.topLable.text      = yes_count;
    _dianfeishengyuLable.topLable.text           = pri;
    _dianliangshengyuLable.topLable.text         = count;
    _payLable.text                               = paystr;
    
    
    _topView.backgroundColor                     = HYCOLOR.color_c36;
    _payLable.backgroundColor                    = HYCOLOR.color_c36;
    
    
    [self.topView setBoundWidth:0 cornerRadius:4];
    [_payLable setBoundWidth:0 cornerRadius:4];
    [self.bgView setBoundWidth:0 cornerRadius:4];
    
}

- (HYBaseView*)bgView
{
    if (!_bgView) {
        _bgView                                 = [[HYBaseView alloc] init];
        _titleLable                             = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                           text:@""
                                                                      textColor:HYCOLOR.color_c4];
        _yesterDay_dianfeiLable                 = [[HYVerticalLable alloc] init];
        _yesterDay_diancountLable               = [[HYVerticalLable alloc] init];
        _dianfeishengyuLable                    = [[HYVerticalLable alloc] init];
        _dianliangshengyuLable                  = [[HYVerticalLable alloc] init];
        _payLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                             text:@""
                                        textColor:HYCOLOR.color_c4];
        HYDefaultLabel *payRecordL                = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                                           text:@"充值记录"
                                                                      textColor:HYCOLOR.color_c2];
        payRecordL.textAlignment                = NSTextAlignmentCenter;
        _titleLable.textAlignment               = NSTextAlignmentCenter;
        _titleLable.numberOfLines               = 2;
        _payLable.textAlignment                 = NSTextAlignmentCenter;
        _payLable.userInteractionEnabled        = YES;
        UIView *line0                           = [[UIView alloc] init];
        UIView *line1                           = [[UIView alloc] init];
        UIView *line2                           = [[UIView alloc] init];
        line0.backgroundColor                   = lineColor;
        line1.backgroundColor                   = lineColor;
        line2.backgroundColor                   = lineColor;
        [_bgView addSubview:_titleLable];
        [_bgView addSubview:self.topView];
        [_bgView addSubview:_yesterDay_dianfeiLable];
        [_bgView addSubview:_yesterDay_diancountLable];
        [_bgView addSubview:_dianfeishengyuLable];
        [_bgView addSubview:_dianliangshengyuLable];
        [_bgView addSubview:_payLable];
        [_bgView addSubview:line0];
        [_bgView addSubview:line1];
        [_bgView addSubview:line2];
//        [_bgView addSubview:payRecordL];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bgView.mas_top).mas_offset(MARGIN*2);
            make.centerX.mas_equalTo(_bgView.mas_centerX);
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
        }];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
        }];
        [_yesterDay_dianfeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_topView.mas_left);
            make.right.mas_equalTo(_yesterDay_diancountLable.mas_left).mas_offset(-1);
            make.width.mas_equalTo(_yesterDay_diancountLable.mas_width);
        }];
        [_yesterDay_diancountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_yesterDay_dianfeiLable.mas_top);
            make.right.mas_equalTo(_topView.mas_right);
            make.left.mas_equalTo(_yesterDay_dianfeiLable.mas_right).mas_offset(1);
            make.width.mas_equalTo(_yesterDay_dianfeiLable.mas_width);
        }];
        [_dianfeishengyuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_yesterDay_dianfeiLable.mas_bottom).mas_offset(MARGIN/2);
            make.left.mas_equalTo(_yesterDay_dianfeiLable.mas_left);
            make.right.mas_equalTo(_dianliangshengyuLable.mas_left).mas_offset(-1);
            make.width.mas_equalTo(_dianliangshengyuLable.mas_width);
        }];
        [_dianliangshengyuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dianfeishengyuLable.mas_top);
            make.right.mas_equalTo(_yesterDay_diancountLable.mas_right);
            make.left.mas_equalTo(_dianfeishengyuLable.mas_right).mas_offset(1);
            make.width.mas_equalTo(_dianfeishengyuLable.mas_width);
        }];
        [_payLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(MARGIN*4);
            make.top.mas_equalTo(_dianfeishengyuLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(30));
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(30));
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(-MARGIN*3);
        }];
//        [payRecordL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_offset(CGSizeMake(MARGIN*8, MARGIN*3));
//            make.centerX.mas_equalTo(_bgView.mas_centerX);
//            make.top.mas_equalTo(_payLable.mas_bottom).mas_offset(MARGIN*2);
//        }];
        [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_yesterDay_dianfeiLable.mas_top);
            make.width.mas_offset(0.5);
            make.centerX.mas_equalTo(_bgView.mas_centerX);
            make.bottom.mas_equalTo(_dianfeishengyuLable.mas_bottom);
        }];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_yesterDay_dianfeiLable.mas_bottom);
            make.height.mas_offset(0.5);
            make.left.right.mas_equalTo(_bgView);
        }];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dianfeishengyuLable.mas_bottom);
            make.height.mas_offset(0.5);
            make.left.right.mas_equalTo(_bgView);
        }];
        
        payRecordL.userInteractionEnabled = YES;
        [payRecordL bk_whenTapped:^{
            if ([self.delegate respondsToSelector:@selector(gotoRechargeHistoryList)]) {
                [self.delegate gotoRechargeHistoryList];
            }
        }];
    }
    return _bgView;
}

- (HYBaseView*)topView
{
    if (!_topView) {
        _topView                                 = [[HYBaseView alloc] init];
        _top_titleLable                          = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(16)
                                                                       text:@""
                                                                  textColor:HYCOLOR.color_c4];
        _top_allcountLable                       = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                                            text:@""
                                                                       textColor:HYCOLOR.color_c4];
        _top_allcount_descLable                  = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                                                            text:@""
                                                                       textColor:HYCOLOR.color_c4];
        _top_titleLable.textAlignment            = NSTextAlignmentCenter;
        _top_allcount_descLable.textAlignment    = NSTextAlignmentCenter;
        _top_allcountLable.textAlignment         = NSTextAlignmentCenter;
        UIView *line                             = [[UIView alloc] init];
        line.backgroundColor                     = [UIColor whiteColor];
        _segmentedControl = [HYSegmentView segmentViewWithTitles:@[@"冷水表",@"热水表"]
                                             btnTitleNormalColor:HYCOLOR.color_c4
                                             btnTitleSelectColor:HYCOLOR.color_c0
                                        btnBackgroundNormalColor:HYCOLOR.color_c36
                                        btnBackgroundSelectColor:HYCOLOR.color_c3
                                      SegmentBtnSelectIndexBlock:nil];
        _segmentedControl.delegate = self;
        
        
        [_topView addSubview:_segmentedControl];
        [_topView addSubview:line];
        [_topView addSubview:_top_titleLable];
        [_topView addSubview:_top_allcount_descLable];
        [_topView addSubview:_top_allcountLable];
        
        [_top_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_top).mas_offset(MARGIN);
            make.centerX.mas_equalTo(_topView.mas_centerX);
            make.left.right.mas_equalTo(_topView);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_topView);
            make.height.mas_offset(0.5);
            make.top.mas_equalTo(_top_titleLable.mas_bottom).mas_offset(MARGIN);
        }];
        [_top_allcountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_topView);
            make.top.mas_equalTo(line.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(25));
            make.centerX.mas_equalTo(_topView.mas_centerX);
        }];
        [_top_allcount_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_topView);
            make.top.mas_equalTo(_top_allcountLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(20));
            make.centerX.mas_equalTo(_topView.mas_centerX);
            make.bottom.mas_equalTo(_topView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(20));
        }];
        [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*15, MARGIN*2.5));
            make.top.mas_equalTo(_topView.mas_top).mas_offset(MARGIN);
            make.centerX.mas_equalTo(_topView.mas_centerX);
        }];
        _segmentedControl.hidden = YES;
        _top_titleLable.hidden   = NO;
        
        _top_allcountLable.backgroundColor       = [UIColor clearColor];
        _top_titleLable.backgroundColor          = [UIColor clearColor];
        _top_allcount_descLable.backgroundColor  = [UIColor clearColor];
    }
    return _topView;
}

@end
