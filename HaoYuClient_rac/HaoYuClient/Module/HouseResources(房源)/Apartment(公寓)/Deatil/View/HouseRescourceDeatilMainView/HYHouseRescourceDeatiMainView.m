//
//  HYHouseRescourceDeatiMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourceDeatiMainView.h"
#import "HYTopInforView.h"
#import "HYContactUsView.h"
#import "HYJiChuSheShiView.h"
#import "HYHuXingView.h"
#import "HYZhouBianView.h"

@interface HYHouseRescourceDeatiMainView ()
@property (nonatomic, strong) HYBaseView * imageBgView;
@property (nonatomic, strong) HYTopInforView * topInforView;
@property (nonatomic, strong) HYContactUsView * contactUsView;
@property (nonatomic, strong) HYJiChuSheShiView * jichusheshiView;
@property (nonatomic, strong) HYHuXingView * huxingView;
@property (nonatomic, strong) HYZhouBianView * zhoubianView;
/**
 点击的户型
 */
@property (nonatomic, strong) NSIndexPath * selectIndexpath;

@end
@implementation HYHouseRescourceDeatiMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HYCOLOR.color_c1;
        [self setSubUI];
    }
    return self;
}

- (void)setSubUI
{
    _topInforView = [[HYTopInforView alloc] init];
    _contactUsView = [[HYContactUsView alloc] init];
    _jichusheshiView = [[HYJiChuSheShiView alloc] init];
    _huxingView = [[HYHuXingView alloc] init];
    _zhoubianView = [[HYZhouBianView alloc] init];
    [self addSubview:_topInforView];
    [self addSubview:_contactUsView];
    [self addSubview:self.imageBgView];
    [self addSubview:_jichusheshiView];
    [self addSubview:_huxingView];
    [self addSubview:_zhoubianView];
    [_imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).mas_offset(NAVIGATOR_HEIGHT);
        make.height.mas_offset(MARGIN*20);
    }];
    [_topInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageBgView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_contactUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topInforView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
    }];
    [_jichusheshiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contactUsView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        //        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    [_huxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_jichusheshiView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        //        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    [_zhoubianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_huxingView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
    }];
    [_topInforView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_contactUsView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_jichusheshiView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_huxingView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    [_zhoubianView setBoundWidth:0.5 cornerRadius:6 boardColor:HYCOLOR.color_c6];
    WEAKSELF(self);
    self.huxingView.clickCellBlock = ^(id sender) {
        weakself.selectIndexpath = (NSIndexPath *)sender;
        if (weakself.clickHuxingBlock) {
            weakself.clickHuxingBlock(_selectIndexpath.row + 1);
        }
    };
    [_huxingView.moreLable bk_whenTapped:^{
        if (self.clickHuxingBlock) {
            self.clickHuxingBlock(0);
        }
    }];
    [self setTestData];
}

- (void)setTestData
{
    _topInforView.titileLable.text = @"北京牡丹园店";
    _topInforView.baozhangLable.text = @"保障“100%真实房源";
    _topInforView.yongjinLable.text = @"佣金：100%免佣金";
    
    _contactUsView.kefuPhoneLable.text = @"客服电话：18801040890";
    _contactUsView.addressLable.text  = @"北京市海淀区牡丹园";
    NSArray * dataArr = @[@{@"title":@"账单",@"image":@"mine_bill_n"},
                          @{@"title":@"合同",@"image":@"mine_hetong_n"},
                          @{@"title":@"保修",@"image":@"mine_baoxiu_n"},
                          @{@"title":@"保洁",@"image":@"mine_baojie_n"},
                          @{@"title":@"水表",@"image":@"mine_shuibiao_n"},
                          @{@"title":@"电表",@"image":@"mine_dianbiao_n"},
                          @{@"title":@"智能门锁",@"image":@"mine_mensuo_n"},
                          @{@"title":@"缴费",@"image":@"mine_pay_n"},
                          @{@"title":@"我的预约",@"image":@"mine_yuyue_n"},
                          @{@"title":@"我的预定",@"image":@"mine_yuding_n"},
                          @{@"title":@"我的优惠券",@"image":@"mine_youhuiquan_n"},
                          @{@"title":@"我的活动",@"image":@"mine_huodong_n"},
                          @{@"title":@"我的收藏",@"image":@"mine_collection_n"},
                          @{@"title":@"我的积分",@"image":@"mine_jifen_n"},];
    _jichusheshiView.jiugonggeView.dataArr = dataArr;
    NSArray * dataArr1 = @[
                           @{@"title":@"交通周边",@"image":@"mine_bill_n",@"content":@"王夫人对黛玉可没有那么多的宠爱，所以她必然会为宝玉打算。而黛玉入门，就算不让她去管家，病怏怏的几乎很难为贾家开枝散叶。就这一点来看，只要贾母准备指婚，第一个不答应的必然是王夫人。而如果嫁了进来，不讨婆婆喜欢，受苦的还是黛玉。"},
                           @{@"title":@"娱乐周边",@"image":@"mine_bill_n",@"content":@"王夫人对黛玉可没有那么多的宠爱，所以她必然会为宝玉打算。而黛玉入门，就算不让她去管家，病怏怏的几乎很难为贾家开枝散叶。就这一点来看，只要贾母准备指婚，第一个不答应的必然是王夫人。而如果嫁了进来，不讨婆婆喜欢，受苦的还是黛玉。贾母舍不得黛玉受苦，外加那么一点点替贾家考虑的私心，所以她没有提这件事。此后薛姨妈到，她和王夫人是姐妹，那些个私底下打的小算盘，"},
                           @{@"title":@"医疗保障",@"image":@"mine_bill_n",@"content":@"王夫人对黛玉可没有那么多的宠爱，所以她必然会为宝玉打算。而黛玉入门，就算不让她去管家，病怏怏的几乎很难为贾家开枝散叶。就这一点来看，只要贾母准备指婚，第一个不答应的必然是王夫人。而如果嫁了进来，不讨婆婆喜欢，受苦的还是黛玉。"},
                           ];
    _zhoubianView.dataArray = dataArr1;;
}

- (HYBaseView*)imageBgView
{
    if (!_imageBgView) {
        _imageBgView = [[HYBaseView   alloc] init];
        NSArray *ads = @[@"http://www.lanjing-lijia.com/ljshops/images/upload/2017-01/Image/1484014020.jpg",
                         @"http://r-cc.bstatic.com/images/hotel/max1280x900/606/60667759.jpg",
                         @"http://tu.07358.com/o_1beut7luqik8t631m5o1lct1sokj.jpg"];
        HYPictureCarouselView *ImageScrollView = [HYPictureCarouselView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(120)) shouldInfiniteLoop:YES imageNamesGroup:ads];
        [_imageBgView addSubview:ImageScrollView];
        _ImageScrollView = ImageScrollView;
        ImageScrollView.showPageControl = NO;
        [ImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_imageBgView);
        }];
    }
    return _imageBgView;
}
@end
