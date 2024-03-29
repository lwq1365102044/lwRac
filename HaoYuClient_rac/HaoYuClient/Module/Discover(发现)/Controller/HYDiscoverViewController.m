//
//  HYDiscoverViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/21.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYDiscoverViewController.h"
#import "ViewController.h"
#import "HYPayMentManager.h"
#import "HYDiscoverSecondViewController.h"
#import <WebKit/WebKit.h>
#import "HYMoneyTextFiled.h"
#import "UIControl+LWdelay.h"

#define DISCOVER_MAIN_URLS  @"192.168.1.222/wechatApps/weixin/homeCenter/find.html"

//#define DISCOVER_MAIN_URLS  @"mp.weixin.qq.com/mp/homepage?__biz=MzU1NjU4NjgyOA==&hid=1&sn=1946efb80af26d6e8d8c2f0fea9b7987&scene=18#wechat_redirect"
@interface HYDiscoverViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) NSURLRequest * request;

@end

@implementation HYDiscoverViewController
/**
 
 https://mp.weixin.qq.com/s/lHuDAnkqHhpm_5zz-CaGHQ
 
 http://mp.weixin.qq.com/s?__biz=MzU1NjU4NjgyOA==&mid=100000018&idx=1&sn=70e4c6cc4ac18d1794cd62125368cc17&scene=19#wechat_redirect
 
 http://mp.weixin.qq.com/mp/homepage?__biz=MzU1NjU4NjgyOA==&hid=1&sn=1946efb80af26d6e8d8c2f0fea9b7987&scene=18#wechat_redirect
 */

#pragma mark - First.通知

#pragma mark - Second.网络请求
- (void)requestListInfor
{
    if (_request) {
        [self.webView loadRequest:_request];
    }
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSString *webUrl = [NSString stringWithFormat:@"%@",webView.URL];
    if (![webUrl containsString:DISCOVER_MAIN_URLS]) {
        HYDiscoverSecondViewController *secondvc = [[HYDiscoverSecondViewController alloc] init];
        secondvc.nextUrls = webUrl;
        secondvc.gotoBackBlock = ^(id sender) {
            [self.webView goBack];
        };
        [self.navigationController pushViewController:secondvc animated:YES];
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.webView.scrollView.mj_header endRefreshing];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.webView.scrollView.mj_header endRefreshing];
    ALERT(@"加载失败");
    LWLog(@"++++++error:%@",error);
}

// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSString *webUrl = [NSString stringWithFormat:@"%@",webView.URL];
    if (![webUrl containsString:DISCOVER_MAIN_URLS]) {
        HYDiscoverSecondViewController *secondvc = [[HYDiscoverSecondViewController alloc] init];
        secondvc.nextUrls = webUrl;
        secondvc.gotoBackBlock = ^(id sender) {
            [self.webView goBack];
        };
        [self.navigationController pushViewController:secondvc animated:YES];
    }
}

#pragma mark - Fifth.视图生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.webView.scrollView.mj_header endRefreshing];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_webView goBack];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [self.view addSubview:self.webView];
 
    self.webView.scrollView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestListInfor)];
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (WKWebView *)webView
{
    if (!_webView) {
        NSString *urls = [NSString stringWithFormat:@"https://%@",DISCOVER_MAIN_URLS];
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HIEGHT)];
        _request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
        [self.webView loadRequest:_request];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        //开了支持滑动返回
        self.webView.allowsBackForwardNavigationGestures = YES;        
    }
    return _webView;
}
#pragma mark - Eigth.Other


@end
