//
//  AppDelegate.h
//  Market
//
//  Created by 夏 伟 on 14-6-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "LoginViewControllerTM.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) LoginViewControllerTM *loginViewControllerTM;

@end
