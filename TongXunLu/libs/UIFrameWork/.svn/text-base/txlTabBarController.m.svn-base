//
//  txlTabBarController.m
//  TongXunLu
//
//  Created by WuXiaoHui on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "txlTabBarController.h"
#import "CustomBadge.h"

@interface txlTabBarController ()

@end

@implementation txlTabBarController
{
    CustomBadge *newBad;
}
@synthesize currentSelectedIndex,buttons;

- (void)viewDidAppear:(BOOL)animated{
    if (! inited) {
        [self hideRealTabBar];
        [self customTabBar];
        inited = YES;
    }
}

- (void)hideRealTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UILabel class]]){
            view.hidden = YES;
            break;
        }
    }
}



-(void)customTabBar
{
    UIView *blackbg = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    blackbg.backgroundColor = [UIColor blackColor];
    [self.tabBar addSubview:blackbg];
    DLog(@"tab height:%f",self.tabBar.frame.size.height);
    
    slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_bg"]];
    slideBg.frame = self.tabBar.bounds;
    slideBg.userInteractionEnabled = YES;
    
    //创建按钮
    int viewCount = 4;
    if (self.buttons == nil) {
        self.buttons = [[NSMutableArray alloc]initWithCapacity:viewCount];
    }
    double _width = 320 / viewCount;
    double _height = self.tabBar.frame.size.height;
    [self.tabBar addSubview:slideBg];
    
    
    for (int i = 0; i < viewCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_width,0, _width, _height);

        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.buttons addObject:btn];
        [self.tabBar  addSubview:btn];
        //[btn release];
    }
    [self selectedTab:[self.buttons objectAtIndex:0]];
}


- (void)selectedTab:(UIButton *)button{
    
    if (self.currentSelectedIndex == button.tag) {
        //return;
    }

    self.currentSelectedIndex = button.tag;
    self.selectedIndex = self.currentSelectedIndex;
    [self performSelector:@selector(slideTabBg:) withObject:button];   // NSLog(@"selectd index %d",self.selectedIndex);
    if (_haveNew) {
        [self addNew];
    }
   
}
- (void)slideTabBg:(UIButton *)btn{//用btn返回点中的位置数
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationDelegate:self];
     
    
    NSString *filename = [[NSString alloc] initWithFormat:@"tab_s%d",(btn.tag+1)];//btn.tag返回的是点击的选项卡位置数从0开始
    slideBg.image = [UIImage imageNamed:filename];
    [UIView commitAnimations];
}

#pragma mark - for out
- (void)addNew
{
    if (!newBad) {
        newBad = [CustomBadge customBadgeWithString:@"new"
                                    withStringColor:[UIColor whiteColor]
                                     withInsetColor:[UIColor redColor]
                                     withBadgeFrame:YES
                                withBadgeFrameColor:[UIColor whiteColor]
                                          withScale:0.8
                                        withShining:YES];
        [newBad setFrame:CGRectMake(320-newBad.frame.size.width, -2, newBad.frame.size.width, newBad.frame.size.height)];
        [slideBg addSubview:newBad];
    }    
}

- (void)removeNew
{
    if (newBad) {
        [newBad removeFromSuperview];
    }
    
    
}

@end
