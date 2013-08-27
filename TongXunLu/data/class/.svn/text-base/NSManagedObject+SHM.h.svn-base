//
//  NSManagedObject+KHH.h
//  CardBook
//
//  Created by cjk on 13-5-14.
//  Copyright (c) 2013年 shinemo. All rights reserved.
//



#import <CoreData/CoreData.h>

#import "SHMData.h"

@interface NSManagedObject (SHM)
// 当前应用的NSManagedObjectContext
+ (NSManagedObjectContext *)currentContext;

// 在context里创建一个新的object;
+ (id)newObject;
+ (id)newObject2;
// 根据 ID 查数据库。此ID不是CoreData OBjectID，而至cardID，companyID等等。
// createIfNone==YES，无则新建
// createIfNone==NO， 无则返回nil；
+ (id)objectByID:(NSNumber *)ID createIfNone:(BOOL)createIfNone;
+ (id)objectByID:(NSNumber *)ID thread:(ContentThread)thread;
// 根据 Key-Value 查数据库。
// createIfNone==YES，无则新建
// createIfNone==NO， 无则返回nil；
+ (id)objectByKey:(NSString *)keyName value:(id)value createIfNone:(BOOL)createIfNone;

// 根据条件和排序规则查数据库。
// 没有符合条件的返回空数组，出错返回nil。
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors thread:(int)thread;
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offSet:(int)offSet limit:(int)limit;
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offSet:(int)offSet limit:(int)limit thread:(int)thread;
+ (NSString *)isNilStr:(NSString *)isNilStr;
@end

@interface NSManagedObject (SHMSort)
// 默认的对象名字排序规则
+ (NSSortDescriptor *)nameSortDescriptor;
+ (NSSortDescriptor *)newCardSortDescriptor;
//+ (NSSortDescriptor *)newCardSortDescriptor;
//+ (NSSortDescriptor *)companyCardSortDescriptor;
@end
