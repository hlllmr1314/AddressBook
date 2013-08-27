//
//  UIViewController+ForBar.m
//  TongXunLu
//
//  Created by Mac Mini on 13-8-26.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "UIViewController+ForBar.h"

@implementation UIViewController (ForBar)
- (void)navLeftArrow
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
    [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backPop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
