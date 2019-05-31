//
//  HYTitleAndImageItemVerView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTitleAndImageItemVerView.h"

@interface HYTitleAndImageItemVerView()
@property (nonatomic, assign) CGFloat IMAGE_W;
@property (nonatomic, copy) clickBlock  callblock;

@end

@implementation HYTitleAndImageItemVerView

- (void)setTitleTopConstrans:(CGFloat)titleTopConstrans
{
    [_tileLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 15));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_imageView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(titleTopConstrans));
    }];
}

- (CGFloat)IMAGE_W
{
    return ADJUST_PERCENT_FLOAT(30);
}

- (void)setImageW:(CGFloat)imageW
{
    _imageW = imageW;
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(_imageW, _imageW));
        make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        MARGIN = ADJUST_PERCENT_FLOAT(10);
        
        self.tileLable = [HYBaseLabel labelWithFont:SYSTEM_REGULARFONT(12)
                                               text:@"cess"
                                          textColor:HYCOLOR.color_c4];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.tileLable];
        [self addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(self.IMAGE_W, self.IMAGE_W));
            make.top.mas_equalTo(self.mas_top).mas_offset(MARGIN);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [_tileLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100, 15));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(_imageView.mas_bottom).mas_offset(MARGIN);
        }];
        _tileLable.textAlignment = NSTextAlignmentCenter;
        _tileLable.backgroundColor = [UIColor clearColor];
        
        [self bk_whenTapped:^{
            self.callblock(self.tileLable.text);
            if (self.callblock) {
            }
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)titleStr ImageName:(NSString *)imageName callBack:(clickBlock)callback
{
    _tileLable.text = titleStr;
    if([imageName hasPrefix:@"http"]){
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    }else{
        _imageView.image = IMAGENAME(imageName);
    }
    _callblock = callback;
}

@end
