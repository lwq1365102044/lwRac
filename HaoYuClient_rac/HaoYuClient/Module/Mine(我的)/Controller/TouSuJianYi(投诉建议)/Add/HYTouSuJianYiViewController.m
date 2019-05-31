//
//  HYTouSuJianYiViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTouSuJianYiViewController.h"
#import "HYTouSuJianYiMainView.h"
#import "HYTouSuJIanYiListViewController.h"
#import "HYBaseBarButtonItem.h"
#import "HYAddPhotoView.h"
#import "LWImagePicker.h"
#import "LWHud.h"
#import "LWAddPhotoManager.h"

@interface HYTouSuJianYiViewController ()
@property (nonatomic, copy) HYTouSuJianYiMainView * mainView;
@property (nonatomic, strong) HYContractModel * hetongModel;
@property (nonatomic, strong) LWAddPhotoManager * addPicManager;

@end

@implementation HYTouSuJianYiViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
- (void)commitParam
{
    if (!self.addPicManager.selectImages) {
        return;
    }
    NSLog(@"--------%@",self.addPicManager.selectImages);
    
    PARA_CREART;
    PARA_SET(self.addPicManager.selectImages, @"picList");
    PARA_SET(@(self.mainView.complaintType - 1), @"complaintType");
    PARA_SET([_hetongModel.zukeName isNullToString], @"customer");
    PARA_SET([USERDEFAULTS_GET(USER_INFOR_PHONE) isNullToString], @"customerCalls");
    PARA_SET([_hetongModel.chengzuId isNullToString], @"contractNumber");
    PARA_SET([_hetongModel.houseId isNullToString], @"houseId");
    NSString *contentEncode = [_mainView.textview.TextView.text ex_base64Encode];
    NSString *titleEncode = [_mainView.titleTextFiled.textFiled.text ex_base64Encode];
    PARA_SET([titleEncode isNullToString], @"repairContent");
    PARA_SET([contentEncode isNullToString], @"repairServiceContent");
    
    LWLog(@"***********投诉建议 参数：%@",para);
    
    [[HYServiceManager share] postRequestAnWithurl:TOUSUJIANYI_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          if ([objc[@"status"][@"code"] isEqualToString:@"200"]) {
                                              ALERT(@"提交成功!");
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
    
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
+ (instancetype)creatTouSuJianYiViewControllerWithHeTongModel:(HYContractModel *)hetongModel
{
    HYTouSuJianYiViewController *instance = [[HYTouSuJianYiViewController alloc] init];
    instance.hetongModel = hetongModel;
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉建议";
    [self setUI];
    WEAKSELF(self);
    self.mainView.callBackBlock = ^(id sender) {
        [weakself commitParam];
    };
    
    
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.MainScrollView addSubview:self.mainView];
    [self.view addSubview:self.MainScrollView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH);
        make.left.right.bottom.mas_equalTo(self.MainScrollView);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    WEAKSELF(self);
    HYBaseBarButtonItem*rightItem = [HYBaseBarButtonItem barButtonItemWithimageNamed:@"mine_touSu_List_icon" callBack:^(id sender) {
        HYTouSuJIanYiListViewController *addVC = [[HYTouSuJIanYiListViewController alloc] init];
        [weakself.navigationController pushViewController:addVC animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Seventh.懒加载
- (HYTouSuJianYiMainView*)mainView
{
    if (!_mainView) {
        _mainView = [[HYTouSuJianYiMainView alloc] init];
//        _mainView.titleView.rightLable.text = _hetongModel.zukePhone;
        _addPicManager = [[LWAddPhotoManager alloc] init];
        [_addPicManager setAddPicManager:_mainView.addPhotoView];
    }
    return _mainView;
}

#pragma mark - Eigth.Other


@end
