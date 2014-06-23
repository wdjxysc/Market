//
//  GoodsViewController.h
//  Market
//
//  Created by 夏 伟 on 14-6-11.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"
@interface GoodsViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *dataArray;
@property int nowMerchantType;
@property int selectCellIndex;

@property(retain,nonatomic)UIButton *taobaoBtn;
@property(retain,nonatomic)UIButton *jingdongBtn;
@property(retain,nonatomic)UIButton *aikangBtn;
@property(retain,nonatomic)UIButton *youjiBtn;
@property(retain,nonatomic)UIButton *bamashuiBtn;

@property(retain,nonatomic)NSObject<UIViewPassValueDelegate> *passValueDelegate;
@end
