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
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(getUserLatelyData) object:nil];
    [thread start];
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
    NSString *urlLogin = [[NSString alloc]initWithFormat:@"http://www.ebelter.com/service/ehealth_userLogin?username=%@&pwd=%@&dtype=18",username,password];
    
    NSString *res = [ServerConnect Login:urlLogin];
    if([res isEqualToString:@"0"])
    {
        //登陆成功
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"LOGIN_SUCCESS", nil)];
        //        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:username forKey:@"UserName"];
        
//        //极光推送设置别名
//        [APService setTags:[NSSet setWithObjects:@"wangdj",@"tag5",@"tag6",nil] alias:@"username" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
        
        
        
        [self presentViewController:_tabBarController animated:NO completion:^{//备注2
            NSLog(@"show InfoView!");
            loginBtn.enabled = true;
        }];
    }
    else
    {
        //        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"LOGIN_FAILED", nil)];
    }
    
    loginBtn.enabled = true;
    _registBtn.enabled = true;
    _forgetPassword.enabled = true;
}

-(void)getUserLatelyData
{
    
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
    [_registBtn setBackgroundImage:[UIImage imageNamed:@"TM_按钮按下"] forState:UIControlStateHighlighted];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"TM_按钮按下"] forState:UIControlStateHighlighted];
    
    //    [loginBtn setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    //
    //    usernameLoginTextField.placeholder = NSLocalizedString(@"请输入账号(邮箱)", nil);
    //    passwordLoginTextField.placeholder = NSLocalizedString(@"请输入密码", nil);
    //
    //    [_registBtn setTitle:NSLocalizedString(@"没有账号？立即注册", nil) forState:UIControlStateNormal];
    //    [_forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    
}


-(void)initApp
{
    [MySingleton sharedSingleton].serverDomain = @"www.ebelter.com"; //设置服务器地址
    [MySingleton sharedSingleton].nowuserinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                 [[NSString alloc] initWithFormat:@""],@"Userid",
                                                 [[NSString alloc] initWithFormat:@""],@"UserNumber",
                                                 [[NSString alloc] initWithFormat:@""],@"UserName",
                                                 [[NSString alloc] initWithFormat:@""],@"PassWord",
                                                 [[NSString alloc] initWithFormat:@"65.0"],@"Weight",
                                                 [[NSString alloc] initWithFormat:@"1992-05-12"],@"Birthday",
                                                 [[NSString alloc] initWithFormat:@"0"],@"Gender",
                                                 [[NSString alloc] initWithFormat:@"172"],@"Height",
                                                 [[NSString alloc] initWithFormat:@"0"],@"Profession",
                                                 [[NSString alloc] initWithFormat:@""],@"AuthKey",
                                                 [[NSString alloc] initWithFormat:@"32"],@"Age",
                                                 [[NSString alloc] initWithFormat:@"75"],@"StepSize",
                                                 nil];
    
    NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
}
@end
