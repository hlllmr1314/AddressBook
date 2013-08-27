//
//  QAlertView.m
//  HangShang
//
//  Created by Pan on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QAlertView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

extern AppDelegate *del;
static QAlertView *sharedInstance = nil;
@implementation QAlertView

+(QAlertView *)sharedInstance
{
	if(!sharedInstance) sharedInstance = [[self alloc] init];
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        alertBGView = [[UIView alloc]initWithFrame:CGRectMake(0, (UI_SCREEN_HEIGHT-50)/2, UI_SCREEN_WIDTH, 40)];
        alertBGView.backgroundColor = [UIColor clearColor];
        [[[UIApplication sharedApplication] delegate].window addSubview:alertBGView];
        alertBGView.userInteractionEnabled = NO;
        
        alphaMask = [[UIView alloc]initWithFrame:alertBGView.bounds];
        alphaMask.backgroundColor = [UIColor blackColor];
        alphaMask.alpha = 0.77;
        alphaMask.layer.cornerRadius = 8;
        [alertBGView addSubview:alphaMask];
       
        
        alertLabel = [[UILabel alloc]initWithFrame:alertBGView.bounds];
        alertLabel.backgroundColor = [UIColor clearColor];
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.font = [UIFont systemFontOfSize:17];
        alertLabel.textAlignment = UITextAlignmentCenter;
        [alertBGView addSubview:alertLabel];
        
        
        alertBGView.hidden = YES;
    }
    return self;
}

-(void)showAlertText:(NSString *)text fadeTime:(float)time
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(fade) object:nil];

    [[[UIApplication sharedApplication] delegate].window bringSubviewToFront:alertBGView];
    alertBGView.hidden = NO;
    alertLabel.text = text;
    alertBGView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         alertBGView.transform = CGAffineTransformMakeScale(1, 1);
                         alertBGView.alpha = 1;
                     }completion:^(BOOL finish){
                         
                     }];
    
    CGSize size = CGSizeMake(3000,alertLabel.frame.size.height);
    CGSize labelsize = [text sizeWithFont:alertLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    alertBGView.frame = CGRectMake((UI_SCREEN_WIDTH - labelsize.width)/2.0f, alertBGView.frame.origin.y, labelsize.width, alertBGView.frame.size.height);
    alphaMask.frame = CGRectMake(-25, 0, labelsize.width+50, alertBGView.frame.size.height);
    alertLabel.frame = alertBGView.bounds;
    

    
    [self performSelector:@selector(fade) withObject:nil afterDelay:time];
}

-(void)fade
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         alertBGView.alpha = 0;
                         alertBGView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }completion:^(BOOL finish){
                         [alertBGView setHidden:YES];
                     }];
}

-(void)delayCheckAlpha
{
    alertBGView.alpha = 1;
}

@end
