//
//  SendDeptUtil.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-30.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendDeptUtil.h"

@implementation SendDeptUtil
static NSMutableDictionary *dicSelect;
+ (NSMutableDictionary *)dicSelect
{
    return dicSelect;
}

+ (void)setDicSelect:(NSMutableDictionary *)dicSelect2
{
    dicSelect = dicSelect2;
}

@end
