//
//  HYBillListCellView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBillListCellView.h"
#import "HYBillListItemView.h"

@interface HYBillListCellView ()
@property (nonatomic, strong) UIView * itemsView;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation HYBillListCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c0;
        
        self.timeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"2018-05-25" textColor:HYCOLOR.color_c4];
        self.storeLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"好禹北京店" textColor:HYCOLOR.color_c4];
        self.leftSelectBtn = [[HYDefaultButton alloc] init];
        [self.leftSelectBtn addTarget:self action:@selector(clickSelctbtn) forControlEvents:UIControlEventTouchUpInside];
        [self.leftSelectBtn setBackgroundImage:IMAGENAME(@"mine_bill_select_n") forState:UIControlStateNormal];
        [self.leftSelectBtn setBackgroundImage:IMAGENAME(@"mine_bill_select_s") forState:UIControlStateSelected];
        self.leftSelectBtn.contentMode = UIViewContentModeScaleAspectFit;
        self.itemsView = [[UIView alloc] init];
        [self addSubview:self.timeLable];
        [self addSubview:self.storeLable];
        [self addSubview:self.itemsView];
        [self addSubview:self.leftSelectBtn];
        
    }
    return self;
}

+ (instancetype)creatBillListCellViewWithIsShowBtn:(BOOL)isShow
{
    HYBillListCellView *temp = [[HYBillListCellView alloc] init];
    temp.isShow = isShow;
    //    [temp setConfi];
    temp.leftSelectBtn.hidden =  !isShow;
    return temp;
}

- (void)setConfi
{
    
    [self.itemsView removeAllSubviews];
    for (int i = 0; i< _itemsDataArr.count; i++) {
        
        NSDictionary*dict = _itemsDataArr[i];
        HYBillListItemView *itemview = [HYBillListItemView creatItemView];
        [self.itemsView addSubview:itemview];
        itemview.timeLable.text = dict[@"time"];
        itemview.priceLable.text = dict[@"price"];
        itemview.titleLable.text = dict[@"title"];
        if (i == 0) {
            [itemview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.itemsView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(0));
                make.top.mas_equalTo(self.itemsView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
                make.right.mas_equalTo(self.itemsView.mas_right);
                if (_itemsDataArr.count == 1) {
                    make.bottom.mas_equalTo(self.itemsView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
                }
            }];
        }else{
            HYBillListItemView *lastitem = self.itemsView.subviews[self.itemsView.subviews.count - 2];
            [itemview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.itemsView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(0));
                make.top.mas_equalTo(lastitem.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
                make.right.mas_equalTo(self.itemsView.mas_right);
                if (i == _itemsDataArr.count - 1) {
                    make.bottom.mas_equalTo(self.itemsView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
                }
            }];
        }
    }
    
    CGFloat left_MRGIN =  _isShow ? 50 : 20;
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(left_MRGIN));
        make.top.mas_equalTo(self.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
    }];
    [self.storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(10));
        make.centerY.mas_equalTo(self.timeLable.mas_centerY);
    }];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLable.mas_left);
        make.top.mas_equalTo(self.timeLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(10));
        make.right.mas_equalTo(self.storeLable.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
    }];
    [self.leftSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ADJUST_PERCENT_FLOAT(20), ADJUST_PERCENT_FLOAT(20)));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(10));
    }];
    
    self.leftSelectBtn.hidden = !_isShow;
}

- (void)clickSelctbtn
{}

- (void)setItemsDataArr:(NSArray *)itemsDataArr
{
    _itemsDataArr = itemsDataArr;
    [self setConfi];
}


@end
