//
//  HYOnLineYuDingViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/14.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYOnLineYuDingViewController.h"
#import "HYYuDingXuanFangView.h"
#import "HYYuDingZuYueInforView.h"
#import "HYYuDingSureCommitInforView.h"
#import "HYTopBarView.h"
#import "HYPaymentViewController.h"
#import "HYHouseProjectInforTool.h"
#import "HYHouseRescourcesModel.h"
#import "HYBaseBarButtonItem.h"
#import "HYHuXingDeatilViewController.h"
@interface HYOnLineYuDingViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) HYTopBarView * TopBarView;
@property (nonatomic, strong) HYYuDingXuanFangView * xuanfangView;
@property (nonatomic, strong) HYYuDingZuYueInforView * zuyueInforView;
@property (nonatomic, strong) HYYuDingSureCommitInforView * sureInforView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) HYDefaultButton * leftBtn;
@property (nonatomic, strong) HYDefaultButton * rightBtn;

@property (nonatomic, strong) HYHouseProjectInforTool * projectInforTool;
/**
 房源信息
 */
@property (nonatomic, strong) HYHouseRescourcesModel * houseInfor_M;
//是否已经获取 项目数据
@property (nonatomic, assign) BOOL isGetDataBool;

//选择项目，户型，房间号列表
@property (nonatomic, strong) NSMutableArray * project_Array;
@property (nonatomic, strong) NSMutableArray * huxing_Array;
@property (nonatomic, strong) NSMutableArray * fangjianhao_Array;

@property (nonatomic, strong) UIViewController * sourceVC;
@property (nonatomic, strong) id extend;

@end

@implementation HYOnLineYuDingViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 获取项目列表
 */
- (void)requestProjectInfor
{
    if (self.project_Array.count != 0) {
        self.xuanfangView.projectDatas = self.project_Array;
        return;
    }
    WEAKSELF(self);
    NSString *city_Id = [HYPublic_LocalData share].location_City_M.cityID;
    [self.projectInforTool requestProjectInfor:city_Id
                                 callBackBlock:^(id sender) {
                                      [self.project_Array addObjectsFromArray:sender];
                                     weakself.xuanfangView.projectDatas = (NSArray *)sender;
                                 }];
}

/**
 获取意向户型列表信息
 */
- (void)requestHuxingListInfor:(NSString *)houseItemId
{
    if (!houseItemId) {
        ALERT(@"请先选择房源项目");
        return;
    }
    if (self.huxing_Array.count != 0) {
        self.xuanfangView.huxingDatas = self.huxing_Array;
        return;
    }
    WEAKSELF(self);
    [self.projectInforTool requestHuxingListInfor:houseItemId
                                    callBackBlock:^(id sender) {
                                        [self.huxing_Array addObjectsFromArray:sender];
                                        weakself.xuanfangView.huxingDatas = (NSArray *)sender;
                                    }];
}

/**
 获取房间号
 */
- (void)requestFangJianHaoInfor:(NSString *)roomTypeId
{
    if (!roomTypeId) {
        ALERT(@"请先选择房型");
        return;
    }
    if (self.fangjianhao_Array.count != 0) {
        self.xuanfangView.fangjianhaoDatas = self.fangjianhao_Array;
        return;
    }
    _isGetDataBool = NO;
    WEAKSELF(self);
    [self.projectInforTool requestFangJianHaoLevelInfor:roomTypeId
                                          callBackBlock:^(id sender) {
                                               [self.fangjianhao_Array addObjectsFromArray:sender];
                                              weakself.xuanfangView.fangjianhaoDatas = (NSArray *)sender;
                                          }];
}

/**
 选择房间号后 获取该房间的信息
 */
- (void)requestHouseInfor:(NSString *)houseId
{
    PARA_CREART;
    PARA_SET(houseId, @"houseId");
    [[HYServiceManager share] postRequestAnWithurl:GET_YUDINGHOUSTE_DEATIL_INFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"****\n选择房间号后 获取该房间的信息:%@",objc);
                                        _isGetDataBool = YES;
                                        _houseInfor_M = [HYHouseRescourcesModel modelWithJSON:objc[@"result"]];
                                        _xuanfangView.houseInfor_M = _houseInfor_M;
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

/**
 提交信息
 */
- (void)commitZuKeInfor
{
    PARA_CREART;
    PARA_SET(_houseInfor_M.zukePhone, @"zukePhone");
    PARA_SET(_houseInfor_M.houseId, @"houseId");
    PARA_SET(_houseInfor_M.zukeName, @"zukeName");
    PARA_SET(_sureInforView.endtime, @"endtime");
    PARA_SET(_houseInfor_M.isJizhong, @"isJizhong");
    PARA_SET(_houseInfor_M.money, @"money");
    PARA_SET(_houseInfor_M.signTime, @"signTime"); //预计签约时间
    PARA_SET(_houseInfor_M.bookInAdvance, @"bookInAdvance");
    [[HYServiceManager share] postRequestAnWithurl:COMMIT_YUDINGHOUSTE_INFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        LWLog(@"----%@",objc);
                                        NSDictionary *result_dic = objc[@"result"];
                                        NSMutableArray *idsArr = [[NSMutableArray alloc] init];
                                        if (result_dic[@"id"]) {
                                            [idsArr addObject:result_dic[@"id"]];
                                        }
                                        NSString *deptId = result_dic[@"houseItem"][@"deptId"];
                                        PARA_CREART;
                                        if(idsArr)  PARA_SET(idsArr, @"ids");
                                        if(deptId) PARA_SET(deptId, @"deptId");
                                        [HYPaymentViewController pushPayViewController:self PayMentType:PAYMENTTYPE_DEPOSIT extend:para];
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

#pragma mark - Third.点击事件
- (void)clickBottomBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"上一步"]) {
        _pageIndex --;
    }else if([sender.titleLabel.text isEqualToString:@"下一步"]){
        
        if (_pageIndex == 0) {
            if(self.xuanfangView.param[@"houseId"] == nil ||
               [self.xuanfangView.param[@"houseId"] isEqualToString:@""]){
                ALERT(@"请先选择要预订的房间号");
                return;
            }
            if (!_isGetDataBool) {
                return;
            }
                _houseInfor_M.houseId = _xuanfangView.param[@"houseId"];
                _zuyueInforView.houseInfor_M = _houseInfor_M;
        }
        if (_pageIndex == 1) {
            if (![_zuyueInforView checkPara]) {
                return;
            }else{
                _houseInfor_M.ruzhuTime = _zuyueInforView.para[@"endtime"];
                _houseInfor_M.zukeName = _zuyueInforView.para[@"zukeName"];
                _houseInfor_M.zukePhone = _zuyueInforView.para[@"zukePhone"];
                _houseInfor_M.signTime = _zuyueInforView.para[@"signTime"];
                _sureInforView.houseInfor_M = _houseInfor_M;
            }
        }
        _pageIndex ++;
    }else if ([sender.titleLabel.text isEqualToString:@"确认并支付"]){
        [self commitZuKeInfor];
        return;
    }
    [self.TopBarView selectIndex:_pageIndex];
    [self.MainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*_pageIndex, 0) animated:YES];
    [self setBottomContrans];
}
#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 先判断是否登录 在选择跳转
 */
+ (void)onLineYuDingViewControllerFrom:(UIViewController *)sourceVc Extend:(id)extend
{
    HYOnLineYuDingViewController *instance = [[HYOnLineYuDingViewController alloc] init];
    instance.sourceVC = sourceVc;
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
    self.closePopGesture = YES;
    
    _pageIndex = 0;
    _isGetDataBool = NO;
    self.title = @"在线预订";
    [self setUI];
    [self setNavi];
    
    if ([self.sourceVC isKindOfClass:[HYHuXingDeatilViewController class]]) {
        [self.xuanfangView setDatasWhenFromDeatil:_extend];
    }
    
    self.restoreInteractivePopGestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
}

- (void)setNavi
{
    HYBaseBarButtonItem *backItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        [HYWraingAlert showAlert:self
                           title:@"确定退出预定？"
                         message:@""
              defaultButtonTitle:@"取消"
               cancelButtonTitle:@"确定"
      defaultButtonCallBackBlock:^(id sender) {
      } cancelButtonCallBackBlock:^(id sender) {
          [self.navigationController popViewControllerAnimated:YES];
      }];
    }];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)setUI
{
    [self.view addSubview:self.TopBarView];
    [self.view addSubview:self.MainScrollView];
    [self.view addSubview:self.bottomView];
    self.TopBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(40));
    [self.TopBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_offset(MARGIN*4);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(MARGIN*5);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(0));
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.TopBarView.mas_bottom).mas_offset(MARGIN);
        make.bottom.mas_equalTo(self.self.bottomView.mas_top).mas_offset(MARGIN*0);
    }];
    self.MainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 1);
    self.MainScrollView.pagingEnabled = YES;
    self.MainScrollView.delegate = self;
    self.MainScrollView.showsHorizontalScrollIndicator = NO;
    self.MainScrollView.scrollEnabled = NO;
    [self creatSubViews];
}

- (void)creatSubViews
{
    [self.MainScrollView addSubview:self.xuanfangView];
    [self.MainScrollView addSubview:self.zuyueInforView];
    [self.MainScrollView addSubview:self.sureInforView];
    _xuanfangView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MARGIN*4-MARGIN*4.5-NAVIGATOR_HEIGHT);
    _zuyueInforView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MARGIN*4-MARGIN*4.5-NAVIGATOR_HEIGHT);
    _sureInforView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MARGIN*4-MARGIN*4.5-NAVIGATOR_HEIGHT);
}

#pragma mark - Sixth.界面配置
- (void)setBottomContrans
{
    if (_pageIndex == 0) {
        _leftBtn.hidden = YES;
        [_rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.7, MARGIN*3));
            make.centerX.mas_equalTo(_bottomView.mas_centerX);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
        [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
            make.width.mas_offset(0);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            make.centerX.mas_equalTo(_bottomView.mas_centerX);
        }];
    }else{
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(MARGIN*3);
            make.left.mas_equalTo(_leftBtn.mas_right).mas_offset(MARGIN*2);
            make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-MARGIN*2);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
        _leftBtn.hidden = NO;
        [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_rightBtn.mas_height);
            make.width.mas_equalTo(_rightBtn.mas_width);
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(MARGIN*2);
            make.right.mas_equalTo(_rightBtn.mas_left).mas_offset(-MARGIN*2);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
        if (_pageIndex == 2) {
            [_rightBtn setTitle:@"确认并支付" forState:UIControlStateNormal];
        }else{
            [_rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Seventh.懒加载
- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        _leftBtn = [HYDefaultButton buttonWithTitleStringKey:@"上一步"
                                                  titleColor:HYCOLOR.color_c4
                                                   titleFont:SYSTEM_REGULARFONT(15)
                                                      target:self
                                                    selector:@selector(clickBottomBtn:)];
        _rightBtn = [HYDefaultButton buttonWithTitleStringKey:@"下一步"
                                                   titleColor:HYCOLOR.color_c4
                                                    titleFont:SYSTEM_REGULARFONT(15)
                                                       target:self
                                                     selector:@selector(clickBottomBtn:)];
        [_bottomView addSubview:_leftBtn];
        [_bottomView addSubview:_rightBtn];
        [_leftBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [_rightBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [self setBottomContrans];
    }
    return _bottomView;
}

- (HYTopBarView*)TopBarView
{
    if (!_TopBarView) {
        _TopBarView = [HYTopBarView creatTopBarWithDataArr:@[@"预订选房",@"租约信息",@"确认提交"] selectColor:[UIColor redColor] callBack:^(NSInteger index) {
        }];
        _TopBarView.isNotCanClickBool = YES;
    }
    return _TopBarView;
}

- (HYYuDingXuanFangView*)xuanfangView
{
    if (!_xuanfangView) {
        _xuanfangView = [[HYYuDingXuanFangView alloc] init];
        WEAKSELF(self);
        _xuanfangView.clickProjectBlock = ^(id sender) {
            [weakself requestProjectInfor];
            [weakself.huxing_Array removeAllObjects];
            [weakself.fangjianhao_Array removeAllObjects];
        };
        _xuanfangView.clickHuxignBlock = ^(id sender) {
            [weakself requestHuxingListInfor:sender];
            [weakself.fangjianhao_Array removeAllObjects];
        };
        _xuanfangView.clickFangJianHaoBlock = ^(id sender) {
            [weakself requestFangJianHaoInfor:sender];
        };
        _xuanfangView.requestHouseInforBlock = ^(id sender) {
            [weakself requestHouseInfor:sender];
        };
    }
    return _xuanfangView;
}
- (HYYuDingZuYueInforView*)zuyueInforView
{
    if (!_zuyueInforView) {
        _zuyueInforView = [[HYYuDingZuYueInforView alloc] init];
        _zuyueInforView.viewController = self;
    }
    return _zuyueInforView;
}
- (HYYuDingSureCommitInforView*)sureInforView
{
    if (!_sureInforView) {
        _sureInforView = [[HYYuDingSureCommitInforView alloc] init];
    }
    return _sureInforView;
}
- (HYHouseProjectInforTool *)projectInforTool
{
    if (!_projectInforTool) {
        _projectInforTool = [[HYHouseProjectInforTool  alloc] init];
    }
    return _projectInforTool;
}
- (NSMutableArray*)project_Array
{
    if (!_project_Array) {
        _project_Array = [[NSMutableArray alloc] init];
    }
    return _project_Array;
}
- (NSMutableArray*)huxing_Array
{
    if (!_huxing_Array) {
        _huxing_Array = [[NSMutableArray alloc] init];
    }
    return _huxing_Array;
}
- (NSMutableArray*)fangjianhao_Array
{
    if (!_fangjianhao_Array) {
        _fangjianhao_Array = [[NSMutableArray alloc] init];
    }
    return _fangjianhao_Array;
}
#pragma mark - Eigth.Other

@end
