//
//  UserViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "UserViewController.h"
#import "MySingleton.h"

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
    
    [self initMyView];
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
    
    //本页标题图片以及logo图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
    
    //本页标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 220, 24)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的商城";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //用户
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 130)];
    userBgImageView.image = [UIImage imageNamed:@"user_bg"];
    UIImageView *userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 94, 70, 70)];
    userHeadImageView.image = [UIImage imageNamed:@"userhead"];
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 109, 160, 20)];
    usernameLabel.text = [[NSString alloc] initWithFormat:@"用户名：%@",[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"]];
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 129, 160, 20)];
    passwordLabel.text = [[NSString alloc] initWithFormat:@"密码：******"];
    [self.view addSubview:userBgImageView];
    [self.view addSubview:userHeadImageView];
    [self.view addSubview:usernameLabel];
    [self.view addSubview:passwordLabel];
    
    
    //选项
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, 320, 1)];
    line1.image = [UIImage imageNamed:@"longline"];
    [self.view addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, 320, 1)];
    line2.image = [UIImage imageNamed:@"longline"];
    [self.view addSubview:line2];
//    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 290, 320, 1)];
//    line3.image = [UIImage imageNamed:@"longline"];
//    [self.view addSubview:line3];
    
    UIImageView *xiangBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, 320, 40)];
    xiangBg1.image = [UIImage imageNamed:@"input_bg"];
    UILabel *xiangLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 320, 20)];
    xiangLabel1.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    xiangLabel1.text = @"订单查询";
    UIImageView *arrow1 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 222, 9, 16)];
    [arrow1 setImage:[UIImage imageNamed:@"arrow_right"]];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 210, 320, 40)];
    [button1 addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangBg1];
    [self.view addSubview:xiangLabel1];
    [self.view addSubview:arrow1];
    [self.view addSubview:button1];
    
    UIImageView *xiangBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, 320, 40)];
    xiangBg2.image = [UIImage imageNamed:@"input_bg"];
    UILabel *xiangLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 320, 20)];
    xiangLabel2.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    xiangLabel2.text = @"优惠券";
    UIImageView *arrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 262, 9, 16)];
    [arrow2 setImage:[UIImage imageNamed:@"arrow_right"]];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, 320, 40)];
    [button2 addTarget:self action:@selector(couponsBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangBg2];
    [self.view addSubview:xiangLabel2];
    [self.view addSubview:arrow2];
    [self.view addSubview:button2];
    
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 305, 320, 1)];
    line4.image = [UIImage imageNamed:@"longline"];
    [self.view addSubview:line4];
    UIImageView *line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 345, 320, 1)];
    line5.image = [UIImage imageNamed:@"longline"];
    [self.view addSubview:line5];
    UIImageView *line6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 385, 320, 1)];
    line6.image = [UIImage imageNamed:@"longline"];
    [self.view addSubview:line6];
//    UIImageView *line7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 425, 320, 1)];
//    line7.image = [UIImage imageNamed:@"longline"];
//    [self.view addSubview:line7];
    
    UIImageView *xiangBg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 305, 320, 40)];
    xiangBg3.image = [UIImage imageNamed:@"input_bg"];
    UILabel *xiangLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 315, 200, 20)];
    xiangLabel3.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    xiangLabel3.text = @"我的关注";
    UIImageView *arrow3 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 317, 9, 16)];
    [arrow3 setImage:[UIImage imageNamed:@"arrow_right"]];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 305, 320, 40)];
    [button3 addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangBg3];
    [self.view addSubview:xiangLabel3];
    [self.view addSubview:arrow3];
    [self.view addSubview:button3];
    
    UIImageView *xiangBg4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 345, 320, 40)];
    xiangBg4.image = [UIImage imageNamed:@"input_bg"];
    UILabel *xiangLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 355, 320, 20)];
    xiangLabel4.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    xiangLabel4.text = @"我的消息";
    UIImageView *arrow4 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 357, 9, 16)];
    [arrow4 setImage:[UIImage imageNamed:@"arrow_right"]];
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 345, 320, 40)];
    [button4 addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangBg4];
    [self.view addSubview:xiangLabel4];
    [self.view addSubview:arrow4];
    [self.view addSubview:button4];
    
    UIImageView *xiangBg5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 385, 320, 40)];
    xiangBg5.image = [UIImage imageNamed:@"input_bg"];
    UILabel *xiangLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 395, 320, 20)];
    xiangLabel5.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
    xiangLabel5.text = @"浏览记录";
    UIImageView *arrow5 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 397, 9, 16)];
    [arrow5 setImage:[UIImage imageNamed:@"arrow_right"]];
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 385, 320, 40)];
    [button5 addTarget:self action:@selector(orderBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangBg5];
    [self.view addSubview:xiangLabel5];
    [self.view addSubview:arrow5];
    [self.view addSubview:button5];
}

-(void)orderBtnPressed
{
    
}

-(void)couponsBtnPressed
{
    
}
@end
