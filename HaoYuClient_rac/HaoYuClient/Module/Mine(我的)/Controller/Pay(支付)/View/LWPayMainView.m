//
//  LWPayMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/2/18.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWPayMainView.h"
#import "HYAttributedStringLabel.h"
#import "LWPayInforTableViewCell.h"
#import "HYDiscountModel.h"
#import "LWChoosePayMentView.h"

@interface LWPayMainView()<UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * bgScrollerView;

@property (nonatomic, strong) HYBaseView * titleView;

@property (nonatomic, strong) HYBaseView * showPriceView;
@property (nonatomic, strong) HYDefaultLabel *lineLable;
@property (nonatomic, strong) HYAttributedStringLabel * shouldPayPriceL;
@property (nonatomic, strong) HYBaseView * lineLableView;

@property (nonatomic, strong) HYBaseView * inforView;
@property (nonatomic, strong) HYBaseTableView * inforTableView;
@property (nonatomic, strong) NSMutableArray * inforDataMutableArray;

@property (nonatomic, strong) HYBaseView * inputJinETextFiledView;

@property (nonatomic, strong) HYBaseTableView * discountInforTableView;
@property (nonatomic, strong) NSMutableArray * discountInforMutableArray;

@property (nonatomic, strong) HYFillLongButton * commitBtn;

@property (nonatomic, assign) PayMentType payMentType;

@end

@implementation LWPayMainView


/**
 为优惠券列表赋值 并刷新界面

 @param discountDatas 数据源
 */
- (void)setDiscountDatas:(NSArray *)discountDatas
{
    _discountDatas = discountDatas;
    [self.discountInforMutableArray removeAllObjects];
    if (discountDatas) {
        [self.discountInforMutableArray addObjectsFromArray:discountDatas];
    }
    
    [self.discountInforTableView reloadData];
    [self.discountInforTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(self.discountInforTableView.contentSize.height);
    }];
    [self.discountInforTableView layoutIfNeeded];
}


/**
 为支付信息赋值 并刷新界面

 @param infor 数据源
 */
- (void)setInfor:(NSDictionary *)infor
{
    _infor = infor;
    
    NSString *total = infor[@"iosTotal"];
    NSString *pay = infor[@"iosPay"];
    
    [self setShouldPay:pay total:total];
    
    if (self.payMentType != PAYMENTTYPE_RECHARGE &&
        self.payMentType != PAYMENTTYPE_DEPOSIT) {
        
        if (infor[@"phone"]) {
            [self.inforDataMutableArray addObject:@{@"手机号码: ":infor[@"phone"]}];
        }
        if (infor[@"payType"]) {
            [self.inforDataMutableArray addObject:@{@"支付项目: ":infor[@"payType"]}];
        }
        if (infor[@"payMethod"]) {
            [self.inforDataMutableArray addObject:@{@"优惠: ":infor[@"payMethod"]}];
        }
        if (infor[@"houseAddress"]) {
            [self.inforDataMutableArray addObject:@{@"房源地址: ":infor[@"houseAddress"]}];
        }
    }

    [self.inforTableView reloadData];
    [self.inforTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(self.inforTableView.contentSize.height);
    }];
    [self.inforTableView layoutIfNeeded];
    
}

/**
 设置金额界面数据

 @param pay 应付金额
 @param total 总金额
 */
- (void)setShouldPay:(NSString *)pay total:(NSString *)total
{
    if ([total isEqualToString:pay]) {
        self.lineLableView.hidden = YES;
        [self.shouldPayPriceL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_showPriceView.mas_centerY);
        }];
        [self.lineLableView layoutIfNeeded];
    }else{
        self.lineLable.text = [NSString stringWithFormat:@"￥%@",total];
    }
    [_shouldPayPriceL setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
                                                              @"content" : @"￥",
                                                              @"size" : SYSTEM_REGULARFONT(17),
                                                              @"lineSpacing": @1},
                                                            @{@"color" : HYCOLOR.color_c4,
                                                              @"content" : pay ? pay:@"-.--",
                                                              @"size" : SYSTEM_REGULARFONT(26),
                                                              @"lineSpacing": @1},
                                                            ]];
}


/**
设置支付类型 分类型配置数据

 @param payMentType 支付类型
 */
- (void)setPayMentType:(PayMentType)payMentType
{
    _payMentType = payMentType;
    if (payMentType == PAYMENTTYPE_RECHARGE ||
        payMentType == PAYMENTTYPE_DEPOSIT) {
        
        NSString *userPhone = USERDEFAULTS_GET(USER_INFOR_PHONE);
        if (userPhone) {
            [self.inforDataMutableArray addObject:@{@"手机号码：":userPhone}];
        }
        [self.inforTableView reloadData];
        [self.inforTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(self.inforTableView.contentSize.height);
        }];
        [self.inforTableView layoutIfNeeded];
        
        if (payMentType == PAYMENTTYPE_DEPOSIT) {
            [self setShouldPay:@"1000" total:@"1000"];
        }
    }
}

/**
 点击下一步
 */
- (void)clickCommitBtn
{
    if (self.clickBtn) {
        self.clickBtn(@4);
    }
}

/**
 获取logo图片名
 */
- (NSString *)getLogoImageName
{
    if (_payMentType == PAYMENTTYPE_RECHARGE) {
        if (_rechargeTag == 1) {
            return @"jiaofei_dian_icon";
        }else if (_rechargeTag == 2){
            return @"jiaofei_shui_icon";
        }else if (_rechargeTag == 4){
            return @"jiaofei_shui_icon";
        }
    }
    return @"jiaofei_logo";
}

/**
 选择优惠券
 */
- (void)clickChooseDiscountBtn
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.clickBtn) {
        self.clickBtn(@3);
    }
}

/**
 获取该视图

 @param payMentType 支付类型（充值、定金、账单）
 @return 对应视图
 */
+ (instancetype)getPayMainView:(PayMentType)payMentType
{
    LWPayMainView *paymainView = [[LWPayMainView alloc] init];
    paymainView.width = SCREEN_WIDTH;
    [paymainView setMainUI:payMentType];
    [paymainView confi];
    paymainView.payMentType = payMentType;
    return paymainView;
}

- (void)confi
{
    /**
     充值水电表时 支付时 修改金额后，重新选择优惠券
     */
    ADD_NOTI(changeInputMoney:, CHANGE_INPUTMONEY_FOR_RECHARGE_DISCOUNT_KEY);

}

/**
 充值水电表时 支付时 修改金额后，重新选择优惠券
 */
- (void)changeInputMoney:(NSNotification *)noti
{
    self.discountDatas = nil;
}

- (void)setMainUI:(PayMentType)payMentType
{
    [self.bgScrollerView addSubviews:@[self.titleView,self.inforView,self.commitBtn]];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScrollerView.mas_top).offset(10);
        make.left.right.equalTo(self.bgScrollerView);
        make.height.equalTo(@ADJUST_PERCENT_FLOAT(50));
        make.width.offset(SCREEN_WIDTH);
    }];
    
    if (payMentType == PAYMENTTYPE_RECHARGE) {
        [self.bgScrollerView addSubview:self.inputJinETextFiledView];
        [self.inputJinETextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom).offset(15);
            make.left.right.equalTo(self.bgScrollerView);
        }];
    }else{
        [self.bgScrollerView addSubview:self.showPriceView];
        [self.showPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom).offset(15);
            make.left.right.equalTo(self.bgScrollerView);
        }];
    }
    [self.inforView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_showPriceView) make.top.equalTo(self.showPriceView.mas_bottom).offset(20);
        if (_inputJinETextFiledView) make.top.equalTo(self.inputJinETextFiledView.mas_bottom).offset(20);
        make.left.right.equalTo(self.bgScrollerView);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inforView.mas_bottom).offset(50);
        make.left.equalTo(self.bgScrollerView.mas_left).offset(30);
        make.right.equalTo(self.bgScrollerView.mas_right).offset(-30);
        make.height.offset(50);
        make.bottom.equalTo(self.bgScrollerView.mas_bottom).offset(-100);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _inforTableView) {
        return self.inforDataMutableArray.count;
    }else if (tableView == _discountInforTableView){
        return self.discountInforMutableArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _inforTableView) {
        LWPayInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_payinfor"];
        if (!cell) {
            cell = [[LWPayInforTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_payinfor"];
        }
        NSDictionary *dict = self.inforDataMutableArray[indexPath.row];
        cell.left_L.text = dict.allKeys.firstObject;
        cell.right_L.text = dict.allValues.firstObject;
        return cell;
    }else if(tableView == _discountInforTableView){
        
        LWPayInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_discount"];
        if (!cell) {
            cell = [[LWPayInforTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_discount"];
        }
        HYDiscountModel *model = self.discountInforMutableArray[indexPath.row];
        cell.left_L.text = model.couponTitle;
        cell.right_L.text = [NSString stringWithFormat:@"优惠%@元",model.iosDedicated];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        return cell;
    }
}

- (HYBaseView*)titleView
{
    if (!_titleView) {
        _titleView = [[HYBaseView alloc] init];
        HYDefaultLabel *titleL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(25) text:@"好寓" textColor:HYCOLOR.color_c4];
        [_titleView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titleView.mas_centerY);
            make.left.equalTo(@20);
        }];
    }
    return _titleView;
}

- (HYBaseView*)showPriceView
{
    if (!_showPriceView) {
        _showPriceView = [[HYBaseView alloc] init];
        
        _shouldPayPriceL = [HYAttributedStringLabel labelWithFont:SYSTEM_BOLDFONT(25) text:@"" textColor:HYCOLOR.color_c4];
        
        self.lineLableView =  [self getlineLableView];
        
        
        [_showPriceView addSubviews:@[_shouldPayPriceL,self.lineLableView]];
        
        [_shouldPayPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_showPriceView.mas_left).offset(20);
            make.top.equalTo(_showPriceView.mas_top).offset(15);
            make.height.offset(40);
            make.bottom.equalTo(_showPriceView.mas_bottom).offset(-15).priorityLow();
            make.centerY.equalTo(_showPriceView.mas_centerY).priorityLow();
        }];
        [self.lineLableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shouldPayPriceL.mas_left).offset(5);
            make.top.equalTo(_shouldPayPriceL.mas_bottom).offset(10);
            make.bottom.equalTo(_showPriceView.mas_bottom).offset(-10).priorityHigh();
        }];
    }
    return _showPriceView;
}

- (HYBaseView *)inforView
{
    if (!_inforView) {
        _inforView = [[HYBaseView alloc] init];
        
        HYDefaultLabel *infor_titleL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(13) text:@"付款信息：" textColor:HYCOLOR.color_c4];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        
        
        [_inforView addSubviews:@[infor_titleL,line,self.inforTableView]];

        [infor_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inforView.mas_left).offset(20);
            make.top.right.equalTo(_inforView);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inforView.mas_left).offset(20);
            make.right.equalTo(_inforView.mas_right).offset(-20);
            make.height.offset(1);
            make.top.equalTo(infor_titleL.mas_bottom).offset(9);
        }];
        [_inforTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inforView.mas_left).offset(30);
            make.right.equalTo(_inforView.mas_right).offset(-30);
            make.bottom.equalTo(_inforView.mas_bottom).offset(-10);
            make.height.offset(0.1);
            make.top.equalTo(line.mas_bottom).offset(15);
        }];
        
       _inforView.backgroundColor = _inforTableView.backgroundColor = infor_titleL.backgroundColor = [UIColor clearColor];
    }
    return _inforView;
}

/**
 充值水电费时 输入金额
 */
- (HYBaseView*)inputJinETextFiledView
{
    if (!_inputJinETextFiledView) {
        _inputJinETextFiledView = [[HYBaseView alloc] init];
        _inputJinETextFiledView.backgroundColor = [UIColor clearColor];
        
        HYDefaultLabel *leftL = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"￥" textColor:HYCOLOR.color_c4];
        _moneyTextFlied = [HYMoneyTextFiled creatMoneyTextFiledplaceHolder:@"请输入金额"
                                                                      font:SYSTEM_REGULARFONT(22)
                                                                 textColor:HYCOLOR.color_c26
                                                                  maxCount:0];
        _moneyTextFlied.textFiled.keyboardType =  UIKeyboardTypeDecimalPad;
        
        HYFillLongButton *chooseDiscountBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"使用优惠券" target:self selector:@selector(clickChooseDiscountBtn)];
        
        HYBaseView *inputView = [[HYBaseView alloc] init];
        [inputView addSubviews:@[leftL,_moneyTextFlied]];
        
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(inputView.mas_left).offset(20);
            make.centerY.equalTo(inputView.mas_centerY).offset(1);
        }];
        [_moneyTextFlied mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(inputView.mas_centerY);
            make.left.equalTo(leftL.mas_right).offset(5);
            make.height.mas_offset(40);
            make.right.equalTo(inputView.mas_right).offset(-20);
            make.top.equalTo(inputView.mas_top).offset(10);
            make.bottom.equalTo(inputView.mas_bottom).offset(-10);
        }];
        [leftL setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
//        [_moneyTextFlied setContentHuggingPriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisHorizontal)];
        [_inputJinETextFiledView addSubviews:@[inputView,chooseDiscountBtn,self.discountInforTableView]];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_inputJinETextFiledView);
        }];
        [chooseDiscountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(85, 30));
            make.right.equalTo(_moneyTextFlied.mas_right);
            make.top.mas_equalTo(inputView.mas_bottom).offset(15);
        }];
        [self.discountInforTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inputJinETextFiledView.mas_left).offset(20);
            make.right.equalTo(_inputJinETextFiledView.mas_right).offset(-20);
            make.bottom.equalTo(_inputJinETextFiledView.mas_bottom).offset(-5);
            make.height.offset(0.1).priorityLow();
            make.top.equalTo(chooseDiscountBtn.mas_bottom).offset(10);
        }];
        
    }
    return _inputJinETextFiledView;
}

/**
 支付信息tableview
 */
- (HYBaseTableView*)inforTableView
{
    if (!_inforTableView) {
        _inforTableView = [[HYBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _inforTableView.estimatedRowHeight = ADJUST_PERCENT_FLOAT(30);
        _inforTableView.rowHeight = UITableViewAutomaticDimension;
        _inforTableView.dataSource = self;
        _inforTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _inforTableView.scrollEnabled = NO;
    }
    return _inforTableView;
}

/**
 优惠券tableview
 */
- (HYBaseTableView*)discountInforTableView
{
    if (!_discountInforTableView) {
        _discountInforTableView = [[HYBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _discountInforTableView.rowHeight = ADJUST_PERCENT_FLOAT(30);
        _discountInforTableView.dataSource = self;
        _discountInforTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discountInforTableView.scrollEnabled = NO;
        _discountInforTableView.backgroundColor = [UIColor clearColor];
    }
    return _discountInforTableView;
}


- (HYBaseView *)getlineLableView
{
    HYBaseView *tem = [HYBaseView new];
    _lineLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15) text:@"测试原价：0.000" textColor:[UIColor grayColor]];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    
    [tem addSubviews:@[_lineLable,line]];
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tem);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tem.mas_centerY);
        make.left.equalTo(_lineLable.mas_left).offset(-3);
        make.right.equalTo(_lineLable.mas_right).offset(3);
        make.height.equalTo(@1);
    }];
    return tem;
}

- (HYFillLongButton*)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"下一步" target:self selector:@selector(clickCommitBtn)];
    }
    return _commitBtn;
}


- (UIScrollView*)bgScrollerView
{
    if (!_bgScrollerView) {
        _bgScrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _bgScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
        _bgScrollerView.backgroundColor = HYCOLOR.color_c1;
        [self addSubview:_bgScrollerView];
        [_bgScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.width.mas_offset(SCREEN_WIDTH);
        }];
    }
    return _bgScrollerView;
}

- (NSMutableArray*)inforDataMutableArray
{
    if (!_inforDataMutableArray) {
        _inforDataMutableArray = [[NSMutableArray alloc] init];
    }
    return _inforDataMutableArray;
}

- (NSMutableArray*)discountInforMutableArray
{
    if (!_discountInforMutableArray) {
        _discountInforMutableArray = [[NSMutableArray alloc] init];
    }
    return _discountInforMutableArray;
}
@end
