//
//  HYHomeViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomeViewController.h"
#import "HYHomeTableViewCell.h"
#import "HYHomeTableHeaderView.h"
#import "HYBaseBarButtonItem.h"
#import "HYMessageViewController.h"
#import "HYCityListViewController.h"
#import "HYHuXingListViewController.h"
#import "HYHouseRescourcesViewController.h"
#import "HYHouseRescourceDeatilViewController.h"
#import "HYHuXingDeatilViewController.h"
#import "HYOnLineYuYueViewController.h"
#import "HYOnLineYuDingViewController.h"
#import "HYQianYueViewController.h"
#import "HYRequstGlobalDataTool.h"
#import "HYLocationTool.h"
#import "HYMapFindHouseViewController.h"
#import "HYHomePageModel.h"
#import "HYHouseProjectInforTool.h"
#import "HYMapView.h"
#import "HYAlertCentersView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "HYAlertCenterView.h"
#import "HYKeplerManager.h"
#import <JDKeplerSDK/JDKeplerSDK.h>
#import "HYBannerHandlerManager.h"
#import "LWHomePageModelHandler.h"
#import "LWHomeHotTableViewCell.h"
#import "HYBannerActivityViewController.h"
#import "LWHomeHotInforListViewController.h"

static NSString * const HYHOMETABLECELLINDENTIFIER =  @"HYHOMETABLECELLINDENTIFIER";

@interface HYHomeViewController ()<BMKLocationServiceDelegate,SDCycleScrollViewDelegate,LWHomePageCellEventsDelegate>
@property (nonatomic, strong) HYHomeTableHeaderView * headerView;
@property (nonatomic, strong) HYDefaultButton *cityBtn;
@property (nonatomic, strong) HYLocationTool * locationTool;
//用户定位的城市
@property (nonatomic, strong) NSString * user_location_city;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong) BMKMapManager * mapManager;

@property (nonatomic, strong) NSArray * BnDataArray;//banner
@property (nonatomic, strong) HYMapView * myMapView;
@property (nonatomic, assign) BOOL isCanSideBack;
@property (nonatomic, strong) LWHomePageModelHandler * modelHandler;

@end

@implementation HYHomeViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

- (void)requestListInfor
{
    [self requestBannerInfor];
    
    [self.modelHandler requestHomePageAllListInforCallBackBlock:^(id sender) {
        NSArray *dataArr = (NSArray *)sender;
        [self.dataMutableArray removeAllObjects];
        [self.dataMutableArray addObjectsFromArray:dataArr];
        [self.MainTableView reloadData];
        [self.MainTableView.mj_header endRefreshing];
    } failureBlock:^(id sender) {
        [self.MainTableView.mj_header endRefreshing];
    }];
}

/**
banner infor
 */
- (void)requestBannerInfor
{
    [self.modelHandler requestHomePageBannerWithCallBackBlock:^(id sender) {
        self.BnDataArray = sender ? sender : @[];
        self.headerView.bannderModelArray = self.BnDataArray;
    } failureBlock:nil];
}
#pragma mark - Third.点击事件

- (void)clickHeaderViewFuncBtnWithKey:(NSString *)key
{
    if ([key isEqualToString:@"地图找房"]) {
        HYMapFindHouseViewController *mapFindHouseVC = [[HYMapFindHouseViewController alloc] init];
        mapFindHouseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mapFindHouseVC animated:YES];
    }else if ([key isEqualToString:@"预约看房"]){
        [HYOnLineYuYueViewController onlineYuYueViewControllerFrom:self extend:nil];
    }else if ([key isEqualToString:@"预定房源"]){
        [HYOnLineYuDingViewController onLineYuDingViewControllerFrom:self Extend:nil];
    }else if ([key isEqualToString:@"在线签约"]){
        [HYQianYueViewController onLineQianYueViewControllerFrom:self Extend:nil];
    }else if ([key isEqualToString:@"搜索"]){
        
    }else if ([key isEqualToString:@"京东百货"]){
        [HYKeplerManager openKeplerPageWithURL:KEPLER_JD_URL sourceController:self
                                      jumpType:2 customParams:nil];
    }
}

#pragma mark - Fourth.代理方法
- (void)cellEventsWithcellTag:(NSInteger)tag indexPath:(NSIndexPath *)indexPath dataModelArray:(NSArray *)dataModelArray Title:(NSString *)title
{
    if ([dataModelArray.firstObject isKindOfClass:[HYHomePageModel class]]) {
        if (tag == 10000) {
            HYHouseRescourcesViewController *houseRescources = [HYHouseRescourcesViewController houseRescourcesViewControllerWithDataModel:dataModelArray extend:@{@"title":title}];
            houseRescources.title = title;
            houseRescources.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:houseRescources animated:YES];
        }else if (tag == 20000){
            HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
            deatilVC.hidesBottomBarWhenPushed = YES;
            HYHomePageModel *projectModel = dataModelArray[indexPath.row];
            deatilVC.houseItemId = projectModel.itemId;
            [self.navigationController pushViewController:deatilVC animated:YES];
        }
    }else if ([dataModelArray.firstObject isKindOfClass:[HYHomeHuXingModel class]]){
        if (tag == 10000) {
            HYHuXingListViewController *huxingVC = [HYHuXingListViewController huXingListViewControllerWithhouseItemId:nil dataModel:dataModelArray extend:@{@"title":title}];
            huxingVC.title = title;
            huxingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:huxingVC animated:YES];
        }else if (tag == 20000){
            HYHuXingDeatilViewController *huxingDeatilVC = [[HYHuXingDeatilViewController alloc] init];
            HYHomeHuXingModel *huxingModel = dataModelArray[indexPath.row];
            huxingDeatilVC.HuXingId = huxingModel.roomTypeId;
            huxingDeatilVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:huxingDeatilVC animated:YES];
        }
    }else if ([dataModelArray.firstObject isKindOfClass:[HYHomePageHotModel class]]){
        if (tag == 10000) {
            LWHomeHotInforListViewController *hotListVC =  [LWHomeHotInforListViewController homeHotInforListViewControllerWithDataArray:dataModelArray Title:title extend:nil];
            hotListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotListVC animated:YES];
        }else if (tag == 20000){
            HYBannerActivityViewController *DeatilVC = [[HYBannerActivityViewController alloc] init];
            HYHomePageHotModel *hotModel = dataModelArray[indexPath.row];
            DeatilVC.web_url = hotModel.linkAddress;
            if (!hotModel.linkAddress) return;
            DeatilVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:DeatilVC animated:YES];
        }
    }
}
#pragma mark --------SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (!_BnDataArray || _BnDataArray.count - 1 < index) return;
    [HYBannerHandlerManager handleWithBannerModel:_BnDataArray[index] sourceViewControlelr:self extend:nil];
}

#pragma mark --------TableViewSourceDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataMutableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *modelArray = self.dataMutableArray[indexPath.section];
    if (modelArray.count > 0) {
        HYBaseHomeModel *model =  modelArray.firstObject;
        return model.cellHeight;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.dataMutableArray[indexPath.section];
    HYHomePageModel *homeModel = arr.firstObject;
    NSString *identifier = HYHOMETABLECELLINDENTIFIER;
    if (homeModel.section > 1) {
        LWHomeHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
        if (!cell) {
            cell = [[LWHomeHotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hot"];
        }
        cell.indexPath = indexPath;
        [cell setDataArray:self.dataMutableArray[indexPath.section]];
        cell.cellView.delegate = self;
        return cell;
    }else{
        HYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[HYHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.indexPath = indexPath;
        [cell setDataArray:self.dataMutableArray[indexPath.section]];
        cell.cellView.delegate = self;
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section != 0 ? MARGIN : 0.001;
}

#pragma mark - Fifth.视图生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self setNaviUI];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.MainTableView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.modelHandler = [[LWHomePageModelHandler alloc] init];
    [self.modelHandler checkVersion];
    
    /** 开始定位 */
    [self.locationTool initLocation];
    self.navigationItem.title = @"好寓Hooray";
    [self setUI];
    [self requestListInfor];
    
    ADD_NOTI(getUserCity, @"alearlyGetCitData");
    //获取消息信息后，更新消息图标
    ADD_NOTI(setNaviUI, GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE);
    ADD_NOTI(addNewRemoteNoti, GETMESSAGEINFORKNOEISORNOTNOLOOKMESSAGE_FOR_PUSH);
    
    [self reuqestAccountInfor];
}

// 应用在前台时调用
- (void)addNewRemoteNoti
{
    [SYSTEM_USERDEFAULTS setBool:YES forKey:ISHAVENOTLOOKMESSAGE];
    [SYSTEM_USERDEFAULTS synchronize];
    [self setNaviUI];
}

// 启动时 获取用户信息
- (void)reuqestAccountInfor
{
    [[HYRequstGlobalDataTool new] requestMessageInforCallBackBlock:nil failureBlock:nil];
    [[HYRequstGlobalDataTool new] requestUserInforCallBackBlock:nil fail:nil];
    [HYUserInfor_LocalData share].isReHT_SuccessBooL = NO;
}

#pragma mark - Sixth.界面配置
- (void)setUI
{
    self.view.backgroundColor = HYCOLOR.color_c1;
    [self.view addSubview:self.MainTableView];
    self.MainTableView.emptyDataSetSource = nil;
    self.MainTableView.emptyDataSetDelegate = nil;
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(280);
    self.MainTableView.tableHeaderView = self.headerView;
    self.MainTableView.backgroundColor = HYCOLOR.color_c1;
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    HYBaseView *citybtn_bg = [[HYBaseView alloc] init];
    HYDefaultButton *cityBtn = [HYDefaultButton buttonImageWithImageNamed:@""
                                                                     type:HYProjectButtonSetBackgroundImage
                                                                   target:self
                                                                 selector:@selector(clickNavItems:)];
    cityBtn.tag = 2;
    cityBtn.titleLabel.font = SYSTEM_REGULARFONT(14);
    NSString *cityname = [HYPublic_LocalData share].last_location_City_M.name;
    [cityBtn setTitle:[NSString stringWithFormat:@" %@ ",cityname] forState:UIControlStateNormal];
    self.cityBtn = cityBtn;
    [cityBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = IMAGENAME(@"choose_cityicon");
    [citybtn_bg addSubview:icon];
    [citybtn_bg addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(citybtn_bg);
        make.right.mas_equalTo(citybtn_bg.mas_right).mas_offset(-10);
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(8, 8));
        make.right.bottom.mas_equalTo(citybtn_bg).mas_offset(-3);
    }];
    citybtn_bg.mj_w = ADJUST_PERCENT_FLOAT(60);
    citybtn_bg.mj_h = ADJUST_PERCENT_FLOAT(30);
    
    [citybtn_bg setBoundWidth:1 cornerRadius:4 boardColor:[UIColor grayColor]];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:citybtn_bg];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setNaviUI
{
    HYDefaultButton *messageBtn = [HYDefaultButton buttonImageWithImageNamed:@"message_icon"
                                                                        type:HYProjectButtonSetImage
                                                                      target:self
                                                                    selector:@selector(clickNavItems:)];
    messageBtn.tag = 1;
    if([HYPublic_LocalData share].isHaveNewMsg){
        [messageBtn setImage:IMAGENAME(@"message_icon_s") forState:UIControlStateNormal];
    }else{
        [messageBtn setImage:IMAGENAME(@"message_icon") forState:UIControlStateNormal];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickNavItems:(UIButton *)sender
{
    if (sender.tag == 1) {
        if (![HYUserInfor_LocalData share].isLogin) {
            [HYUserInfor_LocalData LoginWithVC:self];
            return;
        }
        [HYMessageViewController pushMessageViewControllerWithSourceVC:self];
    }else{
        HYCityListViewController *cityListVC = [HYCityListViewController creatCityListViewController:self.user_location_city
                                                                                           CallBlock:^(id sender) {
                                                                                               [self.cityBtn setTitle:[NSString stringWithFormat:@" %@ ",sender] forState:UIControlStateNormal];
                                                                                               [self requestListInfor];
                                                                                                                                                                                             //修改房源列表的筛选条件
                                                                                               POST_NOTI(HOUSERESOURCE_CITYID_FORCHANGECITY_INHOUMEPAGE_NOTI, nil);
                                                                                               
                                                                                           }];
        cityListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityListVC animated:YES];
    }
}

/**
 通过定位的城市 和 城市列表中的城市匹配 拿到当前城市的数据模型 并存储
 */
- (void)getUserCity
{
    NSArray *locat_City_arr = [HYPublic_LocalData share].cityGroupDatas;
    if ([_user_location_city isEqualToString:@"定位失败"]) {
        [HYPublic_LocalData share].location_City_M = locat_City_arr.firstObject;
        return;
    }
    if(_user_location_city && locat_City_arr){
        for (HYCityGroupModel *model in locat_City_arr) {
            if([model.name isEqualToString:_user_location_city] ||
               [model.name containsString:_user_location_city]){
                [HYPublic_LocalData share].location_City_M = model;
            }
        }
    }else{
        [HYPublic_LocalData share].location_City_M = locat_City_arr.firstObject;
    }
}

/**
 定位工具类
 */
- (HYLocationTool*)locationTool
{
    if (!_locationTool) {
        _locationTool = [[HYLocationTool alloc] init];
        WEAKSELF(self);
        _locationTool.callBackLocationBlock = ^(id sender) {
            weakself.user_location_city = sender;
            LWLog(@"*******sender:%@",sender);
            [weakself getUserCity];
        };
    }
    return _locationTool;
}

#pragma mark - Seventh.懒加载
- (HYHomeTableHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[HYHomeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(280))];
        _headerView.viewController = self;
        _headerView.ImageScrollView.delegate = self;
        WEAKSELF(self);
        _headerView.clickFuncBtnBlcok = ^(id sender) {
            [weakself clickHeaderViewFuncBtnWithKey:sender];
        };
    }
    return _headerView;
}

- (NSArray*)BnDataArray
{
    if (!_BnDataArray) {
        _BnDataArray = [[NSArray alloc] init];
    }
    return _BnDataArray;
}

#pragma mark - Eigth.Other

-(void)dealloc
{
    _locService = nil;
    [SYSTEM_NOTIFICATIONCENTER removeObserver:self];
}

@end
