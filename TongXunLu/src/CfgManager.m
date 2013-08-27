//
//  CfgManager.m
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.


#import "CfgManager.h"

static CfgManager *sharedInstance = nil;
@implementation CfgManager
//@synthesize myDepartment;
@synthesize _cfgdict;

+(CfgManager *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

+(NSString *)getConfig:(NSString *)cname
{
    NSString *cfgDetail = [[CfgManager sharedInstance]._cfgdict objectForKey:cname];
    
    if (cfgDetail == nil) {
        cfgDetail = [[NSUserDefaults standardUserDefaults] objectForKey:cname];
        if (cfgDetail == nil || [cfgDetail isEqual:[NSNull null]]){
            cfgDetail = @"";
        }
        [[CfgManager sharedInstance]._cfgdict setValue:cfgDetail forKey:cname];
    }
    if (cfgDetail !=nil) {
        if ([cfgDetail isEqual:[NSNull null]] || (![cfgDetail isEqual:[NSNull null]] && [cfgDetail isEqualToString:@""])) {
            cfgDetail = nil;
        }
    }
    DLog(@"getconfig:%@  --- %@",cname,cfgDetail);

    return cfgDetail;
}

+(void)setConfig:(NSString *)cname detail:(NSString *)detail
{
    if (detail == nil) {
        detail = @"";
    }
    [[CfgManager sharedInstance]._cfgdict setValue:detail forKey:cname];
    [[NSUserDefaults standardUserDefaults] setValue:detail forKey:cname];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
