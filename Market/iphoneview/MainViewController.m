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
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 180)];
//    scrollView.alwaysBounceHorizontal = NO;//滑到边缘是否反弹
//    scrollView.alwaysBounceVertical = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = true;
    scrollView.bounces = NO;//滑到边缘是否反弹
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320*images.count, scrollView.frame.size.height);
    _scrollView = scrollView;
    for(int i = 0; i < images.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        [imageView setImage:images[i]];
        [scrollView addSubview:imageView];
    }
    //scrollView 下方显示页数3按钮
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(84, 238, 12, 12)];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"dot_select"] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn1 setTitle:@"1" forState:UIControlStateNormal];
    [_btn1.titleLabel setFont:[UIFont systemFontOfSize:8]];
    [self.view addSubview:_btn1];
    [self myViewScale:_btn1 sx:1.5 sy:1.5 duration:0.5];
    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(154, 238, 12, 12)];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_btn2 setTitle:@"2" forState:UIControlStateNormal];
    [_btn2.titleLabel setFont:[UIFont systemFontOfSize:8]];
    [self.view addSubview:_btn2];
    _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(224, 238, 12, 12)];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_btn3 setTitle:@"3" forState:UIControlStateNormal];
    [_btn3.titleLabel setFont:[UIFont systemFontOfSize:8]];
    [self.view addSubview:_btn3];
    
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


-(void)myViewScale : (UIView *)view sx:(float)sx sy:(float)sy duration:(float)duration
{
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGAffineTransform newTransform = CGAffineTransformMakeScale(sx, sy);
                         [view setTransform:newTransform];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                         
                     }];
}

#pragma mark -
/*
 // 返回一个放大或者缩小的视图
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
 
 }
 // 开始放大或者缩小
 - (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:
 (UIView *)view
 {
 
 }
 
 // 缩放结束时
 - (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
 {
 
 }
 
 // 视图已经放大或缩小
 - (void)scrollViewDidZoom:(UIScrollView *)scrollView
 {
 NSLog(@"scrollViewDidScrollToTop");
 }
 */

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    NSLog(@"scrollViewDidEndDecelerating");
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    switch (page) {
        case 0:
            [self myViewScale:_btn1 sx:1 sy:1 duration:0.2];
            break;
        case 1:
            [self myViewScale:_btn2 sx:1 sy:1 duration:0.2];
            break;
        case 2:
            [self myViewScale:_btn3 sx:1 sy:1 duration:0.2];
            break;
        default:
            break;
    }

}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    switch (page) {
        case 0:
            [_btn1 setBackgroundImage:[UIImage imageNamed:@"dot_select"] forState:UIControlStateNormal];
            _btn1.titleLabel.textColor = [UIColor whiteColor];
            [_btn2 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn2.titleLabel.textColor = [UIColor purpleColor];
            [_btn3 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn3.titleLabel.textColor = [UIColor purpleColor];
            
            [self myViewScale:_btn1 sx:1.5 sy:1.5 duration:0.2];
            break;
        case 1:
            [_btn1 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn1.titleLabel.textColor = [UIColor purpleColor];
            [_btn2 setBackgroundImage:[UIImage imageNamed:@"dot_select"] forState:UIControlStateNormal];
            _btn2.titleLabel.textColor = [UIColor whiteColor];
            [_btn3 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn3.titleLabel.textColor = [UIColor purpleColor];
            
            [self myViewScale:_btn2 sx:1.5 sy:1.5 duration:0.2];
            break;
        case 2:
            
            [_btn1 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn1.titleLabel.textColor = [UIColor purpleColor];
            [_btn2 setBackgroundImage:[UIImage imageNamed:@"dot_normal"] forState:UIControlStateNormal];
            _btn2.titleLabel.textColor = [UIColor purpleColor];
            [_btn3 setBackgroundImage:[UIImage imageNamed:@"dot_select"] forState:UIControlStateNormal];
            _btn3.titleLabel.textColor = [UIColor whiteColor];
            
            [self myViewScale:_btn3 sx:1.5 sy:1.5 duration:0.2];
            break;
        default:
            break;
    }
}

@end
