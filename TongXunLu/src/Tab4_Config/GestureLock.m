//
//  GestureLock.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-24.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "GestureLock.h"

@implementation GestureLock
@synthesize lockKey = _lockKey;
@synthesize backDate = _backDate;
+(GestureLock *)sharedLock
{
    static GestureLock *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GestureLock alloc] init];
    });
    
    return sharedInstance;
}


- (BOOL)onLock
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"GestureOnLock"];
}

- (void)setOnLock:(BOOL)onLock
{
    [[NSUserDefaults standardUserDefaults] setBool:onLock forKey:@"GestureOnLock"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)lockKey
{
    if (!_lockKey) {
        _lockKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"GestureLockKey"];
    }
    return _lockKey;
}

- (void)setLockKey:(NSString *)lockKey
{
    if (!_lockKey||![_lockKey isEqualToString:lockKey]) {
        _lockKey = lockKey;
        [[NSUserDefaults standardUserDefaults] setValue:lockKey forKey:@"GestureLockKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setBackDate:(NSDate *)backDate
{
    if (!_backDate||![_backDate isEqualToDate:backDate]) {
        _backDate = backDate;
        [[NSUserDefaults standardUserDefaults] setValue:backDate forKey:@"GestureLockBackDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSDate *)backDate
{
    if (!_backDate) {
        _backDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"GestureLockBackDate"];
    }
    return _backDate;
}

- (BOOL)needShowLock
{
    if (!self.lockKey) {
        return NO;
    }
   
   return !self.backDate || [self.backDate timeIntervalSinceNow] <= -(10*60) ;
}

@end







