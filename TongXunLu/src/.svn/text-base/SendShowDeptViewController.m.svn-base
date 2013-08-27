//
//  SendShowDeptViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendShowDeptViewController.h"
#import "SendShowView.h"

@interface SendShowDeptViewController ()

@end

@implementation SendShowDeptViewController
{
    SendShowView *sendShowView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sendShowView = [[SendShowView alloc]init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view = sendShowView;
    sendShowView.upperView = _upperView;
    sendShowView.delegate = (id<SendShowViewDelegate>)self.parentViewController;
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    sendShowView.dept = dept;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
