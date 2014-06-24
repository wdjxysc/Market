//
//  AppsViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "AppsViewController.h"
#import "AppsTableViewCell.h"
#import "ServerConnect.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface AppsViewController ()

@end

@implementation AppsViewController

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
    // Do any additional setup after loading the view from its nib.
    //加载页面
    [self initMyView];
    //初始化dataarray
    _dataArray = [[NSMutableArray alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //从服务器获取app列表
        NSDictionary *dic = [ServerConnect getAppList:3 offset:0];
        if(dic)
        {
            _dataArray = [dic valueForKey:@"columns"];
        }
        
        if (dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
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
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f]];
    
    //本页标题背景图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 9, 16)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    UIButton *backButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 44)];
    [self.view addSubview:backButton1];
    [backButton1 addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    //搜索框背景图片
    UIImageView *searchbar_bg = [[UIImageView alloc]initWithFrame:CGRectMake(40, 23, 270, 38)];
    [searchbar_bg setImage:[UIImage imageNamed:@"searchbar_bg"]];
    
    //搜索图标
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+ searchbar_bg.frame.origin.x, 10 + searchbar_bg.frame.origin.y, 19, 19)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"searchbar_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    //搜索栏textfield
    UITextField *searchbar_textfield = [[UITextField alloc]initWithFrame:CGRectMake(40 + searchbar_bg.frame.origin.x, searchbar_bg.frame.origin.y, 190, 38)];
    [searchbar_textfield setPlaceholder:NSLocalizedString(@"SEARCH", @"搜索")];
    searchbar_textfield.delegate = self;
    //二维码图标
    UIButton *qrBtn = [[UIButton alloc] initWithFrame:CGRectMake(238+ searchbar_bg.frame.origin.x, 6 + searchbar_bg.frame.origin.y, 26, 26)];
    [qrBtn setBackgroundImage:[UIImage imageNamed:@"qr"] forState:UIControlStateNormal];
    [qrBtn addTarget:self action:@selector(qrBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchbar_bg];
    [self.view addSubview:qrBtn];
    [self.view addSubview:searchBtn];
    [self.view addSubview:searchbar_textfield];
    
    CGRect tableviewrect = CGRectMake(5, 69, 310, 370);
    if(iPhone5)
    {
        tableviewrect = CGRectMake(5, 69, 310, 370 + 85);
    }
    _tableView = [[UITableView alloc]initWithFrame:tableviewrect];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

-(void)backToMainViewController
{
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)qrBtnPressed
{
    NSLog(@"qrBtnPressed");
}




//@program tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *returncell = [[UITableViewCell alloc]init];
    AppsTableViewCell *cell = (AppsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.dataArray objectAtIndex:row];
    [cell.downloadBtn addTarget:self action:@selector(downloadBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.downloadBtn setTag:100 + row];
    cell.appdescriptionLabel.text = [rowData valueForKey:@"description"];
    cell.appnameLabel.text = [rowData valueForKey:@"title"];
    cell.appsizeLabel.text = [[NSString alloc] initWithFormat:@"%@次下载  %@",[rowData valueForKey:@"downloadNum"],[rowData valueForKey:@"fileSize"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"%@",[rowData valueForKey:@"imageName"]);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[rowData valueForKey:@"imageName"]]];//适用于加载在网页上的图片
//        NSData *data = [ServerConnect doSyncRequest:[rowData valueForKey:@"imageName"]];//用于下载图片
        UIImage *image = [UIImage imageWithData:data];
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.appiconImage.image = image;
            });
        }
        else {
            NSLog(@"-- impossible download");
        }
    });
    
    
    returncell = cell;
    returncell.selectionStyle = UITableViewCellSelectionStyleNone;
    return returncell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i = 0;
    
    i = [self.dataArray count];
    
    return i;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result = 110;
    return result;
}



-(IBAction)downloadBtnPressed:(id)sender
{
    NSString *urlStr = [[_dataArray objectAtIndex:[sender tag] - 100] valueForKey:@"fileName"];
//    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", @"873874226"];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/jing-dong-hd/id434374726?mt=8"]];
    //https://itunes.apple.com/cn/app/bei-tai-yun-jian-kang/id873874226?mt=8
    //https://itunes.apple.com/cn/app/ehealth-pro-e-jian-kang/id726122320?mt=8
}

-(void)searchBtnPressed
{
    //搜索app
}
@end
