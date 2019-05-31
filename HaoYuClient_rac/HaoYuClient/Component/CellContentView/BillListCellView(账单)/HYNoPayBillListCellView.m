//
//  HYNoPayBillListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYNoPayBillListCellView.h"
#import "HYLevelLable.h"
#import "HYDiscountModel.h"
@interface HYNoPayBillListCellView ()

@property (nonatomic, strong) HYBaseView * line;

@property (nonatomic, strong) HYBaseView * dis_bg;
@property (nonatomic, assign) BOOL isShowDisc;

@end

@implementation HYNoPayBillListCellView

+ (instancetype)creatNoPayBillListCellView
{
    HYNoPayBillListCellView *instance =  [[HYNoPayBillListCellView alloc] init];
    instance.isShow = YES;
    instance.leftSelectBtn.hidden =  NO;
    [instance addSubViews];
    return instance;
}

- (void)addSubViews
{
    _line = [[HYBaseView alloc] init];
    _line.backgroundColor = HYCOLOR.color_c3;
    _selectBtn = [HYDefaultButton buttonWithTitleStringKey:@"使用优惠券"
                                                titleColor:[UIColor whiteColor]
                                                 titleFont:SYSTEM_REGULARFONT(15)
                                                    target:self
                                                  selector:nil];
    _selectBtn.backgroundColor = HYCOLOR.color_c3;
    [_selectBtn setBoundWidth:0 cornerRadius:4];
    [self addSubview:_line];
    [self addSubview:_selectBtn];
    [self addSubview:self.dis_bg];
    [self updateConsWithisShow:NO];
}

- (void)updateConsWithisShow:(BOOL)isshow;
{
    _isShowDisc = isshow;
    _dis_bg.hidden = !isshow;
    _line.hidden = !isshow;
    _selectBtn.hidden = !isshow;
    
    if (isshow) {
        [self.billInfor_Bg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(50));
        }];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.billInfor_Bg.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(1);
        }];
        [_selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*9, MARGIN*2));
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*2);
            make.top.mas_equalTo(_line.mas_bottom).mas_offset(10);
        }];
        [self.dis_bg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_selectBtn.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.bottom.mas_equalTo(self).mas_offset(-MARGIN);
        }];
    }else{
        [self.billInfor_Bg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
            make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(50));
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        }];
    }
}

- (void)setDiscountDatas:(NSArray *)datas
{
    if (datas == nil || datas.count == 0) {
        [self.dis_bg removeAllSubviews];
        [self updateConsWithisShow:_isShowDisc];
        return;
    }
    if (!self.isShowDisc) {
        return;
    }
    [self.dis_bg removeAllSubviews];
    for (int i = 0; i < datas.count; i ++) {
         HYDiscountModel *model = datas[i];
        HYLevelLable *item = [HYLevelLable creatLevelLable:model.couponTitle rightStr:[NSString stringWithFormat:@"优惠%@元",model.iosDedicated]];
        HYLevelLable *last = self.dis_bg.subviews.lastObject;
        [_dis_bg addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.mas_equalTo(_dis_bg.mas_top).mas_offset(MARGIN);
            }else{
                make.top.mas_equalTo(last.mas_bottom).mas_offset(MARGIN);
            }
            make.left.mas_equalTo(self.dis_bg.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.dis_bg.mas_right).mas_offset(-MARGIN);
            if (i == datas.count - 1) {
                make.bottom.mas_equalTo(self.dis_bg.mas_bottom).mas_offset(-MARGIN);
            }
        }];
    }
    
}

- (HYBaseView*)dis_bg
{
    if (!_dis_bg) {
        _dis_bg = [[HYBaseView alloc] init];
    }
    return _dis_bg;
}
@end
