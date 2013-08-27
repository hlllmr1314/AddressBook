//
//  KeyboardView.m
//  TongXunLu
//
//  Created by pan on 13-4-1.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "KeyboardView.h"
#import "CKeyButton.h"

static KeyboardView *sharedKeyBoard = nil;
@implementation KeyboardView
{
    NSTimer *timer;
}
@synthesize delegate;
@synthesize keyboardType;
@synthesize dailText;
@synthesize viewController;
@synthesize didPullDown;



+(KeyboardView *)sharedKeyBoard
{
    if (sharedKeyBoard == nil) {
        sharedKeyBoard = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, 246)];
    }
    return sharedKeyBoard;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   // CGRect f = self.superview.frame;
   // self.frame = CGRectMake(0, f.size.height - self.frame.size.height+1, self.frame.size.width, self.frame.size.height);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        didPullDown = NO;
        self.backgroundColor = [UIColor clearColor];
        dailBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"d_bg2.png"]];
        dailBG.frame = CGRectMake(0, 0, frame.size.width, 50);
        dailBG.userInteractionEnabled = YES;
        [self addSubview:dailBG];
       
        
        dailBGUp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"d_bg.png"]];
        dailBGUp.frame = CGRectMake(20, 5, frame.size.width-40, 40);
        [dailBG addSubview:dailBGUp];
        
        
        dailBGDown = [[UIView alloc]initWithFrame:dailBG.bounds];
        [dailBG addSubview:dailBGDown];
       
        
        CKeyButton *ua = [[CKeyButton alloc]initWithFrame:CGRectMake(-1, 0, 108, 50)];
        [ua setImage:[UIImage imageNamed:@"uarrow.png"] forState:UIControlStateNormal];
        [ua setImage:[UIImage imageNamed:@"uarrow1.png"] forState:UIControlStateHighlighted];
        [dailBGDown addSubview:ua];
        ua.value = @"pulldown_arrow";
        ua.funcKey = YES;
       
        [ua addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        CKeyButton *ua2 = [[CKeyButton alloc]initWithFrame:CGRectMake(106, 0, 108, 50)];
        [ua2 setBackgroundColor:[UIColor clearColor]];
        [dailBGDown addSubview:ua2];
        ua2.value = @"pulldown_arrow";
        ua2.funcKey = YES;
        
        [ua2 addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //UIImageView *um = [[UIImageView alloc]initWithFrame:CGRectMake(106, 0, 108, 50)];
        UIImageView *um = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 108, 50)];
        um.image = [UIImage imageNamed:@"k_pd_center.png"];
        //[dailBGDown addSubview:um];
        [ua2 addSubview:um];
               
        
        
        CKeyButton *ud = [[CKeyButton alloc]initWithFrame:CGRectMake(320-108+1, 0, 108, 50)];
        [ud setImage:[UIImage imageNamed:@"SHANCHU1.png"] forState:UIControlStateNormal];
        [ud setImage:[UIImage imageNamed:@"SHANCHU.png"] forState:UIControlStateHighlighted];
        [dailBGDown addSubview:ud];
        ud.value = @"pulldown_del";
        ud.funcKey = YES;
        [ud addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
        [ud addTarget:self action:@selector(doDown:) forControlEvents:UIControlEventTouchDown];
        dailBGDown.hidden = YES;
        [dailBG bringSubviewToFront:dailBGUp];
        
        dailText = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, dailBG.frame.size.width-160, dailBG.frame.size.height)];
        [dailBG addSubview:dailText];
        
        dailText.text = @"";
        dailText.backgroundColor = [UIColor clearColor];
        dailText.textAlignment = NSTextAlignmentCenter;
        dailText.font = [UIFont systemFontOfSize:25];
        dailText.textColor = [UIColor whiteColor];
        dailText.userInteractionEnabled = NO;
        dailText.lineBreakMode = UILineBreakModeHeadTruncation;
        
        _numberLayout = [[UIView alloc]initWithFrame:CGRectMake(0, 49, frame.size.width, 216-19)];
        [self addSubview:_numberLayout];
       
        _numberLayout.backgroundColor = [UIColor clearColor];
        _numberLayout.hidden = YES;
        
        _wordLayout = [[UIView alloc]initWithFrame:CGRectMake(0, 49, frame.size.width, 216-19)];
        [self addSubview:_wordLayout];
        
        _wordLayout.backgroundColor = [UIColor clearColor];
        _wordLayout.hidden = YES;
        
        /**********************************************/
        //draw NumPad**********************
        /**********************************************/
#define NUM_SPOINT CGPointMake(0,0)
        float preWidth = NUM_SPOINT.x;
        
        for (int i=1; i<=9; i++) {
            UIImage *nImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
            UIImage *nImage_highlight = [UIImage imageNamed:[NSString stringWithFormat:@"%d-1.png",i]];

            CKeyButton *button = [[CKeyButton alloc]initWithFrame:CGRectMake(preWidth, NUM_SPOINT.y+ (i-1)/3 *49, nImage.size.width, 50)];
            [button setImage:nImage forState:UIControlStateNormal];
            [button setImage:nImage_highlight forState:UIControlStateHighlighted];
            [_numberLayout addSubview:button];
            
            button.value = [NSString stringWithFormat:@"%d",i];
            [button addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
            
            if ((i)%3==0) {
                preWidth = 0;
            }else
                preWidth = button.frame.origin.x + button.frame.size.width-1;
        }
        
        NSArray *lastLine = @[@"darrow",@"ABC",@"0",@"del"];
        preWidth = NUM_SPOINT.x;
        for(int i=0 ;i<lastLine.count; i++)
        {
            UIImage *nImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[lastLine objectAtIndex:i]]];
            UIImage *nImage_highlight = [UIImage imageNamed:[NSString stringWithFormat:@"%@-1.png",[lastLine objectAtIndex:i]]];
            
            CKeyButton *button = [[CKeyButton alloc]initWithFrame:CGRectMake(preWidth, NUM_SPOINT.y + 3 *49, nImage.size.width, 50)];
            [button setImage:nImage forState:UIControlStateNormal];
            [button setImage:nImage_highlight forState:UIControlStateHighlighted];
            [_numberLayout addSubview:button];
           
            [button addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
            if ([lastLine[i] isEqualToString:@"del"]) {
                [button addTarget:self action:@selector(doDown:) forControlEvents:UIControlEventTouchDown];
            }
            preWidth = button.frame.origin.x + button.frame.size.width-1;
            
            button.value = [NSString stringWithFormat:@"%@",[lastLine objectAtIndex:i]];
            if (i !=2) {
                button.funcKey = YES;
            }
        }
        
        /**********************************************/
        //draw wordPad**********************
        /**********************************************/
#define WORD_SPOINT CGPointMake(-1,0)

        NSArray *WLines = @[@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                            @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                            @[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"],
                            @[@"JIANTOU",@"123",@"SHANCHU"]];

        for(int j=0 ;j< WLines.count; j++)
        {
            preWidth = WORD_SPOINT.x;
            for (int i=0; i< ((NSArray *)[WLines objectAtIndex:j]).count; i++) {
                UIImage *nImage_highlight = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[WLines objectAtIndex:j] objectAtIndex:i]]];
                UIImage *nImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@1.png",[[WLines objectAtIndex:j] objectAtIndex:i]]];
                
                CKeyButton *button = [[CKeyButton alloc]initWithFrame:CGRectMake(preWidth, WORD_SPOINT.y + j *49, nImage.size.width, 50)];
                [button setImage:nImage forState:UIControlStateNormal];
                [button setImage:nImage_highlight forState:UIControlStateHighlighted];
                [_wordLayout addSubview:button];
                [button addTarget:self action:@selector(keyboardTyped:) forControlEvents:UIControlEventTouchUpInside];
                button.value = [[WLines objectAtIndex:j] objectAtIndex:i];
                
                preWidth = button.frame.origin.x + button.frame.size.width-1;
                
                if (j == 3) {
                    button.funcKey = YES;
                }
            }

        }
        
        
        
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)doDown:(id)sender
{
    if (!timer) {
        timer =  [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector: @selector(handleTimer:)
                                                userInfo: nil
                                                 repeats: NO];
    }
   
}

- (void)handleTimer:(id)sender
{
     dailText.text = @"";
    [self.delegate KeyboardViewDidPressedKeyChanged:dailText.text];
    [timer invalidate];
    timer = nil;
    
}

-(void)keyboardTyped:(CKeyButton *)btn
{
    //NSAssert(@"KeyboarvView should set textFiled!", self.textFiled == nil);
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    if (btn.funcKey ) {
        if ([btn.value isEqualToString:@"ABC"]) {
            [self bringSubviewToFront:_wordLayout];
            self.keyboardType = UIKeyboardTypeDefault;
        }
        else if ([btn.value isEqualToString:@"del"] || [btn.value isEqualToString:@"SHANCHU"] || [btn.value isEqualToString:@"pulldown_del"]){
                if (dailText.text.length > 0) {
                    dailText.text = [dailText.text substringToIndex:dailText.text.length-1];
                }
            if ([self.delegate respondsToSelector:@selector(KeyboardViewDidPressedKeyChanged:)]) {
                [self.delegate KeyboardViewDidPressedKeyChanged:dailText.text];
            }
        }
        else if ([btn.value isEqualToString:@"123"]) {
            [self bringSubviewToFront:_numberLayout];
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
        else if ([btn.value isEqualToString:@"JIANTOU"] || [btn.value isEqualToString:@"darrow"]) {
            DLog(@"hide keyboard!");
            if ([self.delegate respondsToSelector:@selector(KeyboardViewTryHideKeyboard)]) {
                [self.delegate KeyboardViewTryHideKeyboard];
            }
            [self KeyboardPullDown];
        }
        else if ([btn.value isEqualToString:@"pulldown_arrow"]) {
            [self KeyboardPullUp];
        }
    }else
    {
        DLog(@"keyboard typed:%@",btn.value);
        dailText.text = [dailText.text stringByAppendingFormat:btn.value,nil];
        if ([self.delegate respondsToSelector:@selector(KeyboardViewDidPressedKeyChanged:)]) {
            [self.delegate KeyboardViewDidPressedKeyChanged:dailText.text];
        }
    }
}

-(void)setKeyboardType:(UIKeyboardType)tkeyboardType
{
    DLog(@"dText:%@",dailText.text);
    keyboardType = tkeyboardType;
    
    switch (keyboardType) {
        case UIKeyboardTypeDefault:
            _wordLayout.hidden = NO;
            _numberLayout.hidden = YES;
            [self bringSubviewToFront:_wordLayout];
            break;
        case UIKeyboardTypeNumberPad:
            _wordLayout.hidden = YES;
            _numberLayout.hidden = NO;
            [self bringSubviewToFront:_numberLayout];
            break;
        default:
            break;
    }
    DLog(@"dText22:%@",dailText.text);

}

+(void)resetKeyboard
{
    [[KeyboardView sharedKeyBoard] KeyboardPullUp];
    [KeyboardView sharedKeyBoard].keyboardType = UIKeyboardTypeNumberPad;
    [KeyboardView sharedKeyBoard].dailText.text = @"";
}

+(void)clearKeyboard
{
    if (sharedKeyBoard !=nil) {
        [sharedKeyBoard removeFromSuperview];
    }
}

-(void)KeyboardPullDown
{
    DLog(@"KeyboardPullDown!");
    if (didPullDown) {
        return;
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.superview.frame.size.height - 50+1, self.frame.size.width, self.frame.size.height);
    }completion:^(BOOL finished){
        
        didPullDown = YES;

        dailBGUp.hidden = NO;
        dailBGDown.hidden = NO;
        dailBGDown.alpha = 0;
        [dailBG bringSubviewToFront:dailBGDown];
        [dailBG bringSubviewToFront:dailText];
        dailText.textColor = [UIColor blackColor];
        dailText.frame = CGRectMake(106, 0, 108, dailBG.frame.size.height);
        
        [UIView animateWithDuration:0.3 animations:^{
            dailBGDown.alpha = 1;
            dailBGUp.alpha = 0;
        }];

    }];

}

-(void)KeyboardPullUp
{
    DLog(@"KeyboardPullUp");
//    if (!didPullDown) {
//        return;
//    }
    self.frame = CGRectMake(0, self.superview.frame.size.height - 50+1, self.frame.size.width, self.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.superview.frame.size.height - self.frame.size.height+1, self.frame.size.width, self.frame.size.height);
    }completion:^(BOOL finished){
        
        didPullDown = NO;

        dailBGDown.hidden = NO;
        dailBGUp.hidden = NO;
        dailBGUp.alpha = 0;
        dailText.frame = CGRectMake(80, 0, dailBG.frame.size.width-160, dailBG.frame.size.height);
        [dailBG bringSubviewToFront:dailBGUp];
        [dailBG bringSubviewToFront:dailText];
        dailText.textColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:0.3 animations:^{
            dailBGUp.alpha = 1;
            dailBGDown.alpha = 0;
        }];


    }];
}

#pragma mark - initDown
- (void)initDown{
    self.frame = CGRectMake(0, self.superview.frame.size.height - 50+1, self.frame.size.width, self.frame.size.height);
}
@end
