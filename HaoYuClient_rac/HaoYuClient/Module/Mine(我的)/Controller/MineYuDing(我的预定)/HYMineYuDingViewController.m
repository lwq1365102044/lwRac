//
//  HYMineYuDingViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineYuDingViewController.h"
#import "HYYuDingListTableViewCell.h"
#import "HYStringTool.h"
#import "HYYuDingModel.h"
#import "HYPaymentViewController.h"
#import "HYQianYueViewController.h"

#define  MINEYUIDNGLISTCELLIDENTIFIER @"MINEYUIDNGLISTCELLIDENTIFIER"

@interface HYMineYuDingViewController ()

@end

@implementation HYMineYuDingViewController

#pragma mark - First.通知

#pragma mark - Second.赋值
/**
 取消
 */
- (void)cancleYuDingOrder:(NSString *)yuding_id
                zukePhone:(NSString *)zukePhone
               indentType:(NSString *)indentType
           balanceSheetId:(NSString *)balanceSheetId
{
    PARA_CREART;
    PARA_SET(yuding_id, @"id");//预定id
    PARA_SET([HYStringTool checkString:zukePhone], @"phone");//租客号码
    PARA_SET(@"", @"remark");//备注
    PARA_SET(@"0", @"shoudingStatus");//标识：APP端传0
    PARA_SET([HYStringTool checkString:balanceSheetId], @"balanceSheetId"); //收支id
    PARA_SET([HYStringTool checkString:indentType], @"indentType");//1:预收、2:实收
    PARA_SET(@"", @"money");//定金
    PARA_SET(@"", @"predictTime");//预计处理时间
    PARA_SET(@"", @"note");//收支备注
    [[HYServiceManager share] postRequestAnWithurl:CANCLE_YUDING_ORDER_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          [self requestListInfor];
                                          ALERT(@"取消成功！");
                                      } failureBlock:^(id error, id requestInfo) {
                                          ALERT(@"取消失败！");
                                      }];
}

- (void)requestListInfor
{
    [super requestListInfor];
    
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    [[HYServiceManager share] postRequestAnWithurl:GET_YUDINGLIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          [self.dataMutableArray removeAllObjects];
                                          
                                          LWLog(@"======\n\n\n预定列表：%@",objc);
                                          NSArray *renterInfoArr = objc[@"result"][@"list"];
                                          for (NSDictionary *dict in renterInfoArr) {
                                              HYYuDingModel *yudingmodel = [HYYuDingModel modelWithJSON:dict];
                                              [self.dataMutableArray addObject:yudingmodel];
                                          }
                                          if (renterInfoArr.count == 0) {
                                              [self showTableViewPlaceholder: Empty_Holder];
                                          }
                                          [self.MainTableView reloadData];
                                          [self.MainTableView.mj_header endRefreshing];
                                      } failureBlock:^(id error, id requestInfo) {
                                          [self.MainTableView.mj_header endRefreshing];
                                          [self showTableViewPlaceholder: RequestError_Holder];
                                      }];
}

#pragma mark - Third.点击事件
- (void)clickCellFuncBtnWithindexpath:(NSIndexPath *)indexpath funcStr:(NSString *)funcStr
{
    HYYuDingModel *yudingModel = self.dataMutableArray[indexpath.row];
    NSString *phonestr = yudingModel.houseJson[@"itemJson"][@"mendianPhone"];
    NSString *yuding_id = yudingModel.customId;
    if ([funcStr isEqualToString:@"去电"]) {
        if (phonestr) {
            [HYStringTool CallPhoneWith:self.view phone:phonestr];
        }
    }else if([funcStr isEqualToString:@"取消"]){
        [HYWraingAlert showAlert:self
                           title:@""
                         message:@"确定取消该预定？"
              defaultButtonTitle:@"确定"
               cancelButtonTitle:@"再想想"
      defaultButtonCallBackBlock:^(id sender) {
          [self cancleYuDingOrder:yuding_id zukePhone:yudingModel.zukePhone indentType:yudingModel.indentType balanceSheetId:yudingModel.balanceSheetId];
      } cancelButtonCallBackBlock:^(id sender) {
          
      }];
    }else if ([funcStr isEqualToString:@"支付"]){
        NSMutableArray *idsArr = [[NSMutableArray alloc] init];
        [idsArr addObject:yudingModel.customId];
        HYYuDingModel *yuding_M = self.dataMutableArray[indexpath.row];
        NSString *deptId = yuding_M.houseJson[@"itemJson"][@"deptId"];
        PARA_CREART;
        if(idsArr) PARA_SET(idsArr, @"ids");
        if(deptId) PARA_SET(deptId, @"deptId");
        [HYPaymentViewController pushPayViewController:self PayMentType:PAYMENTTYPE_DEPOSIT extend:para];
    }else if ([funcStr isEqualToString:@"签约"]){
        [HYQianYueViewController onLineQianYueViewControllerFrom:self Extend:yudingModel.houseJson[@"houseId"]];
    }
}

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYYuDingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINEYUIDNGLISTCELLIDENTIFIER];
    if(!cell){
        cell = [[HYYuDingListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MINEYUIDNGLISTCELLIDENTIFIER];
    }
    WEAKSELF(self);
    cell.clickFuncBlock = ^(NSIndexPath *indexpath, NSString *funcStr) {
        [weakself clickCellFuncBtnWithindexpath:indexPath funcStr:funcStr];
    };
    if (self.dataMutableArray.count > 0) {
        cell.dataModel = self.dataMutableArray[indexPath.row];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预定";
    [self setUI];
    [self requestListInfor];
}

#pragma mark - Sixth.界面配置

- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(235);
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
