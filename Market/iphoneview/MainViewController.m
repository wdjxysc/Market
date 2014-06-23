//
//  MainViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "MainViewController.h"
#import "AppsViewController.h"
#import "GoodsViewController.h"


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = NSLocalizedString(@"MAINPAGE", nil);
//        self.tabBarItem.image = [UIImage imageNamed:@"tabitem_home"];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabitem_home_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem_home_0"]];
        
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
        [self.navigationController.view addSubview:topLogoImageView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //本页标题图片以及logo图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
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
    [self.view addSubview:topLogoImageView];
    
    
    //图片展示scrollView
    NSMutableArray *images = [[NSMutableArray alloc]initWithObjects:
                              [UIImage imageNamed:@"image_1"],
                              [UIImage imageNamed:@"image_1"],
                              [UIImage imageNamed:@"image_1"],nil];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 190)];
//    scrollView.alwaysBounceHorizontal = NO;//滑到边缘是否反弹
//    scrollView.alwaysBounceVertical = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = true;
    scrollView.bounces = NO;//滑到边缘是否反弹
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320*images.count, 190);
    for(int i = 0; i < images.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        [imageView setImage:images[i]];
        [scrollView addSubview:imageView];
    }
    
    //应用中心btn
    CGRect appCenterBtnRect = CGRectMake(5, 259, 310, 120);
    if(!iPhone5)
    {
        appCenterBtnRect = CGRectMake(5, 259, 310, 80);
    }
    UIButton *appCenterBtn = [[UIButton alloc]initWithFrame:appCenterBtnRect];
    [appCenterBtn setBackgroundImage:[UIImage imageNamed:@"appbtn_bg"] forState:UIControlStateNormal];
    [appCenterBtn setBackgroundImage:[UIImage imageNamed:@"appbtn_down_bg"] forState:UIControlStateHighlighted];
    
    [appCenterBtn setImage:[UIImage imageNamed:@"appbtn_icon"] forState:UIControlStateNormal];
    [appCenterBtn setTitle:@"         应用中心         " forState:UIControlStateNormal];
    [appCenterBtn addTarget:self action:@selector(appCenterBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appCenterBtn];
    
    //商品中心btn
    CGRect goodsCenterBtnRect = CGRectMake(5, 384, 310, 120);
    if(!iPhone5)
    {
        goodsCenterBtnRect = CGRectMake(5, 344, 310, 80);
    }
    UIButton *goodsCenterBtn = [[UIButton alloc]initWithFrame:goodsCenterBtnRect];
    [goodsCenterBtn setBackgroundImage:[UIImage imageNamed:@"goodsbtn_bg"] forState:UIControlStateNormal];
    [goodsCenterBtn setBackgroundImage:[UIImage imageNamed:@"goodsbtn_down_bg"] forState:UIControlStateHighlighted];
    
    [goodsCenterBtn setImage:[UIImage imageNamed:@"goodsbtn_icon"] forState:UIControlStateNormal];
    [goodsCenterBtn setTitle:@"         商品中心         " forState:UIControlStateNormal];
    [goodsCenterBtn addTarget:self action:@selector(goodsCenterBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goodsCenterBtn];
}

-(void)appCenterBtnPressed
{
    //进入appCenter界面
    AppsViewController *appsViewController = [[AppsViewController alloc]initWithNibName:@"AppsViewController" bundle:nil];
    [self.navigationController pushViewController:appsViewController animated:YES];
//    [self presentViewController:appsViewController animated:YES completion:^{
//        
//    }];
}

-(void)goodsCenterBtnPressed
{
    //进入goodsCenter界面
    GoodsViewController *goodsViewController = [[GoodsViewController alloc]initWithNibName:@"GoodsViewController" bundle:nil];
    [self.navigationController pushViewController:goodsViewController animated:YES];
}
@end
