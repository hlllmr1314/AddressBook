//
//  ColorbleLabel.h
//  TongXunLu
//
//  Created by pan on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorbleLabel : UILabel
{
    NSString *_regexstr;
    NSString *_keyword;
    UIColor *_regexcolor;
}

-(void)ColorRegex:(NSString *)regexstr byKeyword:(NSString *)keyword withColor:(UIColor *)color;
-(void)ColorRegex:(NSString *)regexstr withColor:(UIColor *)color;
@end
