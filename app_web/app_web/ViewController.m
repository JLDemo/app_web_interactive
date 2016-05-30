//
//  ViewController.m
//  app_web
//
//  Created by kfz on 16/5/26.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "ViewController.h"
#import "TabBar.h"

#define TABBAR_Height 40
#define URLString @"http://m.kongfz.com"  // https://neibumlogin.kongfz.com
#define CENTER @"http://muser.kongfz.com/mobile/index.html"
#define SHOP @"http://mshop.kongfz.com/mobile/shopcart/cart.html"
#define MSG @"http://mmessage.kongfz.com/"


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
    
    
    NSArray *cookies =[[NSUserDefaults standardUserDefaults]  objectForKey:@"abcdef"];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    if ([cookies count]) {
        [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
        [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
    }
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://muser.kongfz.com/index.php"]];
    [_webView loadRequest:request];  //loadRequest会自动带上设置的cookies！
    
    [self.view addSubview:_webView];
    
    [self loadRequest:URLString];
}

- (void)showCookie {
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookiesURL = [myCookie cookiesForURL:[NSURL URLWithString:@"http://muser.kongfz.com/index.php"]];
    NSLog(@"%@\n\n",cookiesURL);
}

-(void)saveSessID{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *nCookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookiesURL = [nCookies cookiesForURL:[NSURL URLWithString:@"http://muser.kongfz.com/index.php"]];
    
    for (id c in cookiesURL)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]])
        {
            cookie=(NSHTTPCookie *)c;
            if ([cookie.name isEqualToString:@"PHPSESSID"]) {
                
                NSNumber *sessionOnly = [NSNumber numberWithBool:cookie.sessionOnly];
                NSNumber *isSecure = [NSNumber numberWithBool:cookie.isSecure];
                NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure, nil];
                [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"abcdef"];
                break;
            }
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"%@\n\n\n",urlString);
    
//
    NSRange range = [request.URL.absoluteString rangeOfString:@"http://muser.kongfz.com/index.php"];
    if (range.location != NSNotFound) {
//        [self showCookie];
        [self saveSessID];
//        return NO;
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"%s",__func__);
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






















