//
//  ProductInfoViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-16.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "ProductInfoViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface ProductInfoViewController ()

@end

@implementation ProductInfoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)passValue:(NSDictionary *)value
{
    _productInfoDic = value;
}

-(void)initMyView
{
    //
    //初始化界面
    //
    [self.view setBackgroundColor:[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f]];
    
    //本页标题背景图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 9, 16)];
    //    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    CGRect webViewRect = CGRectMake(0, 64, 320, 367);
    if(iPhone5){
        webViewRect = CGRectMake(0, 64, 320, 367 + 88);
    }
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewRect];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[_productInfoDic valueForKey:@"MERCHANT_LINKURL"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];//链接网络地址
}

-(void)backToMainViewController
{
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
