//
//  CheckoutWebViewVC.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/27.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "CheckoutWebViewVC.h"
#import <WebKit/WebKit.h>

@interface CheckoutWebViewVC ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation CheckoutWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:[FormatToString formatItem:self.htmlDocument] baseURL:nil];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
