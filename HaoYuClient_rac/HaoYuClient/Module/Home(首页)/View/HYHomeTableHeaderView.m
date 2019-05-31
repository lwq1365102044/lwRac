//
//  HYHomeTableHeaderView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/12.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHomeTableHeaderView.h"
#import "HYJiuGongGeView.h"
@interface HYHomeTableHeaderView ()
@property (nonatomic, strong) HYBaseView * imageBgView;
@property (nonatomic, strong) UIImageView * searchImageView;
@property (nonatomic, strong) HYBaseView * itemBgView;
@end

@implementation HYHomeTableHeaderView

- (void)setBannderModelArray:(NSArray *)bannderModelArray
{
    _bannderModelArray = bannderModelArray;
    NSMutableArray *pic_Mut = [[NSMutableArray alloc] init];
    for (HYHomeBannnerModel *model in bannderModelArray) {
        if(model.picUrl) [pic_Mut addObject:model.picUrl];
    }
    self.ImageScrollView.imageURLStringsGroup = pic_Mut;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _searchImageView = [[UIImageView alloc] init];
    [self addSubview:self.imageBgView];
    [self addSubview:self.itemBgView];
    [self addSubview:_searchImageView];
    [self bringSubviewToFront:_searchImageView];
    _searchImageView.backgroundColor = [UIColor greenColor];
    
    [_imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(MARGIN*20);
        make.left.right.top.mas_equalTo(self);
    }];
    [_searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(MARGIN*5, MARGIN*5));
        make.bottom.mas_equalTo(_imageBgView.mas_bottom).mas_offset(MARGIN*1.5);
        make.right.mas_equalTo(_imageBgView.mas_right).mas_offset(-MARGIN*2.5);
    }];
    [_itemBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_imageBgView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-1);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HYCOLOR.color_c6;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0.5);
        make.left.right.bottom.mas_equalTo(self);
    }];
    _searchImageView.userInteractionEnabled = YES;
    [_searchImageView bk_whenTapped:^{
        if (self.clickFuncBtnBlcok) {
            self.clickFuncBtnBlcok(@"搜索");
        }
    }];
    _searchImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _searchImageView.layer.shadowOffset = CGSizeMake(4, 4);
    _searchImageView.layer.shadowOpacity = .5;
    
    _searchImageView.hidden = YES;
}

- (HYBaseView*)itemBgView
{
    if (!_itemBgView) {
        _itemBgView = [[HYBaseView alloc] init];
        _itemBgView.backgroundColor = [UIColor whiteColor];
        HYJiuGongGeView *jiugonggeOtherView = [[HYJiuGongGeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- MARGIN*2, 0)];
        jiugonggeOtherView.ColS = 5;
        [_itemBgView addSubview:jiugonggeOtherView];
        NSArray * dataArr = @[@{@"title":@"地图找房",@"image":@"mapFindHouse"},
                              @{@"title":@"预约看房",@"image":@"onLineYueYu"},
                              @{@"title":@"预定房源",@"image":@"onLineYuDing"},
                              @{@"title":@"在线签约",@"image":@"onLineQianYue"},
                              @{@"title":@"京东百货",@"image":@"suppermarket"},];
        jiugonggeOtherView.dataArr = dataArr;
        [jiugonggeOtherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_itemBgView.mas_top);
            make.left.mas_equalTo(_itemBgView.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(_itemBgView.mas_right).mas_offset(-MARGIN);
        }];
        jiugonggeOtherView.callBlock = ^(id sender) {
            if (self.clickFuncBtnBlcok) {
                self.clickFuncBtnBlcok(sender);
            }
        };
    }
    return _itemBgView;
}

- (HYBaseView*)imageBgView
{
    if (!_imageBgView) {
        _imageBgView = [[HYBaseView alloc] init];
        HYPictureCarouselView *ImageScrollView = [HYPictureCarouselView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(200)) shouldInfiniteLoop:YES imageNamesGroup:nil];
        ImageScrollView.placeholderImage = IMAGENAME(@"占位图-750_400");
        ImageScrollView.showPageControl = YES;
        ImageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [_imageBgView addSubview:ImageScrollView];
        _ImageScrollView = ImageScrollView;
        [ImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_imageBgView);
        }];
    }
    return _imageBgView;
}
@end
