//
//  GoodsTableViewCell.h
//  Market
//
//  Created by 夏 伟 on 14-6-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *imageProduct;
    IBOutlet UIButton *linkBtn;
    IBOutlet UILabel *productDescriptionLabel;
    IBOutlet UILabel *productNameLabel;
}
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;

@property(retain,nonatomic)UIImageView *imageProduct;
@property(retain,nonatomic)UIButton *linkBtn;
@property(retain,nonatomic)UILabel *productDescriptionLabel;
@property(retain,nonatomic)UILabel *productNameLabel;
@end
