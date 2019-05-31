//
//  HYBillListItemView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBillListItemView.h"

@implementation HYBillListItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

+ (instancetype)creatItemView
{
    HYBillListItemView *tem = [[HYBillListItemView alloc] init];
    [tem setUI];
    return tem;
}

- (void)setUI
{
    self.titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"" textColor:HYCOLOR.color_c4];
    self.timeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(10) text:@"" textColor:HYCOLOR.color_c4];
    self.priceLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(16) text:@"" textColor:HYCOLOR.color_c4];
    self.descLalbe = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:[UIColor grayColor]];
    
    [self addSubview:self.titleLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.priceLable];
    [self addSubview:self.descLalbe];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-5);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_left);
         make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(5));
    }];
    [self.descLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_left);
        make.top.mas_equalTo(self.timeLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(5));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(5)).priorityHigh();
    }];
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
