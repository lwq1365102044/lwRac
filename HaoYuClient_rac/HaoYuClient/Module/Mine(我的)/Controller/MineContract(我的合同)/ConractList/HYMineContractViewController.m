//
//  HYMineContractViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineContractViewController.h"
#import "HYContractListTableViewCell.h"
#import "HYContactDeatilViewController.h"
#import "HYContractModel.h"

#define  CONTRACTLISTCELLIDENTIFIER  @"CONTRACTLISTCELLIDENTIFIER"

@interface HYMineContractViewController ()

@end

@implementation HYMineContractViewController


#pragma mark - First.通知

#pragma mark - Second.赋值
/**
 点击账单时，获取合同数量
 */
- (void)requestListInfor
{
    [super requestListInfor];
    
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEHETONGLISTINFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"\n\n\n\n\nhetong_list:%@",objc);
                                        NSArray *dataArr = objc[@"result"][@"list"];
                                        for (NSDictionary *dict in dataArr) {
                                            HYContractModel *model = [HYContractModel modelWithJSON:dict];
                                            if([model.status integerValue] != 5){
                                                [self.dataMutableArray addObject:model];
                                            }
                                        }
                                        [self.MainTableView reloadData];
                                        [self.MainTableView.mj_header endRefreshing];
                                        if(self.dataMutableArray.count == 0){
                                            [self showTableViewPlaceholder:Empty_Holder];
                                        }
                                    } failureBlock:^(id error, id requestInfo) {
                                        [self.MainTableView.mj_header endRefreshing];
                                        [self showTableViewPlaceholder:RequestError_Holder];
                                    }];
}

#pragma mark - Third.点击事件
- (void)refreshData
{
    [self requestListInfor];
}

#pragma mark - Fourth.代理方法

#pragma mark -- UITableViewSourceDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYContractListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CONTRACTLISTCELLIDENTIFIER];
    if (!cell) {
        cell = [[HYContractListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CONTRACTLISTCELLIDENTIFIER];
    }
    cell.contractModel = self.dataMutableArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYContactDeatilViewController * contractDeatilVC = [[HYContactDeatilViewController alloc] init];
    HYContractModel *model = self.dataMutableArray[indexPath.row];
    contractDeatilVC.contractInforModel  = model;
    [self.navigationController pushViewController:contractDeatilVC animated:YES];
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的合同";
    self.MainTableView.rowHeight = 185;
    [self.view addSubview:self.MainTableView];
    [self requestListInfor];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other


@end
