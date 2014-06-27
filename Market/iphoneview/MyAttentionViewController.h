//
//  MyAttentionViewController.h
//  Market
//
//  Created by 夏 伟 on 14-6-23.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface MyAttentionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIViewPassValueDelegate>

@property(retain,nonatomic) UITableView *tableView;

@property int selectCellIndex;

@property(retain,nonatomic) NSMutableArray *dataArray;

@property(retain,nonatomic) NSDictionary *infodic;

@property(retain,nonatomic)NSObject<UIViewPassValueDelegate> *passValueDelegate;
@end
