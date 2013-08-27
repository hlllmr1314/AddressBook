//
//  Custom2ViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "Custom2ViewController.h"

@interface Custom2ViewController ()

@end

@implementation Custom2ViewController
@synthesize navBar, navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        navItem = [[UINavigationItem alloc] initWithTitle:nil];
        [navBar pushNavigationItem:navItem animated:NO];
        [navBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:0];
        
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        [navItem setLeftBarButtonItem:backItem];
        [self.view addSubview:navBar];        
    }
    return self;
}

-(void)backPop:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
