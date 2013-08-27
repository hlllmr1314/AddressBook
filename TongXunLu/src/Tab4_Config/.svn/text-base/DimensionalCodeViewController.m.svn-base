//
//  DimensionalCodeViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-6-9.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "DimensionalCodeViewController.h"
#import "IFTweetLabel.h"

@interface DimensionalCodeViewController ()

@end

@implementation DimensionalCodeViewController
{
    UIImageView *_imageView;
    IFTweetLabel *_tweetLabel;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tweetLabel = [[IFTweetLabel alloc]initWithFrame:CGRectMake(30, 50, 260, 80)];
        _tweetLabel.text = @"使用手机二维码软件扫描下方二维码，或使用手机浏览器访问 http://shinemo.com/t 下载集团号簿";
       
        _tweetLabel.font = [UIFont systemFontOfSize:15.0];
        _tweetLabel.numberOfLines = 0;
       [_tweetLabel setLinksEnabled:YES];
        _tweetLabel.backgroundColor = [UIColor clearColor];
        
        _tweetLabel.normalColor = [UIColor orangeColor];
		_tweetLabel.highlightColor = [UIColor brownColor];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(85, 150, 150, 150)];
        _imageView.image = [UIImage imageNamed:@"DimensionalCode_520x520"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTweetNotification:) name:IFTweetLabelURLNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
    
    [self.view addSubview:_tweetLabel];
    [self.view addSubview:_imageView];
    
    UIButton *_rightBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 28)];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateNormal];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateHighlighted];
    [_rightBut setTitle:@"发送" forState:UIControlStateNormal];
    [_rightBut setTitle:@"发送" forState:UIControlStateHighlighted];
    [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _rightBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    [_rightBut addTarget:self action:@selector(toMsgInLink) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBut];
}

- (void)toMsgInLink
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];
            picker.body = @"http://shinemo.com/t";
            //picker.recipients = smsRecipients;
            [self.navigationController presentModalViewController:picker animated:YES];
        }
        else {
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"设备没有短信功能" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
           [alert show];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
       
    }
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IFTweetLabelURLNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTweetNotification:(NSNotification *)notification
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:notification.object]];
	//NSLog(@"handleTweetNotification: notification = %@", notification.object);
}


@end
