//
//  HYMineYuYueViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineYuYueViewController.h"
#import "HYYuYueListTableViewCell.h"
#import "HYStringTool.h"
#define  MINEYUYUELISTCELLIDENTIFIER @"MINEYUYUELISTCELLIDENTIFIER"

@interface HYMineYuYueViewController ()

@end

@implementation HYMineYuYueViewController

#pragma mark - First.通知

#pragma mark - Second.赋值
/**
 取消
 */
- (void)cancleYuYueOrder:(NSString *)yuYue_ID
{
    PARA_CREART;
    PARA_SET(yuYue_ID, @"id");//预约id
    PARA_SET([HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)], @"phone");
    [[HYServiceManager share] postRequestAnWithurl:CANCLE_YUYUE_ORDER_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          if ([objc[@"status"][@"code"] isEqualToString:@"200"]) {
                                              ALERT(@"取消成功！");
                                              [self requestListInfor];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          ALERT(@"取消失败！");
                                      }];
}

- (void)requestListInfor
{
    [self.dataMutableArray removeAllObjects];
    PARA_CREART;
    PARA_SET([HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)], @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GET_YUYUELIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"======\n\n\n预约列表：%@",objc);
                                          NSArray *renterInfoArr = objc[@"result"][@"renterInfoArr"];
                                          if (renterInfoArr) {
                                              [self.dataMutableArray addObjectsFromArray:renterInfoArr];
                                              [self.MainTableView reloadData];
                                          }
                                          if (renterInfoArr.count == 0) {
                                              [self showTableViewPlaceholder: Empty_Holder];
                                          }
                                          [self.MainTableView.mj_header endRefreshing];
                                      } failureBlock:^(id error, id requestInfo) {
                                          [self.MainTableView.mj_header endRefreshing];
                                          [self showTableViewPlaceholder: RequestError_Holder];
                                      }];
}

#pragma mark - Third.点击事件
- (void)clickCellFuncBtnWithindexpath:(NSIndexPath *)indexpath funcStr:(NSString *)funcStr
{
    NSDictionary *dict = self.dataMutableArray[indexpath.row];
    NSString *mendian_phone = dict[@"roomTypeJson"][@"itemJson"][@"mendianPhone"];
    NSString *yuyue_id = dict[@"id"];
    if ([funcStr isEqualToString:@"去电"]) {
        [HYStringTool CallPhoneWith:self.view phone:mendian_phone];
    }else{
        [HYWraingAlert showAlert:self
                           title:@""
                         message:@"确定取消该预约？"
              defaultButtonTitle:@"确认"
               cancelButtonTitle:@"再想想"
      defaultButtonCallBackBlock:^(id sender) {
        [self cancleYuYueOrder:yuyue_id];
      } cancelButtonCallBackBlock:^(id sender) {
          
      }];
        
    }
}

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYYuYueListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINEYUYUELISTCELLIDENTIFIER];
    if(!cell){
        cell = [[HYYuYueListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MINEYUYUELISTCELLIDENTIFIER];
    }
    WEAKSELF(self);
    cell.clickFuncBlock = ^(NSIndexPath *indexpath, NSString *funcStr) {
        [weakself clickCellFuncBtnWithindexpath:indexPath funcStr:funcStr];
    };
    cell.dataDict = self.dataMutableArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    [self setUI];
    [self requestListInfor];
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(213);
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other


@end
