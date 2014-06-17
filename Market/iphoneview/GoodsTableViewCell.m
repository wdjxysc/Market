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
