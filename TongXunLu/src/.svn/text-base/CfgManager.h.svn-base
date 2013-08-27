//
//  CfgManager.h
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CfgManager : NSObject

@property (nonatomic,readonly) NSMutableDictionary *_cfgdict;

+(NSString *)getConfig:(NSString *)keyName;
+(void)setConfig:(NSString *)keyName detail:(NSString *)value;

+(CfgManager *)sharedInstance;
@end
