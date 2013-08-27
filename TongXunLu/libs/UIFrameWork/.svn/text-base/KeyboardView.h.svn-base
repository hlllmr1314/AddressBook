//
//  KeyboardView.h
//  TongXunLu
//
//  Created by pan on 13-4-1.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardViewDelegate <NSObject>

-(void)KeyboardViewDidPressedKeyChanged:(NSString *)text;
-(void)KeyboardViewTryHideKeyboard;
@end

@interface KeyboardView : UIView
{
    UIView *_numberLayout;
    UIView *_wordLayout;
    
    UIImageView *dailBG;
    UIView *dailBGDown;
    UIImageView *dailBGUp;
    
}

+(KeyboardView *)sharedKeyBoard;
+(void)clearKeyboard;
+(void)resetKeyboard;
-(void)KeyboardPullDown;
-(void)KeyboardPullUp;

@property (retain) UILabel *dailText;
@property (readonly) BOOL didPullDown;
@property (nonatomic) UIKeyboardType keyboardType;
@property (assign) id<KeyboardViewDelegate> delegate;
@property (nonatomic,assign) UIViewController *viewController;
@end
