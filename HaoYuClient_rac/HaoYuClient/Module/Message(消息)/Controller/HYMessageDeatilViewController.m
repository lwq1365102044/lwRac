//
//  HYMessageDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMessageDeatilViewController.h"
#import "HYMessageDeatilTableViewCell.h"
#import "HYMessageModel.h"
#import "LWFmdb.h"
#import "HYRequstGlobalDataTool.h"
#define  MESSAGEDEATILINDIFIER  @"MESSAGEDEATILINDIFIER"
// 每页数量
//#define  PAGESIZE   8
@interface HYMessageDeatilViewController ()
@property (nonatomic, assign) NSInteger msgType;
@property (nonatomic, strong) NSString * titleStr;
@end

@implementation HYMessageDeatilViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)showDBDatas
{
    NSArray *old_datas =  [[LWFmdb share] getDataWithObjcClassName:@"HYMessageModel" tableType:LWDBTableTypeMessge];
    [self.dataMutableArray addObjectsFromArray:old_datas];
//    self.totalPage = [[LWFmdb share] getDatasCountWithTableType:LWDBTableTypeMessge];
}

- (void)requestListInfor
{
    [super requestListInfor];
    
//    self.curretnPageNo = 0;
    HYRequstGlobalDataTool *reques =  [HYRequstGlobalDataTool new];
    reques.isFromMsgPage = YES;
    [reques requestMessageInforCallBackBlock:^(id sender) {
        [self handleDataWithDatas:sender isLoadMore:NO];
        [self.MainTableView reloadData];
    } failureBlock:^(id sender) {
        [self.MainTableView.mj_header endRefreshing];
        [self showTableViewPlaceholder:RequestError_Holder];
    }];
}

//- (void)requestListInfor_LoadMore
//{
//    if (self.curretnPageNo >=  ((self.totalPage%PAGESIZE)== 1 ? self.totalPage/PAGESIZE + 1 : self.totalPage/PAGESIZE )) {
//        [self.MainTableView.mj_footer endRefreshing];
//        [self.MainTableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
//    self.curretnPageNo ++;
//    NSArray *moreInfor = [[LWFmdb share] getDataWithObjcClassName:@"HYMessageModel" range:NSMakeRange(self.curretnPageNo * PAGESIZE, PAGESIZE) tableType:LWDBTableTypeMessge];
//    [self.dataMutableArray addObjectsFromArray:moreInfor];
//
//    [self.MainTableView.mj_footer endRefreshing];
//    [self.MainTableView reloadData];
//    if (self.dataMutableArray.count >= self.totalPage) {
//        [self.MainTableView.mj_footer endRefreshingWithNoMoreData];
//    }
//    self.totalPage = [[LWFmdb share] getDatasCountWithTableType:LWDBTableTypeMessge];
//}

/**
 处理数据
 */
- (void)handleDataWithDatas:(id)objc isLoadMore:(BOOL)isLoadMore
{
    [self showDBDatas];
    
//    NSArray *objc_arr = objc[@"result"][@"list"];
//    for (NSDictionary *dic in objc_arr) {
//        HYMessageModel *model = [HYMessageModel modelWithDictionary:dic];
//        [self.dataMutableArray addObject:model];
//    }
    
    // 如果数据大于pagesize 时，移出多余的数据 （请求到新的消息时）
//    if(self.dataMutableArray.count > PAGESIZE){
//        [self.dataMutableArray removeObjectsInRange:NSMakeRange(PAGESIZE, self.dataMutableArray.count - PAGESIZE)];
//    }
    
//    self.MainTableView.mj_footer.hidden = NO;
    if (self.dataMutableArray.count == 0) {
        [self showTableViewPlaceholder:Empty_Holder];
//        self.MainTableView.mj_footer.hidden = YES;
    }
    [self.MainTableView.mj_header endRefreshing];
//    [self.MainTableView.mj_footer resetNoMoreData];
    [self.MainTableView reloadData];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYMessageDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGEDEATILINDIFIER];
    if (!cell) {
        cell = [[HYMessageDeatilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MESSAGEDEATILINDIFIER];
        HYMessageModel *model = self.dataMutableArray[indexPath.section];
        cell.indexPath = indexPath;
        cell.msgModel = model;
        cell.clickBlock = ^(NSIndexPath *indexpath) {
            [self.MainTableView reloadData];
        };
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataMutableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ADJUST_PERCENT_FLOAT(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(40))];
    HYMessageModel *model = self.dataMutableArray[section];
    NSString *timestr = model.et;
    HYDefaultLabel *timerLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(12) text:timestr textColor:HYCOLOR.color_c4];
    timerLable.textAlignment = NSTextAlignmentCenter;
    sectionview.backgroundColor = HYCOLOR.color_c1;
    timerLable.backgroundColor = [UIColor clearColor];
    [sectionview addSubview:timerLable];
    [timerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(ADJUST_PERCENT_FLOAT(150));
        make.centerX.mas_equalTo(sectionview.mas_centerX);
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(20));
        make.centerY.mas_equalTo(sectionview.mas_centerY);
    }];
    return sectionview;
}

#pragma mark - Fifth.视图生命周期
/**
 msgType : 消息类型：1合同消息；2活动消息；3账单消息；4物业保修；
 */
+ (instancetype)creatMessageDeatilWithTitleStr:(NSString *)titleStr
                                       msgType:(NSInteger)msgType
                                        extend:(id)extend
{
    HYMessageDeatilViewController *instance = [[HYMessageDeatilViewController alloc] init];
    instance.title = titleStr;
    instance.msgType = msgType;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MainTableView.estimatedRowHeight = ADJUST_PERCENT_FLOAT(120);
    self.MainTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.MainTableView];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
//    self.MainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestListInfor_LoadMore)];
    [self requestListInfor];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
