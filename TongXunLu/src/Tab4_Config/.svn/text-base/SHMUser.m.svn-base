//
//  SHMUser.m
//  TongXunLu
//
//  Created by Mac Mini on 13-6-7.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SHMUser.h"

@implementation SHMUser
@synthesize downloadURL = _downloadURL;
@synthesize lastAPP = _lastAPP;
@synthesize lastData = _lastData;
@synthesize forceUpdateAPP = _forceUpdateAPP;
@synthesize forceUpdateData = _forceUpdateData;
@synthesize cellPhone = _cellPhone;
@synthesize dateShowAlertUpApp = _dateShowAlertUpApp;
+ (SHMUser *)sharedUser
{
    static id _sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[SHMUser alloc] init];
    });
    return _sharedObj;
}

- (void)setDownloadURL:(NSString *)downloadURL
{
    if (!downloadURL||[downloadURL isKindOfClass:[NSNull class]]||[downloadURL isEqualToString:@""]) {
        return;
    }
    _downloadURL = downloadURL;
    [[NSUserDefaults standardUserDefaults]setValue:downloadURL forKey:@"downloadURL"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)downloadURL
{
    if (!_downloadURL) {
        _downloadURL = [[NSUserDefaults standardUserDefaults] valueForKey:@"downloadURL"];
    }
    return _downloadURL;
}

- (void)setLastAPP:(NSNumber *)lastAPP
{
   
    _lastAPP = lastAPP;
    [[NSUserDefaults standardUserDefaults]setValue:lastAPP forKey:@"lastAPP"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSNumber *)lastAPP
{
    if (!_lastAPP) {
        _lastAPP = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastAPP"];
    }
    return _lastAPP;
}

- (void)setLastData:(NSNumber *)lastData
{
    
    _lastData = lastData;
    [[NSUserDefaults standardUserDefaults]setValue:lastData forKey:@"lastData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSNumber *)lastData
{
    if (!_lastData) {
        _lastData = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastData"];
    }
    return _lastData;
}

- (void)setForceUpdateAPP:(NSNumber *)forceUpdateAPP
{
    
    _forceUpdateAPP = forceUpdateAPP;
    [[NSUserDefaults standardUserDefaults]setValue:forceUpdateAPP forKey:@"forceUpdateAPP"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSNumber *)forceUpdateAPP
{
    if (!_forceUpdateAPP) {
        _forceUpdateAPP= [[NSUserDefaults standardUserDefaults] valueForKey:@"forceUpdateAPP"];
    }
    return _forceUpdateAPP;
}

- (void)setForceUpdateData:(NSNumber *)forceUpdateData
{
    
    _forceUpdateData = forceUpdateData;
    [[NSUserDefaults standardUserDefaults]setValue:forceUpdateData forKey:@"forceUpdateData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSNumber *)forceUpdateData
{
    if (!_forceUpdateData) {
        _forceUpdateData= [[NSUserDefaults standardUserDefaults] valueForKey:@"forceUpdateData"];
    }
    return _forceUpdateData;
}

- (void)setCellPhone:(NSString *)cellPhone
{
    _cellPhone = cellPhone;
    [[NSUserDefaults standardUserDefaults]setValue:_cellPhone forKey:@"cellPhone"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)cellPhone
{
    if (!_cellPhone) {
        _cellPhone = [[NSUserDefaults standardUserDefaults] valueForKey:@"cellPhone"];
    }
    return _cellPhone;
}

- (void)setDateShowAlertUpApp:(NSDate *)dateShowAlertUpApp
{
    if (!_dateShowAlertUpApp||![_dateShowAlertUpApp isEqualToDate:dateShowAlertUpApp]) {
        _dateShowAlertUpApp = dateShowAlertUpApp;
        [[NSUserDefaults standardUserDefaults] setValue:dateShowAlertUpApp forKey:@"UserDateShowAlertUpApp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSDate *)dateShowAlertUpApp
{
    if (!_dateShowAlertUpApp) {
        _dateShowAlertUpApp = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserDateShowAlertUpApp"];
    }
    return _dateShowAlertUpApp;
}


- (BOOL)canShowAlert
{    
    return !self.dateShowAlertUpApp || [self.dateShowAlertUpApp timeIntervalSinceNow] <= -(24*60*60) ;
}


@end







