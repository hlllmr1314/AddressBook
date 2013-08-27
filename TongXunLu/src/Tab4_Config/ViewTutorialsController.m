//
//  ViewTutorialsController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-8-26.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "ViewTutorialsController.h"
#import "MBProgressHUD.h"
#import "UIViewController+ForBar.h"

@interface ViewTutorialsController ()

@end

@implementation ViewTutorialsController
{
    MBProgressHUD *hud;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navLeftArrow];
        
     NSURL *weburl = [NSURL URLWithString:@"http://txl.shinemo.com/tutorial"];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320.0, self.view.frame.size.height-44-44)];
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.tabBarController.view animated:YES];
    hud.labelText = @"获取教程";
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:weburl]];
    webView.delegate = self;
	[self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    hud.labelText = @"加载失败";
    [hud hide:YES];
}

@end
