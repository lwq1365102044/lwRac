//
//  HYChooseBaseView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/19.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseBaseView.h"

@implementation HYChooseBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
        _maskView = [[HYBaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = .3;
        _window = [UIApplication sharedApplication].keyWindow;
        
        [_window addSubview:_maskView];
        [self.window addSubview:self.bgView];
        self.bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH*.7, SCREEN_HEIGHT*0.4);
        self.bgView.center = self.window.center;
        [self.maskView bk_whenTapped:^{
            [self dismiss];
            if (self.clickDismissBlock) {
                self.clickDismissBlock(nil);
            }
        }];
    }
    return self;
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [_bgView removeAllSubviews];
        [_bgView removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}
- (HYBaseView*)bgView
{
    if (!_bgView) {
        _bgView = [[HYBaseView alloc] init];
        [_bgView setBoundWidth:0 cornerRadius:6];
    }
    return _bgView;
}
@end
