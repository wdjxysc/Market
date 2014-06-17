//
//  AppsViewController.h
//  Market
//
//  Created by 夏 伟 on 14-6-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppsViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *dataArray;

@end
