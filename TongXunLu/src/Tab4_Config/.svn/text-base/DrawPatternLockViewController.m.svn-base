//
//  ViewController.m
//  AndroidLock
//
//  Created by Purnama Santo on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawPatternLockViewController.h"
#import "DrawPatternLockView.h"
#import "GestureLock.h"
#import "CfgManager.h"
#import "TokenManager.h"
#import "AuthViewController.h"

#define MATRIX_SIZE 3

@implementation DrawPatternLockViewController

{
    DrawPatternLockView *dpView;
    DrawPatternLockView *viewBg;
    UILabel *labelRemind;
    
    int numSet;
    NSString *tempKey;
    int numTry;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    // self.view = ;
}

- (void)backPop:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    if (_setFinish) {
        _setFinish(NO);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_typeLock != typeLockGo) {
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:0];
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        if (_typeLock == typeLockSet) {
            self.title = @"设置手势密码";
        }
        if (_typeLock == typeLockReSet) {
            self.title = @"修改手势密码";
        }
    }
    {
        labelRemind = [[UILabel alloc]initWithFrame:CGRectMake(20, 22, 320-40, 20)];
        labelRemind.backgroundColor = [UIColor clearColor];
        labelRemind.font = [UIFont systemFontOfSize:18.0];
        labelRemind.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1.0];
        labelRemind.textAlignment = UITextAlignmentCenter;
        
        if (_typeLock == typeLockSet) {
            labelRemind.text = @"描绘您的手势";
        }
        if (_typeLock == typeLockReSet) {
            labelRemind.text = @"描绘您的手势";
        }
        [self.view addSubview:labelRemind];
    }
    
    //    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    //    imageView.frame = CGRectMake(0, 0, 320.0, self.view.frame.size.height);
    //    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    CGRect rectPro;
    if (_typeLock != typeLockGo) {
        rectPro = CGRectMake(10, 60, 300, 300);
        
    }else{
        rectPro = CGRectMake(160-140, 150, 280, 280);
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_use"]];
        imageView.frame = CGRectMake(160-90/2.0, 30, 90, 90);
        [self.view addSubview:imageView];
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(160-100/2, self.view.frame.size.height-30, 100, 20)];
        [but setTitle:@"取消绑定" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        but.titleLabel.textAlignment = UITextAlignmentCenter;
        but.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [but setTitleColor:[UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.view addSubview:but];
        labelRemind.frame = CGRectMake(20, 130, 320-40, 20);
        labelRemind.text = @"请描绘您的手势";
        labelRemind.font = [UIFont systemFontOfSize:14.0];
        numTry = 5;
    }
    
    viewBg = [[DrawPatternLockView alloc]initWithFrame:rectPro];
    dpView = [[DrawPatternLockView alloc]initWithFrame:rectPro];
    dpView.backgroundColor = [UIColor clearColor];
    viewBg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dpView];
    int w = dpView.frame.size.width/MATRIX_SIZE;
    int h = dpView.frame.size.height/MATRIX_SIZE;
    for (int i=0; i<MATRIX_SIZE; i++) {
        for (int j=0; j<MATRIX_SIZE; j++) {
            UIImage *dotImage = [UIImage imageNamed:@"dot_off"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
                                                       highlightedImage:[UIImage imageNamed:@"dot_on"]];
            if (_typeLock == typeLockGo) {
                imageView.frame = CGRectMake(0, 0, dotImage.size.width, dotImage.size.height);
            }else{
                imageView.frame = CGRectMake(0, 0, dotImage.size.width, dotImage.size.height);
            }
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = j*MATRIX_SIZE + i + 1;
            int x = w*j + w/2;
            int y = w*i + h/2;
            
            imageView.center = CGPointMake(x, y);
            [dpView addSubview:imageView];
        }
    }
    [self.view addSubview:viewBg];
}


- (void)logout
{
    UIAlertViewBlock *alertView = [[UIAlertViewBlock alloc] initWithTitle:@"提示" message:@"确定取消绑定？" cancelButtonTitle:@"取消"
                                                              clickButton:^(NSInteger indexButton){
                                                                  if (indexButton == 1) {
                                                                      [CfgManager setConfig:@"updated" detail:@"0"];
                                                                      [[TokenManager sharedInstance] setToken:@""];
                                                                      [CfgManager setConfig:@"departmentID" detail:nil];
                                                                      AuthViewController *auc = [[AuthViewController alloc]init];
                                                                      [GestureLock sharedLock].lockKey = nil;
                                                                      [GestureLock sharedLock].onLock = NO;
                                                                      [self presentModalViewController:auc animated:NO];
                                                                      [auc displayAuthView];
                                                                      
                                                                      
                                                                  }
                                                              } otherButtonTitles:@"确定"];
    [alertView show];
}

- (void)viewWillLayoutSubviews {
    
    //    int w = self.view.frame.size.width/MATRIX_SIZE;
    //    int h = self.view.frame.size.height/MATRIX_SIZE;
    //
    //    int i=0;
    //    for (UIView *view in self.view.subviews)
    //        if ([view isKindOfClass:[UIImageView class]]) {
    //            int x = w*(i/MATRIX_SIZE) + w/2;
    //            int y = h*(i%MATRIX_SIZE) + h/2;
    //            view.center = CGPointMake(x, y);
    //            i++;
    //        }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _paths = [[NSMutableArray alloc] init];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:dpView];
  //  NSLog(@"count%d",[[touches allObjects] count]);
    UIView *touched = [dpView hitTest:pt withEvent:event];
    
    // DrawPatternLockView *v = (DrawPatternLockView*)self.view;
    if (pt.x<=0||pt.y<=0||pt.y>=dpView.frame.size.height||pt.x>=dpView.frame.size.width) {
        return;
    }
    [viewBg drawLineFromLastDotTo:pt];
    
    if ( touched != dpView) {
     //   NSLog(@"touched view tag: %d ", touched.tag);
        
        BOOL found = NO;
        for (NSNumber *tag in _paths) {
            found = tag.integerValue==touched.tag;
            if (found)
                break;
        }
        
        if (found)
            return;
        
        [_paths addObject:[NSNumber numberWithInt:touched.tag]];
        [viewBg addDotView:touched];
        
        UIImageView* iv = (UIImageView*)touched;
        iv.highlighted = YES;
    }
    
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // clear up hilite
    //  DrawPatternLockView *v = (DrawPatternLockView*)self.view;
    [viewBg clearDotViews];
    
    for (UIView *view in dpView.subviews)
        if ([view isKindOfClass:[UIImageView class]])
            [(UIImageView*)view setHighlighted:NO];
    
    [viewBg setNeedsDisplay];
    
    if (_typeLock == typeLockSet || _typeLock == typeLockReSet) {
        if (numSet == 0) {
            numSet++;
            tempKey = [self getKey];
            labelRemind.text = @"确认您的手势";
        }else{
            if ( [tempKey isEqualToString:[self getKey]]) {
                [GestureLock sharedLock].lockKey = tempKey;
                labelRemind.text = @"描绘成功";
                [[QAlertView sharedInstance] showAlertText:@"手势设置成功" fadeTime:2];
                [self dismissModalViewControllerAnimated:YES];
            }else{
                labelRemind.text = @"两次手势不一致，请重新输入";
                numSet = 0;
            }
            
        }
    }
    if (_typeLock == typeLockGo) {
        if ([[self getKey] isEqualToString:[GestureLock sharedLock].lockKey]) {
            [self dismissModalViewControllerAnimated:NO];
        }else{
            
            numTry-=1;
            if (numTry <= 0) {
                [CfgManager setConfig:@"updated" detail:@"0"];
                [[TokenManager sharedInstance] setToken:@""];
                [CfgManager setConfig:@"departmentID" detail:nil];
                AuthViewController *auc = [[AuthViewController alloc]init];
                [GestureLock sharedLock].lockKey = nil;
                [GestureLock sharedLock].onLock = NO;
                [self presentModalViewController:auc animated:NO];
                [auc displayAuthView];
            }
            labelRemind.text = [NSString stringWithFormat:@"手势错误，您还可以尝试%d次",numTry];
        }
    }
    
    // pass the output to target action...
    //   if (_target && _action)
    //    [_target performSelector:_action withObject:[self getKey]];
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%02d", tag.integerValue];
    }
    
    return key;
}

- (void)setTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

@end
