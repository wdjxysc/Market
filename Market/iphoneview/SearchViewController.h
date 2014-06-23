//
//  SearchViewController.h
//  Market
//
//  Created by 夏 伟 on 14-6-10.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *dataArray;
@property int selectCellIndex;

@property(retain,nonatomic)NSObject<UIViewPassValueDelegate> *passValueDelegate;
@end
