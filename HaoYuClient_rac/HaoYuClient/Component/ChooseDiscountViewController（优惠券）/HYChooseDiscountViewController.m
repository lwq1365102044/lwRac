//
//  HYChooseDiscountViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/9/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYChooseDiscountViewController.h"
#import "HYChooseDiscountTableViewCell.h"
#import "HYDiscountModel.h"
#import "HYBaseBarButtonItem.h"
#define CHOOSEDISCOUNT_CELLID @"CHOOSEDISCOUNT_CELLID"

@interface HYChooseDiscountViewController ()
@property (nonatomic, strong) NSMutableArray * selectMutableArray;
@property (nonatomic, strong) HYDefaultButton * sureBtn;

@end

@implementation HYChooseDiscountViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYChooseDiscountTableViewCell *cell = [[HYChooseDiscountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CHOOSEDISCOUNT_CELLID];
    cell.indexPath = indexPath;
    HYDiscountModel *discM = self.dataMutableArray[indexPath.row];
    cell.discountModel = discM;
    if (discM.isSelect) {
       if(![self.selectMutableArray containsObject:discM]) [self.selectMutableArray addObject:discM];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDiscountModel *model = self.dataMutableArray[indexPath.row];
    HYChooseDiscountTableViewCell *cell = [self.MainTableView cellForRowAtIndexPath:indexPath];
    cell.isSelect = !cell.isSelect;
    model.isSelect = cell.isSelect;
    if (cell.isSelect) {
        if(![self.selectMutableArray containsObject:model])[self.selectMutableArray addObject:model];
    }else{
        if ([self.selectMutableArray containsObject:model]) {
            [self.selectMutableArray removeObject:model];
        }
    }
}

- (void)clickSureBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(alearySelectDicount:indexPath:)]) {
        [self.delegate alearySelectDicount:self.selectMutableArray indexPath:_indexpath];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Fifth.视图生命周期

+ (instancetype)creatChooseDiscountVCWithDatas:(NSArray *)datas sourceVC:(HYBaseViewController *)sourceVC extend:(id)extend
{
    HYChooseDiscountViewController *instance = [[HYChooseDiscountViewController alloc] init];
    [instance.dataMutableArray addObjectsFromArray:datas];
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择优惠券";
    [self setUI];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    self.MainTableView.mj_header = nil;
    [self.MainTableView registerClass:[HYChooseDiscountTableViewCell class] forCellReuseIdentifier:CHOOSEDISCOUNT_CELLID];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(130);
    [self.view addSubview:self.MainTableView];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH *0.7, MARGIN*3));
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(MARGIN));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.sureBtn.mas_top).mas_offset(-MARGIN);
    }];
    
    self.navigationItem.leftBarButtonItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        for (HYDiscountModel *dis_M in self.selectMutableArray) {
            dis_M.isSelect = NO;
        }
        [self.selectMutableArray removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark - Seventh.懒加载

- (NSMutableArray*)selectMutableArray
{
    if (!_selectMutableArray) {
        _selectMutableArray = [[NSMutableArray alloc] init];
    }
    return _selectMutableArray;
}
- (HYDefaultButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [HYDefaultButton buttonWithTitleStringKey:@"确定"
                                                  titleColor:HYCOLOR.color_c4
                                                   titleFont:SYSTEM_REGULARFONT(15)
                                                      target:self
                                                    selector:@selector(clickSureBtn:)];
        [_sureBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
    }
    return _sureBtn;
}
#pragma mark - Eigth.Other

@end
