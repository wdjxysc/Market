//
//  GoodsDetailedTableViewCell.h
//  Market
//
//  Created by 夏 伟 on 14-6-20.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailedTableViewCell : UITableViewCell
{
    IBOutlet UIButton *linkBtn;
    IBOutlet UILabel *productDescriptionLabel;
    IBOutlet UILabel *productNameLabel;
    IBOutlet UILabel *detailedLabel;
}
@property(retain,nonatomic)UIButton *linkBtn;
@property(retain,nonatomic)UILabel *productDescriptionLabel;
@property(retain,nonatomic)UILabel *productNameLabel;
@property(retain,nonatomic)UILabel *detailedLabel;
@end
