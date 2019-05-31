//
//  HYBaseWebViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "LWHud.h"
@interface HYBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)WKWebView * webview;

@end

@implementation HYBaseWebViewController


#pragma mark - First.通知

#pragma mark - Second.网络请求

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
/**
 签约协议  1
 预订协议  2
 */
- (void)setWebUrlWithType:(NSInteger)type
{
    NSString *url ;
    if (type == 1) {
        url = [NSString stringWithFormat:@"%@%@",BASE_XIYI_URL,QIANYU_XIEYI_URL];
    }else if (type == 2){
        self.navigationItem.title = @"预订协议";
        url = [NSString stringWithFormat:@"%@%@",BASE_XIYI_URL,YUDING_XIEYI_URL];
    }
    
    if (!url) {
        return;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:10];
    [self.webview loadRequest:request];
    //页面背景色
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [LWHud show];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [LWHud dismiss];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [LWHud dismiss];
    ALERT(@"加载失败");
    LWLog(@"++++++error:%@",error);
}
#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.webview.backgroundColor = HYCOLOR.color_c1;
}
#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载
- (WKWebView *)webview
{
    if (!_webview) {
        _webview = [[WKWebView alloc] init];
        _webview.navigationDelegate = self;
    }
    return _webview;
}
#pragma mark - Eigth.Other


@end