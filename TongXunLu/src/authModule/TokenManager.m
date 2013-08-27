//
//  CellphoneBind.m
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "TokenManager.h"

static TokenManager *sharedInstance = nil;
@implementation TokenManager
@synthesize token;

+(TokenManager *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(void)setToken:(NSString *)atoken
{
    token = [atoken copy];
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)token
{
    //return TESTTOKEN;
    if (token ==nil) {
        NSString *atoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        token = atoken;
    }
    return token;
}



#pragma - method

+(NSString *)getToken
{
    return [TokenManager sharedInstance].token;
}
@end
