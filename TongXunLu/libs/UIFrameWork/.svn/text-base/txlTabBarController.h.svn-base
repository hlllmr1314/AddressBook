//
//  txlTabBarController.h
//  TongXunLu
//
//  Created by WuXiaoHui on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface txlTabBarController : UITabBarController{
    NSMutableArray *buttons;
    int currentSelectedIndex;
    UIImageView *slideBg;
    BOOL inited;
}

@property (nonatomic,assign) int currentSelectedIndex;
@property (nonatomic,retain) NSMutableArray *buttons;

- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;

#pragma mark - for out
@property(nonatomic,assign)Boolean haveNew;
- (void)addNew;
- (void)removeNew;
@end
