//
//  HYHuXingDeatilViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingDeatilViewController.h"
#import "HYHuXingDeatilMainView.h"
#import "HYPictureCarouselView.h"
#import "HYPhotoBrowserViewController.h"
#import "HYActionSheet.h"
#import "HYStringTool.h"
#import "HYOnLineYuYueViewController.h"
#import "HYOnLineYuDingViewController.h"
#import "HYHuXingInforModel.h"
@interface HYHuXingDeatilViewController ()<SDCycleScrollViewDelegate,PBViewControllerDataSource,PBViewControllerDelegate>
@property (nonatomic, strong) HYHuXingDeatilMainView * MainView;
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) NSMutableArray * imageUrlStringArray;
@property (nonatomic, strong) NSMutableArray * HouseImageViewArr;
@property (nonatomic, strong) HYHuXingInforModel * huxingInforModel;

@property (nonatomic, strong) NSString * collectionId;
@property (nonatomic, strong) HYDefaultButton * leftBtn;
@property (nonatomic, strong) HYFillLongButton * rigthBtn;
@end

@implementation HYHuXingDeatilViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求
/**
 添加收藏
 */
- (void)CollectRequestWithType:(NSInteger)isAddCollect
{
    if (![HYUserInfor_LocalData share].isLogin) {
        [HYUserInfor_LocalData LoginWithVC:self];
        return;
    }
    // 1 取消
    PARA_CREART;
    PARA_SET([HYStringTool checkString:_HuXingId], @"roomTypeId");
    PARA_SET([HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_NAME)], @"houseUserName");
    PARA_SET([HYStringTool checkString:USERDEFAULTS_GET(USER_INFOR_PHONE)], @"phone");
    NSString *URLStr = ADD_HUXING_COLLECT_URL;
    if (isAddCollect == 1) {
        URLStr = CANCLE_HUXING_COLLECT_URL;
        PARA_SET([HYStringTool checkString:_collectionId], @"collectionId");
    }
    LWLog(@"\n\n-----%@",para);
    _MainView.topInforView.collectBtn.userInteractionEnabled = NO;
    [[HYServiceManager share] postRequestAnWithurl:URLStr
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          if (isAddCollect == 1) {
                                              _MainView.topInforView.collectBtn.selected = NO;
                                              ALERT(@"取消成功!");
                                          }else{
                                              _collectionId = objc[@"result"];
                                              _MainView.topInforView.collectBtn.selected = YES;
                                              ALERT(@"收藏成功!");
                                          }
                                          _MainView.topInforView.collectBtn.userInteractionEnabled = YES;
                                      } failureBlock:^(id error, id requestInfo) {
                                          ALERT((isAddCollect == 1 ) ? @"取消失败!" : @"收藏失败!");
                                          _MainView.topInforView.collectBtn.userInteractionEnabled = YES;
                                      }];
}

- (void)loadHuxingInfor
{
    PARA_CREART;
    PARA_SET(_HuXingId, @"id");
    [[HYServiceManager share] postRequestAnWithurl:HUXINGDEATIL_INFOR_URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        _huxingInforModel = [HYHuXingInforModel modelWithJSON:objc[@"result"]];
                                        _MainView.huxingInforModel = _huxingInforModel;
                                        NSMutableArray *pic_Arr = [[NSMutableArray alloc] init];
                                        for (HYpicObjModel *pic_M in _huxingInforModel.picsModel) {
                                            [pic_Arr addObject:pic_M.big];
                                        }
                                        _imageUrlStringArray = pic_Arr;
                                        _MainView.ImageScrollView.imageURLStringsGroup = _imageUrlStringArray;
                                        _collectionId = _huxingInforModel.collectionId;
                                        [self updateBottmSubview];
                                    } failureBlock:^(id error, id requestInfo) {
                                        
                                    }];
}

#pragma mark - Third.点击事件
- (void)clickBottomBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"预约"]) {
        [HYActionSheet showDefaultAlert:self titleKey:@"请选择预约方式：" buttonArr:@[@"电话预约",@"在线预约"] callBack:^(id sender) {
            NSInteger index = [sender integerValue];
            if (index == 0) {
                NSString *mendian = self.huxingInforModel.itemPhone;
                [HYStringTool CallPhoneWith:self.view phone:[HYStringTool checkString:mendian]];
            }else if(index == 1){
                [HYOnLineYuYueViewController onlineYuYueViewControllerFrom:self extend:_huxingInforModel];
            }
        }];
    }else if([sender.titleLabel.text isEqualToString:@"预定"]){
        [HYOnLineYuDingViewController onLineYuDingViewControllerFrom:self Extend:_huxingInforModel];
    }else if([sender.titleLabel.text isEqualToString:@"电话联系"]){
        NSString *mendian = self.huxingInforModel.itemPhone;
        [HYStringTool CallPhoneWith:self.view phone:[HYStringTool checkString:mendian]];
    }
}

#pragma mark - Fourth.代理方法

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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"户型详情";
    [self setUI];
    
    [self loadHuxingInfor];
}

#pragma mark - Sixth.界面配置
- (void)setUI{
    [self.MainScrollView addSubview:self.MainView];
    [self.view addSubview:self.MainScrollView];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(50));
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ADJUST_PERCENT_BOTTOM(0));
    }];
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(-MARGIN/2);
    }];
    [self.view bringSubviewToFront:self.bottomView];
}
/**
 更新约束
 */
- (void)updateBottmSubview
{
    if (self.huxingInforModel.itemStatus == 4 || self.huxingInforModel.itemStatus == 5) {
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

#pragma mark - Seventh.懒加载
- (HYHuXingDeatilMainView*)MainView
{
    if (!_MainView) {
        _MainView = [[HYHuXingDeatilMainView alloc] init];
        _MainView.ImageScrollView.delegate = self;
        WEAKSELF(self);
        _MainView.callBackBlock = ^(id sender) {
            LWLog(@"**************%ld",[sender integerValue]);
            [weakself CollectRequestWithType:[sender integerValue]];
        };
    }
    return _MainView;
}

- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        HYDefaultButton *leftBtn = [HYDefaultButton buttonWithTitleStringKey:@"预约"
                                                                  titleColor:HYCOLOR.color_c3
                                                                   titleFont:SYSTEM_REGULARFONT(15)
                                                                      target:self
                                                                    selector:@selector(clickBottomBtn:)];
        HYFillLongButton *rightBtn = [HYFillLongButton buttonCorWithTitleStringKey:@"预定"
                                                                            target:self
                                                                          selector:@selector(clickBottomBtn:)];
        [_bottomView addSubview:leftBtn];
        [_bottomView addSubview:rightBtn];
        [leftBtn setBoundWidth:.5 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        rightBtn.hidden = leftBtn.hidden = YES;
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

- (NSMutableArray*)HouseImageViewArr
{
    if (!_HouseImageViewArr) {
        _HouseImageViewArr = [[NSMutableArray alloc] init];
    }
    return _HouseImageViewArr;
}
@end
