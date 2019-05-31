//
//  HYHuXingListViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingListViewController.h"
#import "HYHuXingListTableViewCell.h"
#import "HYHuXingDeatilViewController.h"
#import "HYHuXingInforModel.h"
#import "HYHomePageModel.h"
#define  HUXINGLISTCELLIDNTIFIER @"HUXINGLISTCELLIDNTIFIER"
@interface HYHuXingListViewController ()
//项目id
@property (nonatomic, strong) NSString * houseItemId;
//首页的户型模型数据 HYHomeHuxingModel
@property (nonatomic, strong) NSArray * dataModel;

@end

@implementation HYHuXingListViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestListInfor
{
    [super requestListInfor];
    PARA_CREART;
    PARA_SET(_houseItemId, @"houseItemId");
    [[HYServiceManager share] postRequestAnWithurl:HUXING_LIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          NSArray *data_arr  = objc[@"result"][@"list"];
                                          for (NSDictionary *dict  in data_arr) {
                                              HYHuXingInforModel *model = [HYHuXingInforModel modelWithJSON:dict];
                                              [self.dataMutableArray addObject:model];
                                          }
                                          [self.MainTableView reloadData];
                                          [self.MainTableView.mj_header endRefreshing];
                                          if (data_arr.count == 0) {
                                              [self showTableViewPlaceholder:Empty_Holder];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                         [self.MainTableView.mj_header endRefreshing];
                                          [self showTableViewPlaceholder:RequestError_Holder];
                                      }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYHuXingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HUXINGLISTCELLIDNTIFIER];
    if(!cell){
        cell = [[HYHuXingListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HUXINGLISTCELLIDNTIFIER];
    }
    cell.indexPath = indexPath;
    cell.huxingModel = self.dataMutableArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMutableArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataMutableArray[indexPath.row];
    NSString *customId ;
    if ([model isKindOfClass:[HYHuXingInforModel class]]) {
        HYHuXingInforModel *tem_M = model;
        customId = tem_M.customId;
    }else if ([model isKindOfClass:[HYHomeHuXingModel class]]){
        HYHomeHuXingModel *tem_M = model;
        customId = tem_M.roomTypeId;
    }
    HYHuXingDeatilViewController *huxingDeatilVC = [[HYHuXingDeatilViewController alloc] init];
    huxingDeatilVC.HuXingId = customId;
    [self.navigationController pushViewController:huxingDeatilVC animated:YES];
}

#pragma mark - Fifth.视图生命周期
+ (instancetype)huXingListViewControllerWithhouseItemId:(NSString *)houseItemId
                                              dataModel:(NSArray *)dataModel
                                                 extend:(id)extend
{
    HYHuXingListViewController *instance = [[HYHuXingListViewController alloc] init];
    instance.houseItemId = houseItemId ? houseItemId : @"";
    instance.dataModel = dataModel;
    instance.title = extend[@"title"] ?:@"户型";
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    self.view.backgroundColor = HYCOLOR.color_c1;
    
    if (self.dataModel&&self.dataModel.count > 0) {
        [self.dataMutableArray addObjectsFromArray:self.dataModel];
        self.MainTableView.mj_header = nil;
        [self.MainTableView reloadData];
    }else{
        [self requestListInfor];
    }
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(130);
}

@end
