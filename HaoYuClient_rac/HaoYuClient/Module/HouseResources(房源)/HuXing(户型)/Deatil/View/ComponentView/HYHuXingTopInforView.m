//
//  HYHuXingTopInforView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingTopInforView.h"

@implementation HYHuXingTopInforView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titileLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(17)
                                                text:@""
                                           textColor:HYCOLOR.color_c4];
        _baozhangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                  text:@""
                                             textColor:HYCOLOR.color_c4];
        _yongjinLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                 text:@""
                                            textColor:HYCOLOR.color_c4];
        _priceLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(22)
                                                 text:@""
                                            textColor:HYCOLOR.color_c3];
        _collectBtn = [HYDefaultButton buttonImageWithImageNamed:@"house_collect_icon"
                                                            type:(HYProjectButtonSetImage) target:self
                                                        selector:nil];
        [_collectBtn setImage:IMAGENAME(@"house_collect_s_icon") forState:UIControlStateSelected];
//        _collectBtn.lw_acceptEventInterval = 1;
        [self addSubview:_collectBtn];
        [self addSubview:_titileLable];
        [self addSubview:_baozhangLable];
        [self addSubview:_yongjinLable];
        [self addSubview:_priceLable];
        [_titileLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self).mas_offset(MARGIN*1.5);
        }];
        [_baozhangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titileLable.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(_titileLable.mas_left);
        }];
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_baozhangLable.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*2);
        }];
        [_yongjinLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_baozhangLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(_titileLable.mas_left);
            make.height.mas_offset(MARGIN*2.5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN*1.5);
        }];
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*3, MARGIN*3));
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN/2);
        }];
        [_yongjinLable setBoundWidth:0.5 cornerRadius:4 boardColor:HYCOLOR.color_c6];
    }
    return self;
}

@end
