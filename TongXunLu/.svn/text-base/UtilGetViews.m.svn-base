//
//  UtilGetViews.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "UtilGetViews.h"

@implementation UtilGetViews
{
    UIStoryboard *mainStoryboard;
}

+(UtilGetViews *)sharedGetViews
{
    static UtilGetViews *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UtilGetViews alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        mainStoryboard = [UIStoryboard storyboardWithName:@"ViewControllers" bundle:nil];
       
    }
    return self;
}

- (UIViewController *)viewConFromId:(NSString *)indentifier
{
     return [mainStoryboard instantiateViewControllerWithIdentifier:indentifier];
}

@end
