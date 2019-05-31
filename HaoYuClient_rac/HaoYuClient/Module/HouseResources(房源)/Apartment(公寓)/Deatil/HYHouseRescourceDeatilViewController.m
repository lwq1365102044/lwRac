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

@interface HYHouseRescourceDeatilViewController ()<SDCycleScrollViewDelegate,PBViewControllerDataSource,PBViewControllerDelegate>
@property (nonatomic, strong) HYHouseRescourceDeatiMainView * MainView;
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) NSMutableArray * imageUrlStringArray;
@property (nonatomic, strong) NSMutableArray * HouseImageViewArr;

@end

@implementation HYHouseRescourceDeatilViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件
- (void)clickBottomBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"电话预约"]) {
        [HYStringTool CallPhoneWith:self.view phone:@"18801040890"];
    }else if([sender.titleLabel.text isEqualToString:@"在线预约"]){
        HYOnLineYuYueViewController *yuyueVC = [[HYOnLineYuYueViewController alloc] init];
        [self.navigationController pushViewController:yuyueVC animated:YES];
    }
}

#pragma mark - Fourth.代理方法

#pragma SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    LWLog(@"----\n\n\n\nimagescrollview:%@----%ld",cycleScrollView,index);
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
    self.title = @"公寓详情";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI{
    [self.MainScrollView addSubview:self.MainView];
    self.MainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - ADJUST_PERCENT_FLOAT(50));
    [self.view addSubview:self.MainScrollView];
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.MainScrollView);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(ADJUST_PERCENT_FLOAT(50));
        make.left.right.bottom.mas_equalTo(self.view);
    }];
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
                HYHuXingDeatilViewController *huxingDeatilVC = [[HYHuXingDeatilViewController alloc] init];
                [weakself.navigationController pushViewController:huxingDeatilVC animated:YES];
            }else{
                HYHuXingListViewController *huxingVC = [[HYHuXingListViewController alloc] init];
                [weakself.navigationController pushViewController:huxingVC animated:YES];
            }
        };
    }
    return _MainView;
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
        [leftBtn setBoundWidth:.5 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(ADJUST_PERCENT_FLOAT(20));
//            make.bottom.mas_equalTo(_bottomView.mas_bottom).mas_offset(-ADJUST_PERCENT_FLOAT(10));
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
    }
    return _bottomView;
}

- (NSMutableArray*)imageUrlStringArray
{
    if (!_imageUrlStringArray) {
        _imageUrlStringArray = [[NSMutableArray alloc] init];
        [_imageUrlStringArray addObjectsFromArray:@[
                                                    @"http://www.lanjing-lijia.com/ljshops/images/upload/2017-01/Image/1484014020.jpg",
                                                    @"http://r-cc.bstatic.com/images/hotel/max1280x900/606/60667759.jpg",
                                                    @"http://tu.07358.com/o_1beut7luqik8t631m5o1lct1sokj.jpg"]];
    }
    return _imageUrlStringArray;
}
- (NSMutableArray*)HouseImageViewArr
{
    if (!_HouseImageViewArr) {
        _HouseImageViewArr = [[NSMutableArray alloc] init];
        [_HouseImageViewArr addObjectsFromArray:@[@"test_1",@"test_2",@"test_3"]];
    }
    return _HouseImageViewArr;
}
#pragma mark - Eigth.Other

@end
