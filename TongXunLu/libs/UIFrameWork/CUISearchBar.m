//
//  CUISearchBar.m
//  TongXunLu
//
//  Created by pan on 13-4-1.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "CUISearchBar.h"
#import "KeyboardView.h"

@implementation CUISearchBar
@synthesize tar;

-(void)layoutSubviews
{
    for(id searchField in self.subviews) {
        if([searchField isKindOfClass:[UITextField class]]) {
            [searchField setInputView:[[UIView alloc]initWithFrame:CGRectZero]];
//            [searchField setInputView:[KeyboardView sharedKeyBoard]];
//            [KeyboardView sharedKeyBoard].textFiled = searchField;
//            if (tar != nil) {
//                [KeyboardView sharedKeyBoard].delegate = tar;
//            }
        }
    }
    [super layoutSubviews];
}

@end
