//
//  AppDelegate.m
//  app_web
//
//  Created by kfz on 16/5/26.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RedViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIWindow *normalWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *vc = [[ViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    /*
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.origin.x = 100;
    rect.origin.y = 100;
    self.normalWindow = [[UIWindow alloc] initWithFrame:rect];
    self.normalWindow.rootViewController = [[RedViewController alloc] init];
    self.normalWindow.backgroundColor = [UIColor redColor];
    self.normalWindow.windowLevel = UIWindowLevelNormal;
    [self.normalWindow makeKeyAndVisible];
    */
    //存储Cookie,示例加载的URL:http://119.29.69.58:81/index
    NSURL * cookieHost = [NSURL URLWithString:@"http://muser.kongfz.com/index.php"];
    NSHTTPCookie * cookie = [NSHTTPCookie cookieWithProperties:
                             [NSDictionary    dictionaryWithObjectsAndKeys:
                              [cookieHost host],NSHTTPCookieDomain,
                              [cookieHost path],NSHTTPCookiePath,
                              @"COOKIE_NAME",NSHTTPCookieName,
                              @"COOKIE_VALUE",NSHTTPCookieValue,nil]];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if (url) {
        // 模拟器 Safari输入链接：kongfz：//  即可打开应用
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"web" message:url.absoluteString delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    return YES;
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
//    
//    return YES;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
