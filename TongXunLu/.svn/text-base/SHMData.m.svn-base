//
//  KHHDataNew.m
//  CardBook
//
//  Created by CJK on 13-1-14.
//  Copyright (c) 2013年 Kinghanhong. All rights reserved.
//

#import "SHMData.h"


@implementation SHMData
{
    NSDateFormatter *_dateFormatter;

}
@synthesize context = _context;
@synthesize contextWithOtherThread = _contextWithOtherThread;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
- (id)initData
{
    self = [super init];
    if (self) {
        
      //  _agent = [[KHHNetClinetAPIAgent alloc] init];
        
    }
    return self;
}



+ (id)sharedData
{
    static id _sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[SHMData alloc] initData];
    });
    return _sharedObj;
}

#pragma mark - Core Data stack
- (void)removeContext // 删除Context。登出或登入时使用。
{
    [_context reset];
    _context = nil;
    [_contextWithOtherThread reset];
    _contextWithOtherThread = nil;
    _persistentStoreCoordinator = nil;
    _managedObjectModel = nil;
    NSURL *storeURL = [[SHMApp applicationDocumentsDirectory] URLByAppendingPathComponent:@"AddressBook.sqlite"];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
}

- (void)saveContext:(ContentThread)thread
{
    NSManagedObjectContext *context;
    if (thread == ContentThreadMain) {
        context = self.context;
    }
    if (thread == ContentThreadPrivate) {
        context = self.contextWithOtherThread;
    }
    if (![context hasChanges]) {
        NSLog(@"[II] context 无需保存！");
        return;
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        if (error) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } else {
            NSLog(@"[II] 保存 context 时发生了未知错误！");
        }
        abort();
    }
}

- (void)saveContext // 保存更改。
{
    [self saveContext:ContentThreadMain];
}

- (void)cleanContext // 清除未保存的更改。
{
    [self.context reset];
    _context = nil;
    _persistentStoreCoordinator = nil;
}


- (NSManagedObjectContext *)context
{
    if (_context != nil) {
        return _context;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:coordinator];
    }
    return _context;
}

- (NSManagedObjectContext *)contextWithOtherThread
{
    if (_contextWithOtherThread != nil) {
        return _contextWithOtherThread;
    }
   
        _contextWithOtherThread = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_contextWithOtherThread setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
   
    return _contextWithOtherThread;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AddressBook" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // 登陆成功后以 “user_companyID.sqlite” 为文件名创建数据库文件。user取不到时使用默认的“CardBook.sqlite”。
    NSString *fileName = @"AddressBook.sqlite";
//    NSString *userID = [KHHUser shareInstance].userId;
//    NSLog(@"userId%@",userID);
//    if (userID.length) {
//        fileName = [NSString stringWithFormat:@"Carte%@.sqlite",userID];
////        NSNumber *companyID = [NSNumber numberFromString:[KHHUser shareInstance].companyId];
////        fileName = [NSString stringWithFormat:@"%@_%@.sqlite",userID, companyID];
//    }
    NSURL *storeURL = [[SHMApp applicationDocumentsDirectory] URLByAppendingPathComponent:fileName];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // 由于所有数据都在服务器端，一旦出错可直接删除本地数据，重新同步。
        NSLog(@"[EE] ERROR!!删除 %@ 文件！", fileName);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        _persistentStoreCoordinator = nil;
    }
    return self.persistentStoreCoordinator;
}

- (NSString *)interval:(NSString *)timeStr
{
    if (!_dateFormatter) {
       _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
   
    
    return [NSString stringWithFormat:@"%lld", (long long int)[[_dateFormatter dateFromString:timeStr] timeIntervalSince1970]*1000];
   
    
}

@end
