//
//  HYHuXingView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHuXingView.h"
#import "HYHouseDeatilHuXingCollectionViewCell.h"
#define  HUXINGCOLLECTIDENTIFIER  @"HUXINGCOLLECTIDENTIFIER"

@interface HYHuXingView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) HYBaseCollectionView * HuXingCollectView;
@end
@implementation HYHuXingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HYCOLOR.color_c3;
        HYDefaultLabel *titleLable = [HYDefaultLabel labelWithFont:SYSTEM_MEDIUMFONT(15)
                                                              text:@"户型"
                                                         textColor:HYCOLOR.color_c4];
        _moreLable = [HYDefaultLabel labelWithFont:SYSTEM_REGULARFONT(15)
                                                              text:@"更多"
                                                         textColor:HYCOLOR.color_c4];
        _moreLable.userInteractionEnabled = YES;
        _moreLable.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:line];
        [self addSubview:titleLable];
        [self addSubview:_moreLable];
        [self addSubview:self.HuXingCollectView];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.left.top.mas_equalTo(self).mas_offset(MARGIN);
            make.height.mas_offset(ADJUST_PERCENT_FLOAT(25));
        }];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_offset(MARGIN);
            make.centerY.mas_equalTo(line.mas_centerY);
        }];
        [_moreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.centerY.mas_equalTo(titleLable.mas_centerY);
            make.size.mas_offset(CGSizeMake(MARGIN*7, MARGIN*3));
        }];
        [self.HuXingCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(MARGIN*2);
            make.left.mas_equalTo(self.mas_left).mas_offset(MARGIN);
            make.right.mas_equalTo(self.mas_right).mas_offset(-MARGIN);
            make.height.mas_offset(MARGIN*14);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-MARGIN);
        }];
        
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYHouseDeatilHuXingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HUXINGCOLLECTIDENTIFIER forIndexPath:indexPath];
    cell.houseItemImageView.image = IMAGENAME(@"11");
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickCellBlock) {
        self.clickCellBlock(indexPath);
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (HYBaseCollectionView*)HuXingCollectView
{
    if (!_HuXingCollectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ADJUST_PERCENT_FLOAT(300), ADJUST_PERCENT_FLOAT(120));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _HuXingCollectView = [[HYBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _HuXingCollectView.delegate = self;
        _HuXingCollectView.dataSource = self;
        [_HuXingCollectView registerClass:[HYHouseDeatilHuXingCollectionViewCell class] forCellWithReuseIdentifier:HUXINGCOLLECTIDENTIFIER];
        _HuXingCollectView.showsHorizontalScrollIndicator = NO;
//        _HuXingCollectView.pagingEnabled = YES;
    }
    return _HuXingCollectView;
}

@end
