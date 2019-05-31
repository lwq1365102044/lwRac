//
//  HYHouseRescourcesViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesViewController.h"
#import "HYHouseRescourcesListTableViewCell.h"
#import "HYHouseRescourceDeatilViewController.h"
#import "HYHouseTopView.h"
#define  HOUSERESCOURCESLISTCELLIDNTIFIER @"HOUSERESCOURCESLISTCELLIDNTIFIER"

@interface HYHouseRescourcesViewController ()
@property (nonatomic, strong) HYHouseTopView * topView;

@end

@implementation HYHouseRescourcesViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

- (void)requestListInfor
{
    PARA_CREART;
    PARA_SET(@"", @"preStayTime");
    PARA_SET(@"", @"maxPrice");
    PARA_SET(@"", @"minPrice");
    PARA_SET(@"", @"cityId");
    [[HYServiceManager share] postRequestAnWithurl:HOUSE_LIST_INFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYHouseRescourcesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    if(!cell){
        cell = [[HYHouseRescourcesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOUSERESCOURCESLISTCELLIDNTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.clickBlock = ^(id sender) {
        HYHouseRescourceDeatilViewController *deatilVC = [[HYHouseRescourceDeatilViewController alloc] init];
        deatilVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:deatilVC animated:YES];
    };
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公寓";
    [self setUI];
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.MainTableView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(NAVIGATOR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(MARGIN*4);
    }];
    [self.MainTableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    self.MainTableView.rowHeight = ADJUST_PERCENT_FLOAT(220);
    self.MainTableView.mj_header = nil;
}

- (HYHouseTopView*)topView
{
    if (!_topView) {
        _topView = [[HYHouseTopView alloc] init];
    }
    return _topView;
}
@end
