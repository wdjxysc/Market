//
//  SearchViewController.m
//  Market
//
//  Created by 夏 伟 on 14-6-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "SearchViewController.h"
#import "GoodsDetailedTableViewCell.h"
#import "GoodsTableViewCell.h"
#import "ProductInfoViewController.h"
#import "ServerConnect.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width


@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = NSLocalizedString(@"SEARCH", nil);
//        self.tabBarItem.image = [UIImage imageNamed:@"tabitem_search"];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabitem_search_1"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem_search_0"]];
        
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
    _selectCellIndex = -1;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //从服务器获取商品列表
        NSArray *array = [ServerConnect getProductList:@"" merchant_id:@""];
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
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //本页标题背景图片
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [topImageView setImage:[UIImage imageNamed:@"navibar_bg"]];
    [self.view addSubview:topImageView];
    
    //搜索框背景图片
    UIImageView *searchbar_bg = [[UIImageView alloc]initWithFrame:CGRectMake(40, 23, 270, 38)];
    [searchbar_bg setImage:[UIImage imageNamed:@"searchbar_bg"]];
    
    //搜索图标
    UIImageView *searchbar_icon = [[UIImageView alloc] initWithFrame:CGRectMake(10+ searchbar_bg.frame.origin.x, 10 + searchbar_bg.frame.origin.y, 19, 19)];
    [searchbar_icon setImage:[UIImage imageNamed:@"searchbar_icon"]];
    
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
    [self.view addSubview:searchbar_icon];
    [self.view addSubview:searchbar_textfield];
    
    //商品列表
    CGRect tableviewrect = CGRectMake(5, 69, 310, 370);
    if(iPhone5)
    {
        tableviewrect = CGRectMake(5, 69, 310, 370 + 85);
    }
    _tableView = [[UITableView alloc]initWithFrame:tableviewrect];
    //    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)qrBtnPressed
{
    
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
    ProductInfoViewController *productInfoViewController = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
    self.passValueDelegate = productInfoViewController;//委托给productInfoViewController去实现其中的方法
    NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] initWithDictionary:[_dataArray objectAtIndex:[sender tag] - 100]];
    [valueDic setValue:[[NSString alloc] initWithFormat:@"%d",1] forKey:@"MERCHANT_ID"];
    [productInfoViewController passValue:valueDic];//productInfoViewController实现
    [self.navigationController pushViewController:productInfoViewController animated:YES];
}


@end
