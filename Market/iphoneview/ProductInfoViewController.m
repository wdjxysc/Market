//
//  ProductInfoViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-16.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "ProductInfoViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "MySingleton.h"
#import "ServerConnect.h"
#import "SVProgressHUD.h"

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
    
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
    [webView setOpaque:YES];
    [webView setScalesPageToFit:YES];
    [webView setDelegate:self];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[_productInfoDic valueForKey:@"MERCHANT_LINKURL"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];//链接网络地址
    
    //分享按钮
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(280, 31, 22, 18)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareBtn];
    
    //关注按钮
    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(240, 31, 22, 18)];
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"btn_collect"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collectBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:collectBtn];
    
}

-(void)backToMainViewController
{
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)shareBtnPressed
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容（新浪、腾讯、网易、搜狐、豆瓣、人人、开心、有道云笔记、facebook、twitter、邮件、打印、短信、微信、QQ、拷贝） "
                                       defaultContent:@"倍泰出品,你值得拥有！"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:[_productInfoDic valueForKey:@"MERCHANT_LINKURL"]
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

-(void)collectBtnPressed
{
    //关注商品
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //从服务器获取商品列表
        NSArray *result = [ServerConnect addProductAttention:[[_productInfoDic valueForKey:@"PRODUCT_ID"] intValue] merchant_id:1 authkey:@"dasd"];
        BOOL b;
        if(result.count != 0)
        {
            int res = [[result[0] valueForKey:@"RESULT_CODE"] intValue];
            if(res == 0)
            {
                b = false;
                NSLog(@"参数获取失败");
            }
            else if(res == 1)
            {
                b = true;
                NSLog(@"关注成功");
            }
            else if(res == 2)
            {
                b = false;
                NSLog(@"操作失败");
            }
            else if(res == 3)
            {
                b = false;
                NSLog(@"传入的authkey无效");
            }
            else
            {
                b = false;
                NSLog(@"关注失败");
            }
        }
        
        if (b) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            });
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"关注失败"];
        }
    });
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL b;
    return b;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [SVProgressHUD showWithStatus:@"加载中"];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
}


@end
