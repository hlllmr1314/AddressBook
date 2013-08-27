//
//  SharedDepartementDB.m
//  TongXunLu
//
//  Created by pan on 13-3-26.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SharedDepartmentDB.h"

@implementation SharedDepartmentDB

static SharedDepartmentDB *sharedInstance = nil;

+(SharedDepartmentDB *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

+(void)cleanCache
{
    
    sharedInstance = nil;
   
}
- (id)init
{
    self = [super init];
    if (self) {
        
        filteredArray = [[NSMutableArray alloc]init];
        
        //NSString *dbPath = [[NSBundle mainBundle]  pathForResource:@"tongxunludb" ofType:@"db" inDirectory:@""];
        NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
        db = [[FMDatabase alloc] initWithPath:dbPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        
        //开始进行部门转化为json的映射
        NSMutableArray *departments = [self recursiveGetDepartment:0];

        [filteredArray addObjectsFromArray:departments];
        //[departments release];
    }
    return self;
}

-(NSMutableArray *)getPeopleUnderDepartment:(int)deptid
{
        NSString *sql = [[NSString alloc] initWithFormat:@"SELECT a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where a.deptid =%d and a.deptid = d.deptid order by a.id asc",deptid];
        FMResultSet *rs2 = [db executeQuery:sql];
        
        NSMutableArray *subNames = [[NSMutableArray alloc] init];
        while ([rs2 next]){
            //DLog(@"id %@ name is %@,departname %@",[rs2 stringForColumn:@"id"],[rs2 stringForColumn:@"title"],[rs2 stringForColumn:@"departname"]);
            [subNames addObject:[rs2 resultDictionary]];
        }
        //[subNames release];
    
        return subNames;
}

-(NSMutableArray *)recursiveGetDepartment:(int)pid
{
    FMResultSet *rs = [db executeQuery:[[NSString alloc] initWithFormat:@"SELECT * FROM department where pid='%d' order by deptid asc",pid]];
    
    NSMutableArray *departments = [[NSMutableArray alloc] init];
    while ([rs next]){
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setValue:[rs stringForColumn:@"departname"] forKey:@"name"];
        [tempDict setValue:[rs stringForColumn:@"deptid"]  forKey:@"deptid"];
        //DLog(@"depart name is %@",[rs stringForColumn:@"departname"]);
        int pid = [rs intForColumn:@"deptid"];
        NSMutableArray *subUnits = [self recursiveGetDepartment:pid];
        
        if (subUnits != nil && [subUnits count]>0){
            [tempDict setValue:[NSString stringWithFormat:@"%d",[subUnits count]]  forKey:@"subDeptCount"];
            [tempDict setValue:subUnits  forKey:@"subUnits"];
            
            //如果该部门有子部门，则将子部门的所有人数相加
            int subPeopleCount = 0;
            for (int i=0;i<[subUnits count];i++){
                NSDictionary *tempItem = (NSDictionary *)[subUnits objectAtIndex:i];
                subPeopleCount += [[tempItem objectForKey:@"subPeopleCount"] intValue];
                
                [tempDict setValue:[NSString stringWithFormat:@"%d",subPeopleCount]  forKey:@"subPeopleCount"];
            }
            
        }else{//如果没有子部门，则获取该部门人
            [tempDict setValue:@"0"  forKey:@"subDeptCount"];
            subUnits = [self getPeopleUnderDepartment:pid];
            [tempDict setValue:subUnits  forKey:@"subUnits"];
            
            if (subUnits != nil && [subUnits count]>0) {
                [tempDict setValue:[NSString stringWithFormat:@"%d",[subUnits count]]  forKey:@"subPeopleCount"];
            }else{
                [tempDict setValue:@"0"  forKey:@"subPeopleCount"];
            }
            
            
        }
        
        [departments addObject:tempDict];
    }
    return departments;
}

-(NSArray *)departmentDBArray
{
    
    return [NSArray arrayWithArray:filteredArray];
}

@end
