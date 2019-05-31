//
//  HYOnLineYuYueViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYOnLineYuYueViewController.h"
#import "HYYuYueMainView.h"
#import "HYYuYueResultViewController.h"
#import "HYCityModel.h"
#import "HYStringTool.h"
#import "HYHouseProjectInforTool.h"
#import "HYHouseRescourceDeatilViewController.h"
#import "HYHuXingDeatilViewController.h"
@interface HYOnLineYuYueViewController ()
@property (nonatomic, strong) HYYuYueMainView * mainView;
/**
 项目数据列表
 */
@property (nonatomic, strong) NSMutableArray * projectArrary;
/**
 户型数据列表
 */
@property (nonatomic, strong) NSMutableArray * huxingArrary;

@property (nonatomic, strong) HYHouseProjectInforTool * projectInforTool;

@property (nonatomic, strong) UIViewController * sourceVc;
@property (nonatomic, strong) id  extend;

@end

@implementation HYOnLineYuYueViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 获取项目列表
 */
- (void)requestProjectInfor
{
    WEAKSELF(self);
    NSString *city_Id = [HYPublic_LocalData share].location_City_M.cityID;
    [self.projectInforTool requestProjectInfor:city_Id callBackBlock:^(id sender) {
        weakself.mainView.projectDatas = (NSArray *)sender;
    }];
}

/**
 获取意向户型列表信息
 */
- (void)requestHuxingListInfor:(NSString *)houseItemId
{
    WEAKSELF(self);
    if (!houseItemId) {
        ALERT(@"请先选择房源项目");
        return;
    }
    [self.projectInforTool requestHuxingListInfor:houseItemId
                                    callBackBlock:^(id sender) {
                                         weakself.mainView.huxingDatas = (NSArray *)sender;
                                    }];
}

#pragma mark - Third.点击事件
- (void)clickCommitBtn:(UIButton *)sender
{
    if (![_mainView checkPara]) {
        return;
    }
    NSMutableDictionary *param  = [[NSMutableDictionary alloc] initWithDictionary:_mainView.param];
    param[@"loginCellPhone"] = [HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)];
    param[@"needRemark"] = @"";
    param[@"age"] = @"";
    
    [[HYServiceManager share] postRequestAnWithurl:COMMIT_YUYUEHOUSTE_INFOR_URL
                                         paramters:param
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n***预约房间：%@",objc);
                                          NSString *satus = objc[@"status"][@"code"];
                                          if ([satus isEqualToString:@"200"]) {
                                              
                                              HYYuYueResultViewController * resultVC = [[HYYuYueResultViewController alloc] init];
                                              [self.navigationController pushViewController:resultVC animated:YES];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
/**
 在线预约 判断是否登录
 */
+ (void)onlineYuYueViewControllerFrom:(UIViewController *)sourceVc extend:(id)extend
{
    HYOnLineYuYueViewController *instance = [[HYOnLineYuYueViewController alloc] init];
    instance.sourceVc = sourceVc;
    instance.extend = extend;
    if([HYUserInfor_LocalData share].isLogin){
        instance.hidesBottomBarWhenPushed = YES;
        [sourceVc.navigationController pushViewController:instance animated:YES];
    }else{
        [HYUserInfor_LocalData LoginWithVC:sourceVc];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约看房";
    [self setUI];
    if ([self.sourceVc isKindOfClass:[HYHouseRescourceDeatilViewController class]] ||
        [self.sourceVc isKindOfClass:[HYHuXingDeatilViewController class]]) {
        [_mainView setProjectWhenFromProjectDeatil:_extend];
    }
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    self.view.backgroundColor = HYCOLOR.color_c0;
    [self.MainScrollView addSubview:self.mainView];
    [self.view addSubview:self.MainScrollView];
    
    HYFillLongButton *commitBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"提交预约"
                                                                         target:self
                                                                       selector:@selector(clickCommitBtn:)];
    [self.view addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - MARGIN*4, MARGIN*4));
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH);
        make.edges.mas_equalTo(self.MainScrollView);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(commitBtn.mas_top).mas_offset(-MARGIN);
    }];
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
}
#pragma mark - Seventh.懒加载

- (HYYuYueMainView*)mainView
{
    if (!_mainView) {
        _mainView = [[HYYuYueMainView alloc] init];
        WEAKSELF(self);
        _mainView.clickMenDianBlock = ^(id sender) {
            [weakself requestProjectInfor];
        };
        _mainView.clickHuXingBlock = ^(id sender) {
            [weakself requestHuxingListInfor:sender];
        };
    }
    return _mainView;
}
/**
 项目数据列表
 */
- (NSMutableArray*)projectArrary
{
    if (!_projectArrary) {
        _projectArrary = [[NSMutableArray alloc] init];
    }
    return _projectArrary;
}
/**
 户型数据列表
 */
- (NSMutableArray*)huxingArrary
{
    if (!_huxingArrary) {
        _huxingArrary = [[NSMutableArray alloc] init];
    }
    return _huxingArrary;
}

- (HYHouseProjectInforTool*)projectInforTool
{
    if (!_projectInforTool) {
        _projectInforTool = [[HYHouseProjectInforTool alloc] init];
    }
    return _projectInforTool;
}
#pragma mark - Eigth.Other

@end
