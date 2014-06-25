//
//  LoginViewController.m
//  HealthABC
//
//  Created by 夏 伟 on 13-11-21.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "LoginViewControllerTM.h"
#import "MySingleton.h"
#import "ServerConnect.h"
#import "SVProgressHUD.h"
#import "RegistEmailViewControllerTM.h"
#import "ChangPasswordViewController.h"
#import "MainViewController.h"
#import "SearchViewController.h"
#import "UserViewController.h"
#import "PostViewController.h"

//#import "APService.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface LoginViewControllerTM ()
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;

@end

@implementation LoginViewControllerTM

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //添加单击手势，隐藏软键盘
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(View_TouchDown:)];
        tapGr.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGr];
    }
    return self;
}

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [MySingleton sharedSingleton].serverDomain = @"www.ebelter.com"; //设置服务器地址
    [self initApp];
    [self initMyView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
    
    [textField resignFirstResponder];
}

-(IBAction)DidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
}

//滑动  textfield 不让软键盘盖住
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 80; // tweak as needed
    //    int mo = textField.bounds.origin.y;
    //    int mi = textField.bounds.size.height;
    //    int me = textField.frame.origin.y;
    
    int screenheight = self.view.frame.size.height;
    int tobottom = screenheight - textField.frame.origin.y - textField.frame.size.height;
    movementDistance = 300-tobottom + 10;
    const float movementDuration = 0.3f; // tweak as needed
    
    if(movementDistance>0){
        
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        
        [UIView setAnimationBeginsFromCurrentState: YES];
        
        [UIView setAnimationDuration: movementDuration];
        
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        
        [UIView commitAnimations];
    }
}

-(IBAction)LoginBtnPressed:(id)sender
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"PLEASE_WAITTING", nil)];
    loginBtn.enabled = false;
    _registBtn.enabled = false;
    _forgetPassword.enabled = false;
    
    NSThread* myThread1 = [[NSThread alloc] initWithTarget:self selector:@selector(login)object:nil];
    [myThread1 start];
    
}

//极光推送设置别名标签回调
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

-(void)login
{
    NSString *username = usernameLoginTextField.text;
    NSString *password = passwordLoginTextField.text;
    NSString *urlLogin = [[NSString alloc]initWithFormat:@"http://test.ebelter.com/service/ehealth_userLogin?username=%@&pwd=%@&dtype=18",username,password];
    
    NSString *res = [ServerConnect Login:urlLogin];
    if([res isEqualToString:@"0"])
    {
        //登陆成功
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"LOGIN_SUCCESS", nil)];
        [[MySingleton sharedSingleton].nowuserinfo setValue:username forKey:@"UserName"];
        
        loginBtn.enabled = true;
        //跳转界面
        [self showMainView];
        
        
//        [self presentViewController:_tabBarController animated:NO completion:^{//备注2
//            NSLog(@"show InfoView!");
//            loginBtn.enabled = true;
//        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"LOGIN_FAILED", nil)];
    }
    
    loginBtn.enabled = true;
    _registBtn.enabled = true;
    _forgetPassword.enabled = true;
}


-(IBAction)goregistBtnPressed:(id)sender
{
    if (iPhone5) {
        RegistEmailViewControllerTM *registEmailViewControllerTM = [[RegistEmailViewControllerTM alloc]initWithNibName:@"RegistEmailViewControllerTM_4Inch" bundle:nil];
        //    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:registEmailViewControllerTM];
        [self presentViewController:registEmailViewControllerTM animated:YES completion:nil];
    }
    else
    {
        RegistEmailViewControllerTM *registEmailViewControllerTM = [[RegistEmailViewControllerTM alloc]initWithNibName:@"RegistEmailViewControllerTM" bundle:nil];
        //    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:registEmailViewControllerTM];
        [self presentViewController:registEmailViewControllerTM animated:YES completion:nil];
    }
}

-(IBAction)fogetBtnPressed:(id)sender
{
        ChangPasswordViewController *changPasswordViewController = [[ChangPasswordViewController alloc]initWithNibName:@"ChangPasswordViewController" bundle:nil];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:changPasswordViewController];
        [self presentViewController:navi animated:YES completion:nil];
}

-(IBAction)testBtnPressed:(id)sender
{
    NSString *urlLogin = [[NSString alloc]initWithFormat:@"http://www.ebelter.com/service/ehealth_userLogin?username=%@&pwd=%@&dtype=30",@"15817407047",@"123456"];
    
    NSString *res = [ServerConnect Login:urlLogin];
    if([res isEqualToString:@"0"])  //登陆成功
    {
        //获取用户信息
        NSString *urlGetUserInfo = [[NSString alloc]initWithFormat:@"http://www.ebelter.com/service/ehealth_getUserInfo?authkey=%@&time=2013-11-26 15:53:30",[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]];
        
        NSDictionary *dic = [ServerConnect getUserInfo:urlGetUserInfo];
        NSLog(@"dic = %@",dic);
    }
    else  //登陆失败
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:res delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}

-(void)initMyView
{
    [loginBtn setTitle:NSLocalizedString(@"LOGIN", nil) forState:UIControlStateNormal];
    
    usernameLoginTextField.placeholder = NSLocalizedString(@"PLEASE_INPUT_ACCOUNT", nil);
    passwordLoginTextField.placeholder = NSLocalizedString(@"PLEASE_INPUT_PASSWORD", nil);
    
    [_registBtn setTitle:NSLocalizedString(@"REGIST", nil) forState:UIControlStateNormal];
    [_forgetPassword setTitle:NSLocalizedString(@"FOGET_PASSWORD", nil) forState:UIControlStateNormal]; /*@"忘记密码"*/
    [_registBtn setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateHighlighted];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateHighlighted];
    
    //    [loginBtn setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    //
    //    usernameLoginTextField.placeholder = NSLocalizedString(@"请输入账号(邮箱)", nil);
    //    passwordLoginTextField.placeholder = NSLocalizedString(@"请输入密码", nil);
    //
    //    [_registBtn setTitle:NSLocalizedString(@"没有账号？立即注册", nil) forState:UIControlStateNormal];
    //    [_forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
@end
