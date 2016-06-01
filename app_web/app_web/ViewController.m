//
//  ViewController.m
//  app_web
//
//  Created by kfz on 16/5/26.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "ViewController.h"
#import "TabBar.h"
#import "CookieTool.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;
@property (weak, nonatomic) TabBar *tabBar;
@end

@implementation ViewController

- (UIWebView *)webView {
    if (!_webView) {
        CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
        CGSize scSize = self.view.frame.size;
        UIWebView *webView = [[UIWebView alloc] initWithFrame:(CGRect){{0, rect.size.height}, {scSize.width, scSize.height - rect.size.height - TABBAR_Height}}];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}
- (TabBar *)tabBar {
    if (!_tabBar) {
        TabBar *tabBar = [TabBar tabBar];
        CGSize scSize = self.view.frame.size;
        [self.view addSubview:tabBar];
        tabBar.frame = (CGRect){{0, scSize.height - TABBAR_Height}, {scSize.width, TABBAR_Height}};
        _tabBar = tabBar;
    }
    return _tabBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    
    [_webView loadRequest:request];  //loadRequest会自动带上设置的cookies！
    
    [self.view addSubview:_webView];
    
    [self loadRequest:URLString];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"%@\n\n",urlString);
    
//    if ( [urlString hasPrefix:LOGIN_OUT] ) {
//        [CookieTool logOut];
//    }
    
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *str1 = @"var footer = document.getElementsByClassName(\"footer\")[0];";
    NSString *str2 = @"footer.parentNode.removeChild(footer);";
//    NSString *str2 = @"alert(22);";
    [webView stringByEvaluatingJavaScriptFromString:str1];
    [webView stringByEvaluatingJavaScriptFromString:str2];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
//    NSLog(@"%s",__func__);
}



- (void)backClicked  {
    [self.webView goBack];
}
- (void)goForward  {
    [self.webView goForward];
}

- (void)shop {
    [self loadRequest:SHOP];
}

- (void)selfCenter {
    [self loadRequest:CENTER];
}

- (void)loadRequest:(NSString *)urlString {
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

@end






















