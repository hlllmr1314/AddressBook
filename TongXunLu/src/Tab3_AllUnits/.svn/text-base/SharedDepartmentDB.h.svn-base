//
//  SharedDepartementDB.h
//  TongXunLu
//
//  Created by pan on 13-3-26.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SharedDepartmentDB : NSObject
{
    FMDatabase *db;
    NSMutableArray *filteredArray;
}
@property (nonatomic,retain) NSArray *departmentDBArray;

+(void)cleanCache;
+(SharedDepartmentDB *)sharedInstance;
-(NSMutableArray *)getPeopleUnderDepartment:(int)deptid;
-(NSMutableArray *)recursiveGetDepartment:(int)pid;
@end
