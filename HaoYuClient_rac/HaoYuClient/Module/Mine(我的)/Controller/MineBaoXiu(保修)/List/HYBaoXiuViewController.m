//
//  HYBaoXiuViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaoXiuViewController.h"
#import "HYBaoXiuTableViewCell.h"
#import "HYBaseBarButtonItem.h"
#import "HYAddBaoXiuViewController.h"
#import "HYBaoXiuModel.h"
#define  BAOXIUCELLIDENTIFITER @"BAOXIUCELLIDENTIFITER"

@interface HYBaoXiuViewController ()

@end

@implementation HYBaoXiuViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
- (void)requestListInfor
{
    [super requestListInfor];
    NSString *URL = GET_MINEWEIXIULISTINFOR_URL;
    if ([self.title isEqualToString:@"保洁"]) {
        URL = GET_MINEBAOJIELISTINFOR_URL;
    }
    PARA_CREART;
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"phone");
    [[HYServiceManager share] postRequestAnWithurl:URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n\n\n\n\nweiuxiu_list:%@",objc);
                                          NSArray *dataArr = objc[@"result"][@"list"];
                                          for (NSDictionary *dict in dataArr) {
                                              HYBaoXiuModel *model = [HYBaoXiuModel modelWithJSON:dict];
                                              model.modelType = ([self.title isEqualToString:@"保洁"]) ?@"1":@"2";
                                              [self.dataMutableArray addObject:model];
                                          }
                                          if (dataArr.count == 0) {
                                              [self showTableViewPlaceholder: Empty_Holder];
                                          }
                                          [self.MainTableView reloadData];
                                          [self.MainTableView.mj_header endRefreshing];
                                      } failureBlock:^(id error, id requestInfo) {
                                          [self.MainTableView.mj_header endRefreshing];
                                          [self showTableViewPlaceholder: RequestError_Holder];
                                      }];
}

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBaoXiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAOXIUCELLIDENTIFITER];
    if(!cell){
        cell = [[HYBaoXiuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BAOXIUCELLIDENTIFITER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataMutableArray.count > indexPath.row) {
        HYBaoXiuModel *model = self.dataMutableArray[indexPath.row];
        cell.BaoXiuModel = model;
    model.cellHeight =  [cell systemLayoutSizeFittingSize:cell.size withHorizontalFittingPriority:(UILayoutPriorityDefaultHigh) verticalFittingPriority:(UILayoutPriorityFittingSizeLevel)].height;
        LWLog(@"------------%f",model.cellHeight);
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataMutableArray.count > indexPath.row) {
        HYBaoXiuModel *model = self.dataMutableArray[indexPath.row];
        return (model.cellHeight == 0) ? UITableViewAutomaticDimension : model.cellHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self requestListInfor];
    
    ADD_NOTI(requestListInfor, @"REFRESHLISTWHENAFTERPINGJIA_NOTI");
}

+ (instancetype)creatWeiXiuViewController:(NSString *)titleStr
{
    HYBaoXiuViewController *instance    = [[HYBaoXiuViewController alloc] init];
    instance.title                      = titleStr;
    return instance;
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    self.MainTableView.estimatedRowHeight = ADJUST_PERCENT_FLOAT(108);
//    self.MainTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    WEAKSELF(self);
    HYBaseBarButtonItem*rightItem = [HYBaseBarButtonItem barButtonItemWithimageNamed:@"add_baoxiudan" callBack:^(id sender) {
        HYAddBaoXiuViewController *addVC = [HYAddBaoXiuViewController creatApplyWeiXiuViewController:self.title];
        [weakself.navigationController pushViewController:addVC animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other


@end
