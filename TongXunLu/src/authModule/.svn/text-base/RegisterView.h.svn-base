//
//  NewUserRegView.h
//  PocketZhe2
//
//  Created by Pan on 13-1-28.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTextField.h"
#import "FunctionButton.h"

@protocol RegisterViewDelegate <NSObject>

-(void)registerViewResponsePhoneverifycode:(NSString *)phonenum;
-(void)registerViewDidsubmit:(NSString *)phonenum with:(NSString *)verifycode;
-(void)registerViewCancel:(NSString *)phonenum with:(NSString *)verifycode;
@end

@interface RegisterView : UIView <UITextFieldDelegate>
{

    
    FunctionButton *getVerifyCode;
    int time;
    NSTimer *buttonTimer;
}
@property (assign)              id<RegisterViewDelegate> delegate;
@property (nonatomic,retain)    QTextField *phoneFiled;
@property (nonatomic,retain)    QTextField *verifyFiled;

@property (nonatomic,strong) FunctionButton *submit;
-(void)verfiyButtonStartCountDown:(int)ctime;
-(void)resetButtonInfo;
- (void)getVerifySuccess;
@end
