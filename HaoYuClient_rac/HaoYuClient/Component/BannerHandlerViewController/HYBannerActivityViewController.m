//
//  HYBannerActivityViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/11/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBannerActivityViewController.h"
#import <WebKit/WebKit.h>
#import "HYBaseBarButtonItem.h"
@interface HYBannerActivityViewController ()
@property (nonatomic, strong)  WKWebView * webView;

@end

@implementation HYBannerActivityViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.webView];
    [self addNavigator];
}
#pragma mark - Sixth.界面配置
- (void)addNavigator
{
    HYBaseBarButtonItem *leftItem = [HYBaseBarButtonItem backbarButtonItemWithCallBack:^(id sender) {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark - Seventh.懒加载
- (WKWebView*)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_web_url]];
        [_webView loadRequest:urlRequest];
        //开了支持滑动返回
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}
#pragma mark - Eigth.Other


@end
