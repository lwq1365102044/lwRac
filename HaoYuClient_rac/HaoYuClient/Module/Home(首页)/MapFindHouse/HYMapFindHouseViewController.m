//
//  HYMapFindHouseViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/15.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMapFindHouseViewController.h"
#import "HYFindHouseMenDianInforView.h"
#import "HYHouseProjectInforTool.h"
#import "HYHouseRescourcesModel.h"
#import "HYHouseRescourceDeatilViewController.h"
#define INFORView_H  240
@interface HYMapFindHouseViewController ()<HYMapViewDelegate>
@property (nonatomic, strong) HYMapView * myMapView;
@property (nonatomic, strong) HYFindHouseMenDianInforView * menDianInforView;
@property (nonatomic, strong) HYHouseRescourcesModel *projectModel;

@end

@implementation HYMapFindHouseViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 获取项目列表
 */
- (void)requstProjectInfor
{
    [[HYHouseProjectInforTool new] requestProjectInforByCityForMapFindHouseCallBackBlock:^(id sender) {
        NSArray *project_Arr_M = (NSArray *)sender;
        CLLocationCoordinate2D coor;
        coor.longitude = [[HYPublic_LocalData share].location_City_M.lng doubleValue];
        coor.latitude = [[HYPublic_LocalData share].location_City_M.lat doubleValue];
        [_myMapView setHouseDatas:project_Arr_M CenterCoordinate:coor];
    }];
}

#pragma mark - Third.点击事件
- (void)showMenDianInfoView:(HYHouseRescourcesModel *)projectModel
{
    _menDianInforView.hidden = NO;
    _menDianInforView.projectModel = projectModel;
    [UIView animateWithDuration:0.25 animations:^{
        self.menDianInforView.ex_y = self.view.height - INFORView_H;
    }];
    WEAKSELF(self);
    [_menDianInforView bk_whenTapped:^{
        HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
        deatilVC.houseItemId = weakself.menDianInforView.projectModel.customId;
        [weakself.navigationController pushViewController:deatilVC animated:YES];
    }];
}
#pragma mark - Fourth.代理方法

#pragma HYMapViewDelegate

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view dataModel:(id)dataModel
{
     [self showMenDianInfoView:(HYHouseRescourcesModel *)dataModel];
}

-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [UIView animateWithDuration:0.25 animations:^{
        self.menDianInforView.ex_y = self.view.height;
    }];
}

#pragma mark - Fifth.视图生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地图找房";
    [self requstProjectInfor];
    
    [self.view addSubview:self.myMapView];
    [self.myMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.menDianInforView];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (HYMapView*)myMapView
{
    if (!_myMapView) {
        _myMapView = [HYMapView creatMyMapView:SCREEN_RECT mapType:LWJuHeType];
        _myMapView.delegate = self;
    }
    return _myMapView;
}

- (HYFindHouseMenDianInforView*)menDianInforView
{
    if (!_menDianInforView) {
        _menDianInforView = [[HYFindHouseMenDianInforView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, INFORView_H)];
        _menDianInforView.hidden = YES;
    }
    return _menDianInforView;
}
#pragma mark - Eigth.Other


@end
