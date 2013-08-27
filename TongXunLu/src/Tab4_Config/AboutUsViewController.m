//
//  AboutUsViewController.m
//  TongXunLu
//
//  Created by pan on 13-4-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "AboutUsViewController.h"
#import "FunctionButton.h"
#import "SearchIndex.h"
#import "UIUnderlinedButton.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    
    UIImageView *coverImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:coverImage];
    //[coverImage release];
    coverImage.backgroundColor = [UIColor whiteColor];
    coverImage.image = [UIImage imageNamed:@"Default.png"];
    if (UI_SCREEN_HEIGHT > 480) {
        coverImage.image = [UIImage imageNamed:@"Default-568h.png"];
    }
    coverImage.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [coverImage addGestureRecognizer:singleRecognizer];
   // [singleRecognizer release];

    //添加两个按钮
    FunctionButton *btnTutorial = [[FunctionButton alloc]initWithFrame:CGRectMake(160.0-255.0f/4, 300.0f, 255.0f/2,67.0f/2)];
    [btnTutorial addTarget:self action:@selector(viewWebPage:) forControlEvents:UIControlEventTouchUpInside];
    [btnTutorial setImage:[UIImage imageNamed:@"btn_tutorial.png"] forState:UIControlStateNormal];
    [btnTutorial setIndex:0];
    btnTutorial.hidden = YES;
    // [self.view addSubview:btnTutorial];
    
    
   // [btnTutorial release];
    //btnTutorial.imageView.contentMode = UIViewContentModeCenter;
  //  [self.view addSubview:btnTutorial];
    
    FunctionButton *btnHomepage = [[FunctionButton alloc]initWithFrame:CGRectMake(160.0-255.0f/4, 360.0f, 255.0f/2,67.0f/2)];
    [btnHomepage addTarget:self action:@selector(viewWebPage:) forControlEvents:UIControlEventTouchUpInside];
    [btnHomepage setImage:[UIImage imageNamed:@"btn_homepage.png"] forState:UIControlStateNormal];
    [btnHomepage setIndex:1];
    btnHomepage.hidden = YES;
    [self.view addSubview:btnHomepage];
   // [btnHomepage release];
    //btnHomepage.imageView.contentMode = UIViewContentModeCenter;
  //  [self.view addSubview:btnHomepage];
    
    NSString *text = [NSString stringWithFormat:@"版本：%@    技术支持电话：",[SearchIndex sharedIndexs].appVersion];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:9.0]];
    NSString *phone = @"0571-28060831";    
    CGSize size2 = [phone sizeWithFont:[UIFont systemFontOfSize:11.0]];
   
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(160-size.width/2-size2.width/2, self.view.frame.size.height-40, size.width, size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:9.0];
    [self.view addSubview:label];
    UIUnderlinedButton *butPhone = [UIUnderlinedButton underlinedButton];
    butPhone.frame = CGRectMake(160-size.width/2-size2.width/2+size.width , self.view.frame.size.height-50, size2.width, size2.height+20);
    butPhone.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [butPhone setTitle:phone forState:UIControlStateNormal];
    [butPhone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butPhone setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [butPhone addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butPhone];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 20)];
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.font =  [UIFont systemFontOfSize:9.0];
//    label.textColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];    
//    label.text = [NSString stringWithFormat:@"版本：%@    技术支持电话：0571-28060831",[SearchIndex sharedIndexs].appVersion];
//    [self.view addSubview:label];
    
//    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 20)];
//    label1.textAlignment = UITextAlignmentCenter;
//    label1.backgroundColor = [UIColor clearColor];
//    label1.font = [UIFont systemFontOfSize:12.0];
//    label1.textColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
//    
//    label1.text = @"Copyright 2013 ShineMo.com";
//    [self.view addSubview:label1];
    /*
    UIControl *c = [[UIControl alloc]initWithFrame:self.view.bounds];
    //[self.view addSubview:c];
    [c release];
    [c addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchDown];
     */
}

- (void)callPhone
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0571-28060831"]];
}

-(void)viewWebPage:(FunctionButton *)button
{
    switch (button.index) {
        case 0:
            {
            NSURL *weburl = [NSURL URLWithString:@"http://txl.shinemo.com/tutorial"];
            
            [[UIApplication sharedApplication] openURL:weburl];
            }
            break;
        case 1:
        {
            NSURL *weburl=[NSURL URLWithString:@"http://txl.shinemo.com/"];
            [[UIApplication sharedApplication] openURL:weburl];
        }
            break;
        default:
            break;
    }
}
-(void)touch:(id)sender
{

    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)singleTap:(UITapGestureRecognizer *)recognizer
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
