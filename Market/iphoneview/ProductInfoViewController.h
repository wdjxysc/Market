//
//  ProductInfoViewController.h
//  Market
//
//  Created by 夏 伟 on 14-6-16.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@protocol UIViewTestDelegate;

@interface ProductInfoViewController : UIViewController<UIViewPassValueDelegate,UIWebViewDelegate>
{
    
}

@property(retain,nonatomic)NSDictionary *productInfoDic;
@end


@protocol UIViewTestDelegate <NSObject>

-(void)test;

@end