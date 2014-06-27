//
//  GoodsTableViewCell.m
//  Market
//
//  Created by 夏 伟 on 14-6-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "GoodsTableViewCell.h"

@implementation GoodsTableViewCell
@synthesize imageProduct;
@synthesize linkBtn;
@synthesize productDescriptionLabel;
@synthesize productNameLabel;

- (void)awakeFromNib
{
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    [_lineBtn setBackgroundColor:[UIColor colorWithRed:0xc5/255.0 green:0xc5/255.0 blue:0xc5/255.0 alpha:1.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
