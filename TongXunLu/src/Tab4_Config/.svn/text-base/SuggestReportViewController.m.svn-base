//
//  SuggestReportViewController.m
//  PocketZhe2
//
//  Created by pan on 13-4-26.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import "SuggestReportViewController.h"
#import "sys/utsname.h"  
#import "MBProgressHUD.h"
#import "NetClient+ToPath.h"
#import "SearchIndex.h"

@interface SuggestReportViewController ()

@end

@implementation SuggestReportViewController
{
    MBProgressHUD *hud;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:184.0/255.0 green:194.0/255.0 blue:202.0/255.0 alpha:1];
    self.title = @"反馈";
    
    UIControl *backTap = [[UIControl alloc]initWithFrame:CGRectMake(0, 66, 320, self.view.frame.size.height -66)];
    backTap.backgroundColor = [UIColor clearColor];
    [backTap addTarget:self action:@selector(backTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTap];
    
    UIButton *_rightBut = [UIButton buttonWithType:100];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateNormal];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateHighlighted];
    [_rightBut setTitle:@"提交" forState:UIControlStateNormal];
    [_rightBut setTitle:@"提交" forState:UIControlStateHighlighted];
    [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _rightBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_rightBut addTarget:self action:@selector(submitFunc:) forControlEvents:UIControlEventTouchUpInside];
    _rightBut.frame= CGRectMake(0, 7, 55, 44-14);
    
//    UIButton *submitBtn = [UIButton buttonWithType:100];
//    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
//    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [submitBtn addTarget:self action:@selector(submitFunc:) forControlEvents:UIControlEventTouchUpInside];
//    submitBtn.frame= CGRectMake(0, 7, 60, 44-14);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBut];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 20)];
    title1.text = @"您在使用中遇到了什么问题吗？向我们反馈吧！";
    title1.font = [UIFont systemFontOfSize:13];
    title1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:title1];
    
    filed1 = [[UITextView alloc]initWithFrame:CGRectMake(20, 45, 280, 80)];
    filed1.font = [UIFont systemFontOfSize:13];
    filed1.layer.cornerRadius = 5;
    [self.view addSubview:filed1];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 280, 20)];
    title2.text = @"您的Email或其他联系方式";
    title2.font = [UIFont systemFontOfSize:13];
    title2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:title2];
    
    
    
    filed2 = [[QTextField alloc]initWithFrame:CGRectMake(20, 155, 280, 30)];
    filed2.delegate = self;
    [self.view addSubview:filed2];
    
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self submitFunc:nil];
    return YES;
}

-(void)backTap:(id)sender
{
    [filed1 resignFirstResponder];
    [filed2 resignFirstResponder];
}

-(void)backFunc:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)submitFunc:(id)sender
{
 
    if (filed1.text.length < 5) {
        [[QAlertView sharedInstance] showAlertText:@"请输入至少5个字符！" fadeTime:2];
        return;
    }

    [self backTap:nil];
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"提交反馈";
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *phoneType =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    [[NetClient sharedClient] doPath:@"post" path:@"system/feedback" parameters:@{@"content":filed1.text,@"contactMail":filed2.text.length?filed2.text:@"",@"txtPhoneModel":[NSString stringWithFormat:@"%@,%@",phoneType,phoneVersion],@"phoneType":@"ios",@"phoneVersion":[SearchIndex sharedIndexs].appVersion} success:^(NSMutableDictionary *dic) {
        [hud hide:YES];
        [[QAlertView sharedInstance] showAlertText:@"提交成功" fadeTime:2];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSMutableDictionary *dic) {
        [hud hide:YES];
        [[QAlertView sharedInstance] showAlertText:dic[@"note"] fadeTime:2];
    } withToken:YES toJson:NO isNotForm:YES parameterEncoding:AFJSONParameterEncoding];
    
    
 //   [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    
    /*!
     if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone1G GSM";
     if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone3G GSM";
     if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone3GS GSM";
     if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone4 GSM";
     if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone4 CDMA";
     if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
     if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone5";
     if ([platform isEqualToString:@"iPod1,1"])      return @"iPod 1G";
     if ([platform isEqualToString:@"iPod2,1"])      return @"iPod 2G";
     if ([platform isEqualToString:@"iPod3,1"])      return @"iPod 3G";
     if ([platform isEqualToString:@"iPod4,1"])      return @"iPod 4G";
     if ([platform isEqualToString:@"iPad1,1"])      return @"iPad WiFi";
     if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2 WiFi";
     if ([platform isEqualToString:@"iPad2,2"])      return @"iPad2 GSM";
     if ([platform isEqualToString:@"iPad2,3"])      return @"iPad2 CDMAV";
     if ([platform isEqualToString:@"iPad2,4"])      return @"iPad2 CDMAS";
     if ([platform isEqualToString:@"i386"])         return @"Simulator";
     if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
     */
    

//    NSString *phoneType =[[UIDevice currentDevice] systemName];
//    
//    //here use sys/utsname.h
//    //get the device model and the system version
//    
//    
//    
//    NSDictionary *sendDict = [NSDictionary dictionaryWithObjectsAndKeys:filed1.text,@"content", filed2.text,@"contact",phoneType,@"phoneType",phoneVersion,@"phoneVersion",nil];
//    NSData *sendData = [NSJSONSerialization dataWithJSONObject:sendDict options:0 error:nil];
//
//    DLog(@"send data is %@",sendData);
//    
//    NSString *url = [NSString stringWithFormat:@"%@users/%@/feedback",SERVERADD,username];
//    QMutableURLRequest *request = [QMutableURLRequest requestWithURL:[NSURL URLWithString:url] withToken:YES];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:sendData];
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        //[SVProgressHUD showSuccessWithStatus:@"提交成功！" duration:2];
//        [SVProgressHUD dismiss];
//        [self submitSuccessLogic];
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        DLog(@"loadDn error:%@",error);
//        
//        [NetErrorHandling handlingWithstatusCode:response.statusCode JSON:JSON withTar:nil withSel:nil];
//        
//    }];
//    [operation start];
}

-(void)submitSuccessLogic
{
    //[AHAlertView_customStyle applyCustomAlertAppearance];
//    AHAlertView *alert = [[AHAlertView alloc]initWithTitle:@"提示" message:@"提交成功，感谢您的反馈！"];
//    __weak AHAlertView *weakAlert = alert;
//    [alert setCancelButtonTitle:@"返回" block:^{
//        [weakAlert dismiss];
//        [self dismissModalViewControllerAnimated:YES];
//    }];
//    [alert addButtonWithTitle:@"继续" block:^{
//        [weakAlert dismiss];
//    }];
//    [alert show];
   

    
    
}
@end
