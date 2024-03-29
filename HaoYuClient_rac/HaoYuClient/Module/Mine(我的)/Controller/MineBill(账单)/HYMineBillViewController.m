//
//  HYMineBillViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYMineBillViewController.h"
#import "HYNoPayBillViewController.h"
#import "HYHistoryBillViewController.h"
#import "HYTopBarView.h"
@interface HYMineBillViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HYNoPayBillViewController * NoPayBillVC;
@property (nonatomic, strong) HYHistoryBillViewController * HistoryBillVC;
@property (nonatomic, strong) HYTopBarView * topBarView;
/**
 合同
 */
@property (nonatomic, strong) HYContractModel * contractModel;

@end

@implementation HYMineBillViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset_x = scrollView.contentOffset.x;
    NSInteger index =  offset_x / SCREEN_WIDTH;
    [self.topBarView selectIndex:index];
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账单";
    self.topBarView = [HYTopBarView creatTopBarWithDataArr:@[@"待缴账单",@"历史账单"] selectColor:[UIColor redColor] callBack:^(NSInteger index) {
        [self.MainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    }];
    [self.view addSubview:self.topBarView];
    self.topBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADJUST_PERCENT_FLOAT(45));
    [self addMainScrollView];
    [self addChildVC];
}
+ (instancetype)creatBillViewController:(HYContractModel *)contractModel
{
    HYMineBillViewController *temp = [[HYMineBillViewController alloc] init];
    temp.contractModel = contractModel;
    return  temp;
}

#pragma mark - Sixth.界面配置
- (void)addMainScrollView
{
    [self.view addSubview:self.MainScrollView];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.MainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 1);
    self.MainScrollView.bounces = YES;
    self.MainScrollView.pagingEnabled = YES;
    self.MainScrollView.showsHorizontalScrollIndicator = NO;
    self.MainScrollView.delegate = self;
}

- (void)addChildVC
{
    HYHistoryBillViewController *HistoryBillVC = [[HYHistoryBillViewController alloc]init];
    HYNoPayBillViewController *NoPayBillVC = [[HYNoPayBillViewController alloc] init];
    NoPayBillVC.contractModel = _contractModel;
    HistoryBillVC.contractModel = _contractModel;
    NoPayBillVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    HistoryBillVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.MainScrollView addSubview:NoPayBillVC.view];
    [self.MainScrollView addSubview:HistoryBillVC.view];
    [self addChildViewController:HistoryBillVC];
    [self addChildViewController:NoPayBillVC];
}

#pragma mark - Seventh.懒加载

#pragma mark - Eigth.Other

@end
