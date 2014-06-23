//
//  GoodsDetailedTableViewCell.m
//  Market
//
//  Created by 夏 伟 on 14-6-20.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "GoodsDetailedTableViewCell.h"

@implementation GoodsDetailedTableViewCell
@synthesize productDescriptionLabel;
@synthesize productNameLabel;
@synthesize linkBtn;
@synthesize detailedLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
