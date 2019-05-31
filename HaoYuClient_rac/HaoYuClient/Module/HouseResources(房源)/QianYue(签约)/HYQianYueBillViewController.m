//
//  HYQianYueBillViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYQianYueBillViewController.h"
#import "HYQianYueBillModel.h"
#import "HYBaseBarButtonItem.h"
#import "HYHouseProjectInforTool.h"
#import "HYQianYueBillListTableViewCell.h"
@interface HYQianYueBillViewController ()
@property (nonatomic, strong) HYBaseView * bottomView;
@property (nonatomic, strong) HYDefaultButton * leftBtn;
@property (nonatomic, strong) HYDefaultButton * rightBtn;

@property (nonatomic, strong) HYBaseViewController * sourceVC;
@property (nonatomic, strong) id extend;
@property (nonatomic, strong) NSDictionary * param;
@end

@implementation HYQianYueBillViewController

+ (instancetype)qianYuBillViewControllerFromSoucrVC:(HYBaseViewController *)sourceVC
                                              param:(NSDictionary *)param
                                             extend:(id)extend
{
    HYQianYueBillViewController *instance  = [[HYQianYueBillViewController alloc] init];
    instance.sourceVC       = sourceVC;
    instance.extend         = extend;
    instance.param          = param;
    return instance;
}

- (void)setDataArrayModel:(NSMutableArray *)dataArrayModel
{
    for (HYQianYueBillModel *billM in dataArrayModel) {
        if ([billM.type integerValue] == 1) {
            [self.dataMutableArray addObject:billM];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"请确认账单";
    [self setUI];
    [self setNaviItem];
}

- (void)clickBottomBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"上一步"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"确认"]){
        [[HYHouseProjectInforTool new] QianYueCreateHeTong:self.param
                                             callBackBlock:^(id sender) {
                                                 LWLog(@"-----\n生成合同信息：%@",sender);
                                                 ALERT(@"恭喜您，签约成功！");
                                                 if ([self.sourceVC isKindOfClass:NSClassFromString(@"HYMineYuDingViewController")]) {
                                                     [self.sourceVC requestListInfor];
                                                 }
                                                 [self.navigationController popToViewController:self.sourceVC animated:YES];
                                             }];
    }
}

- (void)setNaviItem
{
    HYBaseBarButtonItem *backItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        NSArray *VCs = self.navigationController.viewControllers;
        [self.navigationController popToViewController:VCs[VCs.count - 2] animated:YES];
    }];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataMutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYQianYueBillListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BILL_CELL" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HYQianYueBillListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BILL_CELL"];
    }
    HYQianYueBillModel *billModel = self.dataMutableArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.billModel = billModel;
    return cell;
}

- (void)setUI
{
    [self.view addSubview:self.MainTableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(MARGIN*5);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-MARGIN*0);
    }];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    [self.MainTableView registerClass:[HYQianYueBillListTableViewCell class] forCellReuseIdentifier:@"BILL_CELL"];
    self.MainTableView.mj_header = nil;
    self.MainTableView.rowHeight = UITableViewAutomaticDimension;
    self.MainTableView.estimatedRowHeight = MARGIN *11.5;
    self.MainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (HYBaseView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HYBaseView alloc] init];
        
        _leftBtn = [HYDefaultButton buttonWithTitleStringKey:@"上一步"
                                                  titleColor:HYCOLOR.color_c4
                                                   titleFont:SYSTEM_REGULARFONT(15)
                                                      target:self
                                                    selector:@selector(clickBottomBtn:)];
        _rightBtn = [HYDefaultButton buttonWithTitleStringKey:@"确认"
                                                   titleColor:HYCOLOR.color_c4
                                                    titleFont:SYSTEM_REGULARFONT(15)
                                                       target:self
                                                     selector:@selector(clickBottomBtn:)];
        [_bottomView addSubview:_leftBtn];
        [_bottomView addSubview:_rightBtn];
        [_leftBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        [_rightBtn setBoundWidth:1 cornerRadius:4 boardColor:HYCOLOR.color_c3];
        
        [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(MARGIN*3);
            make.width.mas_offset((SCREEN_WIDTH-MARGIN*6)/2);
            make.left.mas_equalTo(_bottomView.mas_left).mas_offset(MARGIN*2);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(MARGIN*3);
            make.width.mas_equalTo(_leftBtn.mas_width);
            make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-MARGIN*2);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
        }];
    }
    return _bottomView;
}

- (NSDictionary*)param
{
    if (!_param) {
        _param = [[NSDictionary alloc] init];
    }
    return _param;
}
@end
