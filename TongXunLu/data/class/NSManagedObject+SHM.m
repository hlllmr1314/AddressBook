//
//  NSManagedObject+KHH.m
//  CardBook
//
//  Created by cjk on 13-5-14.
//  Copyright (c) 2013年 shinemo. All rights reserved.
//

#import "NSManagedObject+SHM.h"

static NSSortDescriptor *nameSort;
@implementation NSManagedObject (SHM)
+ (NSManagedObjectContext *)currentContext {
    
    return [[SHMData sharedData] context];
}

// 在context里创建一个新的object;
+ (id)newObject {
    NSString *name = NSStringFromClass([self class]);
    NSManagedObjectContext *context = [self currentContext];
    //[self alloc]ini
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:name
                                                         inManagedObjectContext:context];
    
    // NSLog(@"[II] new managed object = %@", obj);
    return obj;
}

+ (id)newObject2 {
    NSString *name = NSStringFromClass([self class]);
    NSManagedObjectContext *context = [[SHMData sharedData] contextWithOtherThread];
    //[self alloc]ini
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:name
                                                         inManagedObjectContext:context];
    
    // NSLog(@"[II] new managed object = %@", obj);
    return obj;
}

// 根据 ID 和 类名 查数据库。此ID不是CoreData OBjectID，而至cardID，companyID等等。
// createIfNone==YES，无则新建
// createIfNone==NO， 无则返回nil；
+ (id)objectByID:(NSNumber *)ID createIfNone:(BOOL)createIfNone {
    return [self objectByKey:@"id" value:ID createIfNone:createIfNone];
}

+ (id)objectByID:(NSNumber *)ID thread:(ContentThread)thread
{
    if (thread == ContentThreadMain) {
        return [self objectByID:ID createIfNone:NO];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", ID];
    
    NSString *entityName = NSStringFromClass([self class]);
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        req.predicate = predicate;
    }
    NSArray *array = [[[SHMData sharedData] contextWithOtherThread] executeFetchRequest:req error:NULL];
    if(array&&[array count]>0){
        return array[0];
    }
    
    NSManagedObject *obj = [self newObject2];
    [obj setValue:[NSString stringWithFormat:@"%@",ID] forKey:@"id"];
    return obj;
    
}
/*!
 根据 Key-Value 查数据库。
 keyName 和 value 不能为nil，否则返回nil。
 createIfNone==YES，无则新建
 createIfNone==NO， 无则返回nil；
 */
+ (id)objectByKey:(NSString *)keyName value:(id)value createIfNone:(BOOL)createIfNone {
    NSManagedObject *result = nil;
    if (keyName && value) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", keyName, value];
        NSError *error;
       // NSString *entityName = NSStringFromClass([self class]);
        //NSLog(@"[II] Entity = %@", entityName);
        NSArray *matches = [self objectArrayByPredicate:predicate
                                        sortDescriptors:nil];
        if (nil == matches) {
            NSLog(@"[EE] fetch entity 出错：%@", error?
                  error.localizedDescription:
                  @"未知错误!!!");
            return result;
        }
        if ([matches count] > 1) {
            NSLog(@"[EE] fetch entity 出错：返回的对象多于一个!");
        }
        result = [matches lastObject];
        if (nil == result && createIfNone) {
            result = [self newObject];
            [result setValue:value forKey:keyName];
        }
    }
    return result;
}

+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offSet:(int)offSet limit:(int)limit thread:(int)thread
{
    NSString *entityName = NSStringFromClass([self class]);
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        req.predicate = predicate;
    }
    // 排序规则
    if ([sortDescriptors count]) {
        req.sortDescriptors = sortDescriptors;
    }
    if (offSet>=0) {
        [req setFetchOffset:offSet];
    }
    
    if (limit>=0) {
        [req setFetchLimit:limit];
    }
    NSError *error = nil;
    NSManagedObjectContext *context;
    if (thread == 0) {
        context = [self currentContext];
    }
    if (thread == 1) {
        context = [[SHMData sharedData] contextWithOtherThread];
    }
    
    NSArray *array = [context executeFetchRequest:req error:&error];
    if (nil == array) {
        NSString *errorMessage = (error)? error.localizedDescription: @"未知错误!!!";
        NSLog(@"[EE] fetchEntityName 出错：%@", errorMessage);
    }
    return array;
    
}

+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offSet:(int)offSet limit:(int)limit
{
    return [self objectArrayByPredicate:predicate sortDescriptors:sortDescriptors offSet:offSet limit:limit thread:0];
    
}

// 根据条件和排序规则查数据库。
// 没有符合条件的返回空数组，出错返回nil。
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
    return [self objectArrayByPredicate:predicate sortDescriptors:sortDescriptors offSet:-1 limit:-1];
}

+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors thread:(int)thread
{
    return [self objectArrayByPredicate:predicate sortDescriptors:sortDescriptors offSet:-1 limit:-1 thread:thread];
}

+ (NSString *)isNilStr:(NSString *)isNilStr
{
    if ([isNilStr isEqual:[NSNull null]]||[isNilStr isEqual:@""]) {
        return nil;
    }
    return isNilStr;
}

@end
@implementation NSManagedObject (SHMSort)
+ (NSSortDescriptor *)nameSortDescriptor {
    if (!nameSort) {
        nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                 ascending:YES
                                                  selector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return nameSort;
}

+ (NSSortDescriptor *)newCardSortDescriptor{
    NSSortDescriptor *result;
    result = [NSSortDescriptor sortDescriptorWithKey:@"viewed"
                                           ascending:YES
                                            selector:@selector(compare:)];
    return result;
}

@end
