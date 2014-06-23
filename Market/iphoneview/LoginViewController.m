//
//  LoginViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "SearchViewController.h"
#import "UserViewController.h"
#import "PostViewController.h"
#import "MySingleton.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMyView];
    [self initApp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)initMyView
{
    [_loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)loginBtnPressed
{
    [self showMainView];
}

-(void)showMainView
{
    MainViewController *mainViewController = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    SearchViewController *searchViewController = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    UserViewController *userViewController = [[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
    PostViewController *postViewController = [[PostViewController alloc]initWithNibName:@"PostViewController" bundle:nil];
    
    UINavigationController *mainViewNaviController = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    [mainViewNaviController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar_bg"] forBarMetrics:UIBarMetricsDefault];
    [mainViewNaviController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             UITextAttributeTextColor,[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0],
                             UITextAttributeFont,nil]];
    mainViewNaviController.navigationBarHidden = YES;
    
    //        [measureViewController.navigationItem.leftBarButtonItem setBackgroundImage:@"History" forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    mainViewNaviController.navigationBar.tintColor = [UIColor whiteColor];
    
    UINavigationController *searchViewNaviController = [[UINavigationController alloc]initWithRootViewController:searchViewController];
    [searchViewNaviController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar_bg"] forBarMetrics:UIBarMetricsDefault];
    [searchViewNaviController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             UITextAttributeTextColor,
                             [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             UITextAttributeTextShadowColor,
                             [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             UITextAttributeTextShadowOffset,
                             [UIFont fontWithName:@"Arial-Bold" size:0.0],
                             UITextAttributeFont,nil]];
    searchViewNaviController.navigationBarHidden = YES;
    
    //        [measureViewController.navigationItem.leftBarButtonItem setBackgroundImage:@"History" forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    searchViewNaviController.navigationBar.tintColor = [UIColor whiteColor];
    
    UINavigationController *userViewNaviController = [[UINavigationController alloc]initWithRootViewController:userViewController];
    [userViewNaviController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar_bg"] forBarMetrics:UIBarMetricsDefault];
    [userViewNaviController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             UITextAttributeTextColor,[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0],
                             UITextAttributeFont,nil]];
    userViewNaviController.navigationBarHidden = YES;
    //        [measureViewController.navigationItem.leftBarButtonItem setBackgroundImage:@"History" forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    userViewNaviController.navigationBar.tintColor = [UIColor whiteColor];
    
    UINavigationController *postViewNaviController = [[UINavigationController alloc]initWithRootViewController:postViewController];
    [postViewNaviController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibar_bg"] forBarMetrics:UIBarMetricsDefault];
    [postViewNaviController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             UITextAttributeTextColor,[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0],
                             UITextAttributeFont,nil]];
    postViewNaviController.navigationBarHidden = YES;
    //        [measureViewController.navigationItem.leftBarButtonItem setBackgroundImage:@"History" forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    postViewNaviController.navigationBar.tintColor = [UIColor whiteColor];
    
    //在首页navigation上添加logo图片
    CGFloat topLogoImageViewy=34.0;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        topLogoImageViewy = 34.0;
    }
    else if([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
        topLogoImageViewy = 14.0;
    }
    UIImageView *topLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_width-143)/2, topLogoImageViewy, 143.0, 16.0)];
    [topLogoImageView setImage:[UIImage imageNamed:@"logo"]];
//    [mainViewNaviController.view addSubview:topLogoImageView];
    
    
    //tabbar
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[[NSArray alloc] initWithObjects:mainViewNaviController,searchViewNaviController,userViewNaviController,postViewNaviController, nil]];
//    [tabBarController setViewControllers:[[NSArray alloc] initWithObjects:mainViewController,searchViewController,userViewController,postViewController, nil]];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    tabBarController.tabBar.backgroundColor = [UIColor clearColor];
    tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tabitem_down_bg"];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
//    [tabBarController.tabBar setTintColor:[UIColor redColor]];
    
    
    
    [self presentViewController:tabBarController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
}


-(void)initApp
{
    [MySingleton sharedSingleton].serverDomain = @"www.ebelter.com"; //设置服务器地址
    [MySingleton sharedSingleton].nowuserinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                 [[NSString alloc] initWithFormat:@""],@"Userid",
                                                 [[NSString alloc] initWithFormat:@"1"],@"UserNumber",
                                                 [[NSString alloc] initWithFormat:@"guest"],@"UserName",
                                                 [[NSString alloc] initWithFormat:@"123456"],@"PassWord",
                                                 [[NSString alloc] initWithFormat:@"65.0"],@"Weight",
                                                 [[NSString alloc] initWithFormat:@"1992-05-12"],@"Birthday",
                                                 [[NSString alloc] initWithFormat:@"0"],@"Gender",
                                                 [[NSString alloc] initWithFormat:@"172"],@"Height",
                                                 [[NSString alloc] initWithFormat:@"0"],@"Profession",
                                                 [[NSString alloc] initWithFormat:@""],@"AuthKey",
                                                 [[NSString alloc] initWithFormat:@"32"],@"Age",
                                                 [[NSString alloc] initWithFormat:@"75"],@"StepSize",
                                                 [[NSString alloc] initWithFormat:@"0"],@"LengthUnit",
                                                 [[NSString alloc] initWithFormat:@"0"],@"WeightUnit",
                                                 nil];
    
    NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
}

@end
