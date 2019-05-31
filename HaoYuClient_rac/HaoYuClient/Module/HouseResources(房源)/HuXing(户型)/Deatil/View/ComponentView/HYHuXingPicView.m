//
//  HYHuXingPicView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingPicView.h"

@implementation HYHuXingPicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"户型图"
                                                         textColor:HYCOLOR.color_c4];
        _shitingLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                                 text:@""
                                            textColor:HYCOLOR.color_c0];
        _shitingLable.backgroundColor = HYCOLOR.color_c3;
        _shitingLable.textAlignment = NSTextAlignmentCenter;
        _fangxiangLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                                 text:@""
                                            textColor:HYCOLOR.color_c4];
        
        _pic = [[UIImageView alloc] init];
        [self addSubview:line];
        [self addSubview:titleLable];
        [self addSubview:_pic];
        [self addSubview:_shitingLable];
        [self addSubview:_fangxiangLable];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.size.mas_offset(CGSizeMake(MARGIN*10, MARGIN*10));
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*3);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        [_shitingLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2.5);
            make.left.mas_equalTo(titleLable.mas_left);
            make.height.mas_offset(MARGIN*2.5);
        }];
        [_fangxiangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_shitingLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(titleLable.mas_left);
        }];
        [_shitingLable setBoundWidth:0 cornerRadius:4];
        
    }
    return self;
}
@end
