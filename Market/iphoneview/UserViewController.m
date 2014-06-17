//
//  UserViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = NSLocalizedString(@"USERCENTER", nil);
//        self.tabBarItem.image = [UIImage imageNamed:@"tabitem_user"];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabitem_user_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem_user_0"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
