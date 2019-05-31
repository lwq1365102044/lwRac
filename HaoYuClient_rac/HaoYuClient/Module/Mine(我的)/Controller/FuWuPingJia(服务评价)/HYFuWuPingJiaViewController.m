//
//  HYFuWuPingJiaViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYFuWuPingJiaViewController.h"
#import "HYFuWuPingJiaMainView.h"

@interface HYFuWuPingJiaViewController ()
@property (nonatomic, strong) HYFuWuPingJiaMainView * fuwupingjiaView;
@property (nonatomic, strong) NSString * houseItemId;
@property (nonatomic, strong) id  extend;
@end

@implementation HYFuWuPingJiaViewController


#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件
- (void)getPara
{
    PARA_CREART;
    NSString *encode = [self.fuwupingjiaView.textView.TextView.text ex_base64Encode];
    PARA_SET([encode isNullToString], @"remark");
    if (!self.fuwupingjiaView.scoreView.score1 ||
        !self.fuwupingjiaView.scoreView.score2 ||
        !self.fuwupingjiaView.scoreView.score3 ||
        !self.fuwupingjiaView.scoreView.score4 ||
        !self.fuwupingjiaView.scoreView.score5) {
        ALERT(@"请选择服务评价");
        return;
    }
    
    PARA_SET([self.fuwupingjiaView.scoreView.score1 isNullToString], @"serviceAttitude");
    PARA_SET([self.fuwupingjiaView.scoreView.score2 isNullToString], @"processingSpeed");
    PARA_SET([self.fuwupingjiaView.scoreView.score3 isNullToString], @"hardwareFacilities");
    PARA_SET([self.fuwupingjiaView.scoreView.score4 isNullToString], @"environmentalHygiene");
    PARA_SET([self.fuwupingjiaView.scoreView.score5 isNullToString], @"safetyManagement");
    
    [self postRequest:para];
}

/**
 提交数据
 */
- (void)postRequest:(NSMutableDictionary *)param
{
    [param setValue:[USERDEFAULTS_GET(USER_INFOR_USERID) isNullToString] forKey:@"userId"];
    [param setValue:[_houseItemId isNullToString] forKey:@"houseItemId"];
    LWLog(@"\n\n\n\nparam:%@",param);
    [[HYServiceManager share] postRequestAnWithurl:FUPINGJIA_INFOR_URL
                                         paramters:param
                                      successBlock:^(id objc, id requestInfo) {
                                          if ([objc[@"status"][@"code"] isEqualToString:@"200"]) {
                                              ALERT(@"提交成功!");
                                              if ([_extend isEqualToString:@"100"]) {
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                  if (self.submitBlock) {
                                                      self.submitBlock();
                                                  }
                                              }else{
                                              [self.navigationController popViewControllerAnimated:YES];
                                              }
                                          }
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
+ (instancetype)creatFuWuPingJiaViewControllerWithhouseItemId:(NSString *)houseItemId
                                                       extend:(id)extend
{
    HYFuWuPingJiaViewController *instance = [[HYFuWuPingJiaViewController alloc] init];
    instance.houseItemId = houseItemId;
    instance.extend = extend;
    return  instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务评价";
    
    [self setUI];
    WEAKSELF(self);
    [self.fuwupingjiaView.commitLable bk_whenTapped:^{
        [weakself getPara];
    }];
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.MainScrollView addSubview:self.fuwupingjiaView];
    [self.view addSubview:self.MainScrollView];
    [self.fuwupingjiaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(SCREEN_WIDTH);
        make.left.right.bottom.mas_equalTo(self.MainScrollView);
        make.top.mas_equalTo(self.MainScrollView.mas_top);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
}

#pragma mark - Seventh.懒加载
- (HYFuWuPingJiaMainView*)fuwupingjiaView
{
    if (!_fuwupingjiaView) {
        _fuwupingjiaView = [[HYFuWuPingJiaMainView alloc] init];
        _fuwupingjiaView.backgroundColor = HYCOLOR.color_c1;
    }
    return _fuwupingjiaView;
}
#pragma mark - Eigth.Other


@end
