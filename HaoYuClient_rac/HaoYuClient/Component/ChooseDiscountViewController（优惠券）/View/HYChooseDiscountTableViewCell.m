//
//  HYChooseDiscountTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseDiscountTableViewCell.h"
#import "HYAttributedStringLabel.h"
#import "HYBaseCornerView.h"
@interface HYChooseDiscountTableViewCell ()
@property (nonatomic, strong) HYBaseCornerView * bgView;
@property (nonatomic, strong) HYAttributedStringLabel * priceLable;
@property (nonatomic, strong) HYDefaultLabel * titleLable;
@property (nonatomic, strong) HYDefaultLabel * manPriceCanUseLable;
@property (nonatomic, strong) HYDefaultLabel * CanUseMenDianLable;
@property (nonatomic, strong) HYDefaultLabel * useTypeLable;
@property (nonatomic, strong) UIImageView * statusImageView;
@property (nonatomic, strong) HYDefaultLabel * youxiaoqiLable;
@property (nonatomic, strong) HYBaseView * line;

@end

@implementation HYChooseDiscountTableViewCell

- (void)setDiscountModel:(HYDiscountModel *)discountModel
{
    _discountModel = discountModel;
    [_priceLable setAttributedStringWithContentArray:@[@{@"color":HYCOLOR.color_c0,
                                                         @"content":@"￥",
                                                         @"size":SYSTEM_MEDIUMFONT(16),
                                                         @"lineSpacing":@1},
                                                       @{@"color":HYCOLOR.color_c0,
                                                         @"content":discountModel.iosDedicated ? discountModel.iosDedicated:@"",
                                                         @"size":SYSTEM_MEDIUMFONT(36),
                                                         @"lineSpacing":@1}]];
    _titleLable.text = discountModel.couponTitle;
    _CanUseMenDianLable.text = [NSString stringWithFormat:@"%@",discountModel.couponItemName];
    _manPriceCanUseLable.text = [NSString stringWithFormat:@"满%@元可用",discountModel.iosDedicatedMin];
    if(discountModel.couponType)_useTypeLable.text = discountModel.couponType;
    _youxiaoqiLable.text = [NSString stringWithFormat:@"%@ ~ %@",discountModel.ov[@"begintime"],discountModel.ov[@"endtime"]];
    self.isSelect = discountModel.isSelect;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    [self changeColorWithisSelct:isSelect];
    if (self.clickBlock) {
        self.clickBlock(self.indexPath);
    }
}

/**
 选中时 颜色
 */
- (void)changeColorWithisSelct:(BOOL)isSelct
{
    if (isSelct) {
        _priceLable.textColor = _titleLable.textColor = _manPriceCanUseLable.textColor = _useTypeLable.textColor = _youxiaoqiLable.textColor =_line.backgroundColor = HYCOLOR.color_c34;
        _bgView.backgroundColor = HYCOLOR.color_c35;
        _statusImageView.image = IMAGENAME(@"discountSel");
    }else{
        _priceLable.textColor = _titleLable.textColor = _manPriceCanUseLable.textColor = _useTypeLable.textColor = _youxiaoqiLable.textColor =_line.backgroundColor = HYCOLOR.color_c0;
        _bgView.backgroundColor = HYCOLOR.color_c32;
        _statusImageView.image = IMAGENAME(@"discountNoSel");
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = HYCOLOR.color_c1;
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(MARGIN/2);
            make.right.bottom.mas_equalTo(self.contentView).mas_offset(-MARGIN/2);
        }];
    }
    return self;
}

- (HYBaseCornerView*)bgView
{
    if (!_bgView) {
        _bgView = [[HYBaseCornerView alloc] init];
        _bgView.backgroundColor = HYCOLOR.color_c32;
        
        _priceLable = [HYAttributedStringLabel labelWithFont:SYSTEM_REGULARFONT(14) text:@"" textColor:HYCOLOR.color_c0];
        _titleLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(20) text:@"" textColor:HYCOLOR.color_c0];
        _CanUseMenDianLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c0];
        _manPriceCanUseLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c0];
        _useTypeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c0];
        _youxiaoqiLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:@"" textColor:HYCOLOR.color_c0];
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.image = IMAGENAME(@"discountNoSel");
        [_statusImageView setBoundWidth:0 cornerRadius:MARGIN*5];
        _CanUseMenDianLable.numberOfLines = 2;
        _priceLable.backgroundColor = [UIColor clearColor];
        _titleLable.backgroundColor = [UIColor clearColor];
        _manPriceCanUseLable.backgroundColor = [UIColor clearColor];
        _useTypeLable.backgroundColor = [UIColor clearColor];
        _youxiaoqiLable.backgroundColor = [UIColor clearColor];
        _CanUseMenDianLable.backgroundColor = [UIColor clearColor];
        HYBaseView *lin = [[HYBaseView alloc] init];
        lin.backgroundColor = HYCOLOR.color_c0;
        _line = lin;
        [_bgView addSubviews:@[_priceLable,_titleLable,_CanUseMenDianLable,_manPriceCanUseLable,_useTypeLable,_youxiaoqiLable,lin,_statusImageView]];
     
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_bgView).mas_offset(MARGIN);
        }];
        [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(MARGIN*10, MARGIN*10));
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
            make.centerY.mas_equalTo(_bgView.mas_centerY);
        }];
        [_manPriceCanUseLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(_priceLable.mas_centerX);
            make.left.mas_equalTo(_priceLable.mas_left);
            make.top.mas_equalTo(_priceLable.mas_bottom).mas_offset(MARGIN*1.5);
        }];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_priceLable.mas_top);
            make.left.mas_equalTo(_priceLable.mas_right).mas_offset(MARGIN);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-MARGIN);
        }];
        [_CanUseMenDianLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLable.mas_bottom).mas_offset(MARGIN/2);
            make.left.right.mas_equalTo(_titleLable);
        }];
        [_useTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLable.mas_left);
            make.centerY.mas_equalTo(_manPriceCanUseLable.mas_centerY);
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(1);
            make.left.right.mas_equalTo(_bgView);
            make.top.mas_equalTo(_manPriceCanUseLable.mas_bottom).mas_offset(MARGIN);
        }];
        [_youxiaoqiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_line.mas_bottom).mas_offset(MARGIN/2);
            make.left.mas_equalTo(_priceLable.mas_left);
        }];
        [_priceLable setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisHorizontal];
        [_titleLable setContentHuggingPriority:UILayoutPriorityDefaultLow
                                       forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _bgView;
}

@end
