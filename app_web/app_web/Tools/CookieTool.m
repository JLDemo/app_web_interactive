//
//  CookieTool.m
//  app_web
//
//  Created by kfz on 16/5/30.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "CookieTool.h"

@implementation CookieTool

+ (void)initialize {
    if (self == [CookieTool self]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cookieChanged) name:NSHTTPCookieManagerCookiesChangedNotification object:nil];
    }
}
+ (void)cookieChanged {
    [self updateAllCookie];
//    NSLog(@"\n\n%s",__func__);
//    NSArray *cookieNameArray = [[NSUserDefaults standardUserDefaults] objectForKey:COOKIE_ARRAY];
//    NSLog(@"%@",cookieNameArray);\
    
}

+ (void)getAllCookie {
    NSArray *cookieNameArray = [[NSUserDefaults standardUserDefaults] objectForKey:COOKIE_ARRAY];
    for (NSString *cookieName in cookieNameArray) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:cookieName];
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dic];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

/**
 * 清除所有缓存的cookie
 */
+ (void)logOut {
    NSArray *cookieNameArray = [[NSUserDefaults standardUserDefaults] objectForKey:COOKIE_ARRAY];
    for (NSString *name in cookieNameArray) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:name];
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:COOKIE_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)updateAllCookie {
//    [self logOut];
    
    NSMutableArray *cookieArray = [NSMutableArray array];
    NSArray <NSHTTPCookie *>*cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies ) {
        [cookieArray addObject:cookie.name];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        // name value domain path version expiredDate
        [dic setObject:cookie.name forKey:NSHTTPCookieName];
        [dic setObject:cookie.value forKey:NSHTTPCookieValue];
        [dic setObject:cookie.domain forKey:NSHTTPCookieDomain];
        [dic setObject:cookie.path forKey:NSHTTPCookiePath];
        [dic setObject:@(cookie.version) forKey:NSHTTPCookieVersion];
        NSDate *expireDate = [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * COOKIE_EXPIRE_DAY];
        [dic setObject:expireDate forKey:NSHTTPCookieExpires];
        
        [[NSUserDefaults standardUserDefaults] setValue:dic forKey:cookie.name];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[NSUserDefaults standardUserDefaults] setValue:cookieArray forKey:COOKIE_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/*
+ (void)getCookie {
    NSArray *cookies =[[NSUserDefaults standardUserDefaults]  objectForKey:SESSION_LOGIN];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    if ([cookies count]) {
        [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
        [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
    }
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
}

+ (void)saveCookie {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *nCookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookiesURL = [nCookies cookiesForURL:[NSURL URLWithString:LOGIN]];
    
    for (id c in cookiesURL)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]])
        {
            cookie=(NSHTTPCookie *)c;
            if ([cookie.name isEqualToString:@"PHPSESSID"]) {
                
                NSNumber *sessionOnly = [NSNumber numberWithBool:cookie.sessionOnly];
                NSNumber *isSecure = [NSNumber numberWithBool:cookie.isSecure];
                NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure, nil];
                [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:SESSION_LOGIN];
                break;
            }
        }
    }
}
*/

@end



















