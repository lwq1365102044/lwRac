//
//  HYJiChuSheShiView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYJiChuSheShiView.h"
#import "HYJiuGongGeView.h"

@implementation HYJiChuSheShiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"基础设施"
                                                         textColor:HYCOLOR.color_c4];
        _jiugonggeView = [[HYJiuGongGeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - MARGIN*4, 0)];
        _jiugonggeView.items_image_W = MARGIN*2;
        _jiugonggeView.titleTopConstrans = 7;
        [self addSubview:line];
        [self addSubview:_jiugonggeView];
        [self addSubview:titleLable];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_jiugonggeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        _titleLable = titleLable;
    }
    return self;
}

@end
