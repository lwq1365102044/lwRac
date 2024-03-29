//
//  HYHistoryBillViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/26.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHistoryBillViewController.h"
#import "HYNoPayBillTableViewCell.h"
#import "HYBillModel.h"
#define HISTORYCELLIDENTIFIER  @"HISTORYCELLIDENTIFIER"

@interface HYHistoryBillViewController ()

@end

@implementation HYHistoryBillViewController

#pragma mark - First.通知

- (void)paySucessRefreshBill:(NSNotification *)noti
{
    [self requestListInfor];
}
#pragma mark - Second.网络请求
- (void)requestListInfor
{
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    PARA_SET(_contractModel.chengzuId, @"indentChengzuId");
    PARA_SET(@"2", @"indentType");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEBILLLISTINFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          [self handleData:objc];
                                          [self.MainTableView.mj_header endRefreshing];
                                      } failureBlock:^(id error, id requestInfo) {
                                          [self.MainTableView.mj_header endRefreshing];
                                          [self showTableViewPlaceholder: RequestError_Holder];
                                      }];
}

/**
 处理数据
 */
- (void)handleData:(id)objc
{
    [self.dataMutableArray removeAllObjects];
    NSArray *temp = objc[@"result"][@"list"];
    if (temp.count == 0) {
        [self showTableViewPlaceholder: Empty_Holder];
    }
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in temp) {
        NSMutableArray *items = [NSMutableArray array];
        HYBillModel *billModel = [HYBillModel modelWithJSON:dict];
        NSMutableArray *lastItems;
        lastItems = dataDict[billModel.beginTime];
        if (lastItems.count > 0 && lastItems != nil) {
            items = lastItems;
            [items addObject:billModel];
        }else{
            [items addObject:billModel];
        }
        [dataDict setValue:items forKey:billModel.beginTime];
    }
    NSArray *allVaules = dataDict.allValues;
    [self.dataMutableArray addObjectsFromArray:allVaules];
    [self paiXun];
    [self.MainTableView reloadData];
}

- (void)paiXun
{
    for (int i = 0 ; i<self.dataMutableArray.count; i++) {
        for (int j = 0  ; j < self.dataMutableArray.count - 1 - i; j++) {
            NSArray *ar0 = self.dataMutableArray[j];
            NSArray *ar1 = self.dataMutableArray[j+1];
            HYBillModel *model0 = ar0.firstObject;
            HYBillModel *model1 = ar1.firstObject;
            if ([model0.beginTime compare:model1.beginTime options:NSCaseInsensitiveSearch] == NSOrderedDescending) {
                NSArray *temp = self.dataMutableArray[j];
                self.dataMutableArray[j] = self.dataMutableArray[j+1];
                self.dataMutableArray[j+1] = temp;
            }
        }
    }
}
#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYNoPayBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HISTORYCELLIDENTIFIER];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataArr:self.dataMutableArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self requestListInfor];

#ifdef __IPHONE_11_0
    if ([self.MainTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.MainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    
    /**
     支付成功后，刷新账单
     */
    ADD_NOTI(paySucessRefreshBill:, PAYMENT_AFTER_REFRESH_BILLLIST_KEY);
}

- (void)setUI
{
    [self.MainTableView registerClass:[HYNoPayBillTableViewCell class] forCellReuseIdentifier:HISTORYCELLIDENTIFIER];
    self.MainTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - ADJUST_PERCENT_FLOAT(45)-NAVIGATOR_HEIGHT);
    self.MainTableView.rowHeight = UITableViewAutomaticDimension;
    self.MainTableView.estimatedRowHeight = ADJUST_PERCENT_FLOAT(150);
    self.MainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MainTableView.backgroundColor = HYCOLOR.color_c1;
    [self.view addSubview:self.MainTableView];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
