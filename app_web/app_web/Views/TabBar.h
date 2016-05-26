//
//  TabBar.h
//  app_web
//
//  Created by kfz on 16/5/26.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"



@interface TabBar : UIView

@property (weak, nonatomic) ViewController *delegate;

+ (instancetype)tabBar;

@end
