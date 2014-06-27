//
//  BrowseHistoryViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-25.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "BrowseHistoryViewController.h"
#import "ServerConnect.h"
#import "MySingleton.h"

@interface BrowseHistoryViewController ()

@end

@implementation BrowseHistoryViewController

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //从服务器获取商品列表
        //        NSArray *array = [ServerConnect getProductList:@"" merchant_id:[[NSString alloc] initWithFormat:@"%d",_nowMerchantType]];
        NSDictionary *dic = [ServerConnect getHistoryScan:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"] number:100 date:nil];
        NSMutableArray *array;
        if([[dic valueForKey:@"RESULT_CODE"] isEqualToString:@"0"])
        {
            if([[[dic valueForKey:@"RESULT_INFO"] valueForKey:@"count"] intValue] >= 1)
            {
                array = [[dic valueForKey:@"RESULT_INFO"] valueForKey:@"historyInfo"];
            }
        }
        
        if(array && [array count]!=0)
        {
            _dataArray = array;
        }
        
        if (array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新ui
            });
        }
        else {
            NSLog(@"-- impossible download");
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f]];
    
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //本页标题图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
    
    //本页标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 220, 24)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"浏览记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIButton *backButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 44)];
    [self.view addSubview:backButton1];
    [backButton1 addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchUpInside];
}

-(void)backToMainViewController
{
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
