//
//  HYBaoXiuCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaoXiuCellView.h"

@implementation HYBaoXiuCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.replyView =  [[LWTouSuJianYiReplyView alloc] init];
        [self.bgView addSubviews:@[self.houseNameLable,
                                   self.houseWhereLable,
                                   self.hetongDescLable,
                                   self.statuImageView,
                                   self.replyView]];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(MAGR);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MAGR);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.houseNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView.mas_left).mas_offset(MAGR);
            make.top.mas_equalTo(self.bgView.mas_top).mas_offset(MAGR);
            make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MAGR*6);
        }];
        [self.houseWhereLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseNameLable.mas_bottom).mas_offset(MAGR);
            make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-MAGR);
        }];
        [self.hetongDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseWhereLable.mas_bottom).mas_offset(MAGR);
        }];
        [self.statuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView.mas_right);
            make.top.mas_equalTo(self.bgView.mas_top);
            make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(50), ADJUST_PERCENT_FLOAT(50)));
        }];
      
    }
    return self;
}
- (void)hiddenReplyView:(BOOL)hidden
{
    self.replyView.hidden = hidden;
    if (hidden) {
        [self.replyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.hetongDescLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseWhereLable.mas_bottom).mas_offset(MAGR);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-MARGIN);
        }];
    }else{
        [self.hetongDescLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.houseNameLable.mas_left);
            make.top.mas_equalTo(self.houseWhereLable.mas_bottom).mas_offset(MAGR);
//            make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-MARGIN);
        }];
        [self.replyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.mas_equalTo(self.hetongDescLable.mas_bottom).mas_offset(MARGIN);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-MARGIN);
        }];
    }
}
@end
