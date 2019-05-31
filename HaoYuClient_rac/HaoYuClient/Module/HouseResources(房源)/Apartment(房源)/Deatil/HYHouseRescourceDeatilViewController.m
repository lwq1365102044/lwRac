//
//  HYHouseRescourceDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourceDeatilViewController.h"
#import "HYHouseRescourceDeatiMainView.h"
#import "HYStringTool.h"
#import "HYPictureCarouselView.h"
#import "HYPhotoBrowserViewController.h"
#import "HYHuXingListViewController.h"
#import "HYHuXingDeatilViewController.h"
#import "HYOnLineYuYueViewController.h"
#import "HYHouseRescourcesModel.h"
#import "HYPointAnnotation.h"
#import "HYPointModel.h"
#import "HYMapViewController.h"
@interface HYHouseRescourceDeatilViewController ()<SDCycleScrollViewDelegate,PBViewControllerDataSource,PBViewControllerDelegate,BMKMapViewDelegate,HYMapViewDelegate>
@property (nonatomic, strong) HYHouseRescourceDeatiMainView * MainView;
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) NSMutableArray * imageUrlStringArray;
@property (nonatomic, strong) NSMutableArray * HouseImageViewArr;
@property (nonatomic, strong) HYHouseRescourcesModel * DataModel;
@property (nonatomic, strong) HYDefaultButton * leftBtn;
@property (nonatomic, strong) HYFillLongButton * rigthBtn;

@end

@implementation HYHouseRescourceDeatilViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestHouseRecourcesInfor
{
    PARA_CREART;
    PARA_SET(_houseItemId, @"houseItemId");
    [[HYServiceManager share] postRequestAnWithurl:HOUSE_DEATIL_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          self.DataModel = [HYHouseRescourcesModel modelWithJSON:objc[@"result"]];
                                          _MainView.dataModel = _DataModel;
                                          NSMutableArray *picArr = [[NSMutableArray alloc] init];
                                          for (HYpicObjModel *pic_M in _DataModel.picArrModel) {
                                              [picArr addObject:pic_M.big];
                                          }
                                          _imageUrlStringArray = picArr;
                                          _MainView.ImageScrollView.imageURLStringsGroup = picArr;
                                          //即将开业
                                          _MainView.statusImageView.hidden = !(self.DataModel.itemStatus == 4);
                                          [self updateBottmSubview];
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Third.点击事件
- (void)clickBottomBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"电话预约"] ||
        [sender.titleLabel.text isEqualToString:@"电话联系"]) {
        NSString *mendian = self.DataModel.mendianPhone;
        [HYStringTool CallPhoneWith:self.view phone:[HYStringTool checkString:mendian]];
    }else if([sender.titleLabel.text isEqualToString:@"在线预约"]){
        [HYOnLineYuYueViewController onlineYuYueViewControllerFrom:self extend:self.DataModel];
    }
}

#pragma mark - Fourth.代理方法

#pragma HYMapViewDelegate
/**
 点击地图的空白处
 */
-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D  coor = CLLocationCoordinate2DMake([self.DataModel.lat doubleValue], [self.DataModel.lng doubleValue]);
    HYMapViewController *mapVC = [[HYMapViewController alloc] init];
    mapVC.locationCoordinate = coor;
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HYPhotoBrowserViewController *pbViewController = [[HYPhotoBrowserViewController alloc]init];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = index;
    [self presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.imageUrlStringArray.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    
    NSString *imageUrl = self.imageUrlStringArray[index];
    imageUrl = [NSString stringWithFormat:@"%@",imageUrl];
    imageUrl = HYIMAGEURLSTRING(HYProjectImageURLStringLarge, imageUrl);
    
    [imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl]
                 placeholderImage:nil
                        completed:^(UIImage * _Nullable image,
                                    NSError * _Nullable error,
                                    SDImageCacheType cacheType,
                                    NSURL * _Nullable imageURL) {
                        }];
}


#pragma mark - PBViewControllerDelegate
- (void)viewController:(nonnull PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(nullable UIImage *)presentedImage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Fifth.视图生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.MainView.contactUsView.mapView.myMapView viewWillAppear];
    self.MainView.contactUsView.mapView.myMapView.delegate = self.MainView.contactUsView.mapView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.MainView.contactUsView.mapView.myMapView viewWillDisappear];
    self.MainView.contactUsView.mapView.myMapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公寓详情";
    [self setUI];
    [self requestHouseRecourcesInfor];
}
#pragma mark - Sixth.界面配置
- (void)setUI{
    [self.MainScrollView addSubview:self.MainView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(50));
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(0));
    }];
    
    [self.view addSubview:self.MainScrollView];
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(-MARGIN/2);
    }];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    
    [self.view bringSubviewToFront:self.bottomView];
}

#pragma mark - Seventh.懒加载
- (HYHouseRescourceDeatiMainView*)MainView
{
    if (!_MainView) {
        _MainView = [[HYHouseRescourceDeatiMainView alloc] init];
        _MainView.ImageScrollView.delegate = self;
        WEAKSELF(self);
        _MainView.clickHuxingBlock = ^(NSInteger row) {
            if(row>0){
                if(!weakself.DataModel.roomTypeArrModel || weakself.DataModel.roomTypeArrModel.count==0){return ;}
                HYHuXingInforModel *huxingModel = weakself.DataModel.roomTypeArrModel[row-1];
                HYHuXingDeatilViewController *huxingDeatilVC = [[HYHuXingDeatilViewController alloc] init];
                huxingDeatilVC.HuXingId = huxingModel.customId;
                [weakself.navigationController pushViewController:huxingDeatilVC animated:YES];
            }else{
                HYHuXingListViewController *huxingVC = [HYHuXingListViewController huXingListViewControllerWithhouseItemId:weakself.houseItemId dataModel:nil extend:nil];
                [weakself.navigationController pushViewController:huxingVC animated:YES];
            }
        };
        _MainView.contactUsView.mapView.delegate = self;
    }
    return _MainView;
}

/**
 更新约束
 */
- (void)updateBottmSubview
{
    if (self.DataModel.itemStatus == 4 || self.DataModel.itemStatus == 5) {
        [_leftBtn setTitle:@"电话联系" forState:UIControlStateNormal];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(20));
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(20));
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
        }];
        _rigthBtn.hidden = !(_leftBtn.hidden = NO);
    }else{
        _leftBtn.hidden = _rigthBtn.hidden = NO;
    }
}

- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        HYDefaultButton *leftBtn = [HYDefaultButton buttonWithTitleStringKey:@"电话预约"
                                                                  titleColor:HYCOLOR.color_c3
                                                                   titleFont:SYSTEM_REGULARFONT(15)
                                                                      target:self
                                                                    selector:@selector(clickBottomBtn:)];
        HYFillLongButton *rightBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"在线预约"
                                                                            target:self
                                                                          selector:@selector(clickBottomBtn:)];
        [_bottomView addSubview:leftBtn];
        [_bottomView addSubview:rightBtn];
        leftBtn.hidden = rightBtn.hidden = YES;
        [leftBtn setBoundWidth:.5 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(20));
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            make.right.mas_equalTo(rightBtn.mas_left).mas_offset(-ADJUST_PERCENT_FLOAT(30));
            make.width.mas_equalTo(rightBtn.mas_width);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(40));
        }];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftBtn.mas_right).mas_offset(ADJUST_PERCENT_FLOAT(30));
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-ADJUST_PERCENT_FLOAT(20));
            make.width.mas_equalTo(leftBtn.mas_width);
            make.height.mas_equalTo(leftBtn.mas_height);
        }];
        
        _leftBtn = leftBtn;
        _rigthBtn = rightBtn;
    }
    return _bottomView;
}

- (NSMutableArray*)imageUrlStringArray
{
    if (!_imageUrlStringArray) {
        _imageUrlStringArray = [[NSMutableArray alloc] init];
    }
    return _imageUrlStringArray;
}

#pragma mark - Eigth.Other
-(void)dealloc
{
    //销毁地图视图
    [_MainView.contactUsView.mapView removeFromSuperview];
    _MainView.contactUsView.mapView = nil;
}
@end
