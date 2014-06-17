//
//  AppsTableViewCell.m
//  Market
//
//  Created by 夏 伟 on 14-6-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "AppsTableViewCell.h"

@implementation AppsTableViewCell
@synthesize appiconImage;
@synthesize appnameLabel;
@synthesize appsizeLabel;
@synthesize appdescriptionLabel;
@synthesize downloadBtn;

- (void)awakeFromNib
{
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
