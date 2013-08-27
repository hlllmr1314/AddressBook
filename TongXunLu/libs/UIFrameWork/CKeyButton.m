//
//  CKeyButton.m
//  TongXunLu
//
//  Created by pan on 13-4-1.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "CKeyButton.h"

@implementation CKeyButton
@synthesize value,index,funcKey;

- (id)init
{
    self = [super init];
    if (self) {
        funcKey = NO;
    }
    return self;
}

@end
