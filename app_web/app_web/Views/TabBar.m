//
//  TabBar.m
//  app_web
//
//  Created by kfz on 16/5/26.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "TabBar.h"

@interface TabBar ()




@end

@implementation TabBar

- (IBAction)backClicked:(id)sender {
    [self.delegate backClicked];
}
- (IBAction)goForward:(id)sender {
    [self.delegate goForward];
}
- (IBAction)shop:(id)sender {
    [self.delegate shop];
}

- (IBAction)selfCenter:(id)sender {
    [self.delegate selfCenter];
}
+ (instancetype)tabBar {
    TabBar *bar = [[[NSBundle mainBundle] loadNibNamed:@"TabBar" owner:nil options:nil] lastObject];
    return bar;
}











@end

















