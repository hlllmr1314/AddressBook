//
//  KeyBoardJustNum.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-19.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "KeyBoardJustNum.h"
#import "CKeyButton.h"

@implementation KeyBoardJustNum

- (id)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 197)]) {
        [self addSub];
    }
    return self;
}

- (void)addSub
{
   
    float starty = 0;// self.view.frame.size.height - (50*4 - 3);
    //_keyBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50*4 - 3)];
    //_keyBoardView.frame = CGRectMake(0, 0, 320, 50*4 - 3);
    float preWidth = 0;
    for (int i=1; i<=9; i++) {
        UIImage *nImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        UIImage *nImage_highlight = [UIImage imageNamed:[NSString stringWithFormat:@"%d-1.png",i]];
        
        CKeyButton *button = [[CKeyButton alloc]initWithFrame:CGRectMake(preWidth, starty + (i-1)/3 *49, nImage.size.width, 50)];
        [button setImage:nImage forState:UIControlStateNormal];
        
        [button setImage:nImage_highlight forState:UIControlStateHighlighted];
        [self addSubview:button];
        
        button.value = [NSString stringWithFormat:@"%d",i];
        [button addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
        
        if ((i)%3==0) {
            preWidth = 0;
        }else
            preWidth = button.frame.origin.x + button.frame.size.width-1;
    }
    NSArray *lastLine = @[@"nil",@"0",@"del"];
    preWidth = 0;
    for(int i=0 ;i<lastLine.count; i++)
    {
        UIImage *nImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[lastLine objectAtIndex:i]]];
        UIImage *nImage_highlight = [UIImage imageNamed:[NSString stringWithFormat:@"%@-1.png",[lastLine objectAtIndex:i]]];
        
        CKeyButton *button = [[CKeyButton alloc]initWithFrame:CGRectMake(preWidth, starty+3*49, nImage.size.width, 50)];
        [button setImage:nImage forState:UIControlStateNormal];
        
        if (![lastLine[i] isEqualToString:@"nil"]) {
             [button setImage:nImage_highlight forState:UIControlStateHighlighted];
        }        
       
        if ([lastLine[i] isEqualToString:@"nil"]) {
          //  button.enabled = NO;
        }
        [self addSubview:button];
        
        if (![lastLine[i] isEqualToString:@"nil"]) {        
            [button addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([lastLine[i] isEqualToString:@"del"]) {
            [button addTarget:self action:@selector(doDown:) forControlEvents:UIControlEventTouchDown];
        }
        preWidth = button.frame.origin.x + button.frame.size.width-1;
        
        button.value = [NSString stringWithFormat:@"%@",[lastLine objectAtIndex:i]];
        if (i !=2) {
            button.funcKey = YES;
        }
    }
}

@end
