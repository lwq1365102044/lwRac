//
//  HYHouseRescourcesCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesCellView.h"

@implementation HYHouseRescourcesCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubUI];
    }
    return self;
}

- (void)setSubUI
{
    _houseImage         = [[UIImageView alloc] init];
    _priceLable         = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13)
                                           text:@""
                                      textColor:HYCOLOR.color_c0];
    _houseSorteLable    = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(14)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    _numberLable        = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                           text:@""
                                      textColor:HYCOLOR.color_c4];
    _addressLable       = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                           text:@""
                                      textColor:HYCOLOR.color_c2];
    _priceLable.backgroundColor      = HYCOLOR.color_c3;
    UIView *line                     = [[UIView alloc] init];
    line.backgroundColor             = HYCOLOR.color_c4;
    UIImageView *addreIcon           = [[UIImageView alloc] init];
    addreIcon.image                  = IMAGENAME(@"loactionSingleicon");
    _priceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:addreIcon];
//    [self addSubview:line];
    [self addSubview:_houseSorteLable];
    [self addSubview:_houseImage];
    [self addSubview:_priceLable];
//    [self addSubview:_numberLable];
    [self addSubview:_addressLable];
    self.addressLable.userInteractionEnabled = YES;
    
    [_houseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(150)));
        make.top.left.right.mas_equalTo(self);
    }];
    [_houseSorteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.top.mas_equalTo(_houseImage.mas_bottom).mas_offset(MARGIN);
    }];
    [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.size.mas_offset(CGSizeMake(MARGIN*11, ADJUST_PERCENT_FLOAT(MARGIN*2.5)));
        make.centerY.mas_equalTo(_houseSorteLable.mas_centerY);
    }];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_houseSorteLable.mas_right).mas_offset(MARGIN);
//        make.height.mas_equalTo(_houseSorteLable.mas_height);
//        make.width.mas_offset(0.5);
//        make.centerY.mas_equalTo(_houseSorteLable.mas_centerY);
//    }];
//    [_numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_houseSorteLable.mas_right).mas_offset(MARGIN*2);
//        make.centerY.mas_equalTo(_houseSorteLable.mas_centerY);
//    }];
    [addreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(15), ADJUST_PERCENT_FLOAT(15)));
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.top.mas_equalTo(_houseSorteLable.mas_bottom).mas_offset(MARGIN/2);
    }];
    [_addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addreIcon.mas_right).mas_offset(MARGIN/2);
        make.centerY.mas_equalTo(addreIcon.mas_centerY);
    }];
    
}

@end
