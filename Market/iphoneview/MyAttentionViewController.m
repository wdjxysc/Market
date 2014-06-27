//
//  MyAttentionViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-23.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "GoodsTableViewCell.h"
#import "GoodsDetailedTableViewCell.h"
#import "ServerConnect.h"
#import "MySingleton.h"
//#import "ProductInfoViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface MyAttentionViewController ()

@end

@implementation MyAttentionViewController

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
    
    //初始化dataarray
    _dataArray = [[NSMutableArray alloc]init];
    _selectCellIndex = -1;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //从服务器获取商品列表
//        NSArray *array = [ServerConnect getProductList:@"" merchant_id:[[NSString alloc] initWithFormat:@"%d",_nowMerchantType]];
        NSArray *array = [ServerConnect queryProductAttention:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]];
        if(array && [array count]!=0)
        {
            _dataArray = [array[0] valueForKey:@"RESULT_INFO"];
        }
        
        if (array) {
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
    
    //本页标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 220, 24)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的关注";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 9, 16)];
    //    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    UIButton *backButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 44)];
    [self.view addSubview:backButton1];
    [backButton1 addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    
    //列表
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



//@program tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *returncell = [[UITableViewCell alloc]init];
    GoodsTableViewCell *cell;
    GoodsDetailedTableViewCell *detailedcell;
    NSLog(@"第%d行",[indexPath row]);
    
    if(indexPath.row != _selectCellIndex){
        cell = (GoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GoodsTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [self.dataArray objectAtIndex:row];
        [cell.linkBtn addTarget:self action:@selector(linkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.linkBtn setTag:100 + row];
        cell.productDescriptionLabel.text = [rowData valueForKey:@"PRODUCT_DESCRIPTION"];
        cell.productNameLabel.text = [rowData valueForKey:@"PRODUCT_NAME"];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[rowData valueForKey:@"PRODUCT_IMAGEURL"]]];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                [cell.imageProduct setImage:image];
                    [cell.linkBtn setBackgroundImage:image forState:UIControlStateNormal];
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
    else
    {
        detailedcell =(GoodsDetailedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if(detailedcell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GoodsDetailedTableViewCell" owner:self options:nil];
            detailedcell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [self.dataArray objectAtIndex:row];
        [detailedcell.linkBtn addTarget:self action:@selector(linkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [detailedcell.linkBtn setTag:100+row];
        detailedcell.productDescriptionLabel.text = [rowData valueForKey:@"PRODUCT_DESCRIPTION"];
        detailedcell.productNameLabel.text = [rowData valueForKey:@"PRODUCT_NAME"];
        detailedcell.detailedLabel.text = [rowData valueForKey:@"PRODUCT_DESCRIPTION"];
        detailedcell.detailedLabel.text = @"倍泰智能电子血压计ePa-46B4";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[rowData valueForKey:@"PRODUCT_IMAGEURL"]]];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                [cell.imageProduct setImage:image];
                    [detailedcell.linkBtn setBackgroundImage:image forState:UIControlStateNormal];
                });
            }
            else {
                NSLog(@"-- impossible download");
            }
        });
        
        returncell = detailedcell;
        returncell.selectionStyle = UITableViewCellSelectionStyleNone;
        return returncell;
    }
    
    
    
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
    if(indexPath.row == _selectCellIndex)
    {
        result = 540;
    }
    return result;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == _selectCellIndex)
    {
        _selectCellIndex = -1;
    }
    else{
        _selectCellIndex = indexPath.row;
    }
    [_tableView reloadData];
}

-(IBAction)linkBtnPressed:(id)sender
{
//    ProductInfoViewController *productInfoViewController = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
//    self.passValueDelegate = productInfoViewController;//委托给productInfoViewController去实现其中的方法
//    NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] initWithDictionary:[_dataArray objectAtIndex:[sender tag] - 100]];
//    [valueDic setValue:[[NSString alloc] initWithFormat:@"%d",_nowMerchantType] forKey:@"MERCHANT_ID"];
//    [productInfoViewController passValue:valueDic];//productInfoViewController实现
//    [self.navigationController pushViewController:productInfoViewController animated:YES];
}

-(void)passValue:(NSDictionary *)value
{
    _infodic = value;
}
@end
