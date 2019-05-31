//
//  HYHouseRescourceDeatiMainView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourceDeatiMainView.h"
#import "HYTopInforView.h"
#import "HYJiChuSheShiView.h"
#import "HYHuXingView.h"
#import "HYZhouBianView.h"

@interface HYHouseRescourceDeatiMainView ()
@property (nonatomic, strong) HYBaseView * imageBgView;
@property (nonatomic, strong) HYTopInforView * topInforView;
@property (nonatomic, strong) HYJiChuSheShiView * jichusheshiView;
@property (nonatomic, strong) HYHuXingView * huxingView;
@property (nonatomic, strong) HYZhouBianView * zhoubianView;

/**
 点击的户型
 */
@property (nonatomic, strong) NSIndexPath * selectIndexpath;

@end
@implementation HYHouseRescourceDeatiMainView

- (void)setDataModel:(HYHouseRescourcesModel *)dataModel
{
    _topInforView.titileLable.text = dataModel.hiItemName;
    _topInforView.baozhangLable.text = @"保障：100%真实房源";
    _topInforView.yongjinLable.text = @"佣金：100%免佣金";
    
    _contactUsView.kefuPhoneLable.text = [NSString stringWithFormat: @"客服电话：%@",dataModel.mendianPhone];
    _contactUsView.addressLable.text  = dataModel.hiDetailedAddress;
    
    NSMutableArray *tem_arr = [[NSMutableArray alloc] init];
    for (sheshiArrModel *sheshi_M in dataModel.sheshiArrModel) {
        if ([sheshi_M.isHave isEqualToString:@"1"]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[@"image"] = dict[@"title"] = sheshi_M.name;
            [tem_arr addObject:dict];
        }
    }
    _jichusheshiView.jiugonggeView.dataArr = tem_arr;
    _huxingView.dataArray = dataModel.roomTypeArrModel;
    
    _huxingView.hidden = NO;
    if (dataModel.roomTypeArrModel.count == 0) {
        _huxingView.hidden = YES;
        [_zhoubianView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_jichusheshiView.mas_bottom).mas_offset(MARGIN);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
    }
    
//    [_zhoubianView.zhoubianDescLable setAttributedStringWithContentArray:@[@{@"color" : HYCOLOR.color_c4,
//                                                                             @"content" : dataModel.hiZhoubianDesc ?dataModel.hiZhoubianDesc :@"",
//                                                                             @"size" : SYSTEM_REGULARFONT(13),
//                                                                             @"lineSpacing": @5},]];
//    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dataModel.hiZhoubianDesc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _zhoubianView.zhoubianDescLable.attributedText = attrStr;
    
    [_contactUsView setMyLocationCoordinateWithlat:[dataModel.lat doubleValue] lng:[dataModel.lng doubleValue]];
}

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
    _statusImageView = [[UIImageView alloc] init];
    _statusImageView.image = IMAGENAME(@"choujianzhong_icon");
    _statusImageView.hidden = YES;
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
    [self addSubview:_statusImageView];
    [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(MARGIN*15, MARGIN*10));
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN*3);
        make.top.mas_equalTo(_imageBgView.mas_bottom).mas_offset(-MARGIN*5);
    }];
    [_imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
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
    }];
    [_huxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_jichusheshiView.mas_bottom).mas_offset(MARGIN);
        make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
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
            weakself.clickHuxingBlock(weakself.selectIndexpath.row + 1);
        }
    };
    [_huxingView.moreLable bk_whenTapped:^{
        if (self.clickHuxingBlock) {
            self.clickHuxingBlock(0);
        }
    }];
}

- (HYBaseView*)imageBgView
{
    if (!_imageBgView) {
        _imageBgView = [[HYBaseView alloc] init];
        HYPictureCarouselView *ImageScrollView = [HYPictureCarouselView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(200)) shouldInfiniteLoop:YES imageNamesGroup:nil];
        ImageScrollView.pageDotImage = IMAGENAME(@"占位图-750_400");
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
