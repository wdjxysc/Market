//
//  AppsTableViewCell.h
//  Market
//
//  Created by 夏 伟 on 14-6-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppsTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *appiconImage;
    IBOutlet UILabel *appnameLabel;
    IBOutlet UILabel *appsizeLabel;
    IBOutlet UILabel *appdescriptionLabel;
    IBOutlet UIButton *downloadBtn;
}

@property(retain,nonatomic)UIImageView *appiconImage;
@property(retain,nonatomic) UILabel *appnameLabel;
@property(retain,nonatomic) UILabel *appsizeLabel;
@property(retain,nonatomic) UILabel *appdescriptionLabel;
@property(retain,nonatomic) UIButton *downloadBtn;
@end
