//
//  CustomViewController.m
//  TongXunLu
//
//  Created by pan on 13-3-29.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.navigationController.viewControllers.count >1) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
       
        self.navigationItem.leftBarButtonItem = backItem;
        
    }else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)backPop:(id)sender
{
    DLog(@"backPop!!!");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString *)title
{
   self.navigationItem.title = title;
}

@end
