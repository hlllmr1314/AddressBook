//
//  NewUserRegView.m
//  PocketZhe2
//
//  Created by Pan on 13-1-28.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import "RegisterView.h"
#import "QAlertView.h"

#define MAINSTYLE_COLOR     [UIColor colorWithRed:82/255.0f green:100/255.0f blue:118/255.0f alpha:1]

@implementation RegisterView
@synthesize delegate;
@synthesize phoneFiled,verifyFiled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:20.0f/255.0f green:110.0f/255.0f blue:204.0f/255.0f alpha:1];

#define START_Y 40
#define HEIGHT 36
#define SPACING 60

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, START_Y, 80, HEIGHT)];
        label.text = @"手机号：";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:19];
        [self addSubview:label];
       
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(30, START_Y+SPACING, 80, HEIGHT)];
        label.text = @"验证码：";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:19];
        [self addSubview:label];
      
        
        phoneFiled = [[QTextField alloc]initWithFrame:CGRectMake(110, START_Y, 180, HEIGHT)];
        phoneFiled.delegate = self;
        phoneFiled.keyboardType = UIKeyboardTypeNumberPad;
        phoneFiled.text = @"";
        phoneFiled.textColor = [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1];
        [self addSubview:phoneFiled];
        
        
        verifyFiled = [[QTextField alloc]initWithFrame:CGRectMake(110, START_Y+ SPACING, 80, HEIGHT)];
        verifyFiled.delegate = self;
        verifyFiled.textColor = [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1];
        verifyFiled.text = @"";
        [self addSubview:verifyFiled];
       

        getVerifyCode = [[FunctionButton alloc]initWithFrame:CGRectMake(195, 100, 100, 37)];
        [getVerifyCode addTarget:self action:@selector(getverifycode:) forControlEvents:UIControlEventTouchUpInside];
        getVerifyCode.titleLabel.textColor = [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1];
        getVerifyCode.titleLabel.font = [UIFont systemFontOfSize:14];
        [getVerifyCode setTitle:@"获取验证码"];
        [getVerifyCode setImage:[UIImage imageNamed:@"btnbg.png"] forState:UIControlStateNormal];
        [getVerifyCode setImage:[UIImage imageNamed:@"btnbg.png"] forState:UIControlStateSelected];
        //[getVerifyCode setImageEdgeInsets:UIEdgeInsetsMake(7.5, 5, 7.5, 5)];
        [self addSubview:getVerifyCode];
        
        getVerifyCode.imageView.contentMode = UIViewContentModeCenter;
        getVerifyCode.backgroundColor = [UIColor clearColor];
        
//        FunctionButton *cancel = [[FunctionButton alloc]initWithFrame:CGRectMake(95, 220, 130, 50)];
//        [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//        [cancel setImage:[UIImage imageNamed:@"button_cancel_b.png"] forState:UIControlStateNormal];
//        [cancel setImage:[UIImage imageNamed:@"button_cancel_b_checked.png"] forState:UIControlStateHighlighted];
//        [self addSubview:cancel];
//        [cancel release];
//        cancel.imageView.contentMode = UIViewContentModeScaleAspectFit;

         _submit= [[FunctionButton alloc]initWithFrame:CGRectMake(90, 155, 140, 40)];
        [_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [_submit setImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateNormal];
        [self addSubview:_submit];
       
        _submit.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)getverifycode:(FunctionButton *)button
{
    DLog(@"获取验证码");
    
    if ([self checkPhoneNumberLegal:phoneFiled.text]) {
        if ([self.delegate respondsToSelector:@selector(registerViewResponsePhoneverifycode:)]) {
            [self.delegate registerViewResponsePhoneverifycode:phoneFiled.text];
        }
        button.enabled = NO;
        button.selected = YES;
        button.title = @"正在获取..";
    }
    
}

-(void)verfiyButtonStartCountDown:(int)ctime
{
    time = ctime;
    buttonTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshButtonTime) userInfo:nil repeats:YES];
    getVerifyCode.title = [NSString stringWithFormat:@"%d秒后重试",time];
    
}

-(void)resetButtonInfo
{
    getVerifyCode.selected = NO;
    getVerifyCode.enabled = YES;
    [buttonTimer invalidate];
    buttonTimer = nil;
    getVerifyCode.title = @"获取验证码";
    
}

-(void)refreshButtonTime
{
    time -=1;
    
    if (time >0) {
        getVerifyCode.title = [NSString stringWithFormat:@"%d秒后重试",time];
    }else
    {
        [self resetButtonInfo];
        
    }
}

- (void)getVerifySuccess
{
    [verifyFiled becomeFirstResponder];
}

-(void)cancel:(FunctionButton *)button
{
    if ([self.delegate respondsToSelector:@selector(registerViewCancel:with:)]) {
        [self.delegate registerViewCancel:@"" with:@""];
    }
    
}

-(void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if (!hidden) {
        phoneFiled.text = @"";
        verifyFiled.text = @"";
    }
}

-(void)submit:(FunctionButton *)button
{
    button.enabled = NO;
    [self hideKeyboard];
    if ([self checkPhoneNumberLegal:phoneFiled.text]) {
        if ([verifyFiled.text isEqualToString:@""]) {
            [[QAlertView sharedInstance] showAlertText:@"请输入验证码" fadeTime:3];
        }else if ([self.delegate respondsToSelector:@selector(registerViewDidsubmit:with:)]) {
            [self.delegate registerViewDidsubmit:phoneFiled.text with:verifyFiled.text];
        }
    }
}

-(BOOL)checkPhoneNumberLegal:(NSString *)phoneNumber
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    //手机号码 验证码合法性验证 正则表达式方法
    if (isMatch) {
        return YES;
    }else
    {
        [[QAlertView sharedInstance] showAlertText:@"请输入正确的手机号码！" fadeTime:3];
    }
    return NO;
}

-(void)hideKeyboard
{
    if (phoneFiled !=nil) {
        [phoneFiled resignFirstResponder];
    }
    if (verifyFiled !=nil) {
        [verifyFiled resignFirstResponder];
    }
}

@end
