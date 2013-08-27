//
//  SearchIndex.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-21.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <mach/mach_time.h>



@interface SearchIndex : NSObject
CGFloat BNRTimeBlock (void (^block)(void));

@property(nonatomic,strong)NSString *appVersion;

@property(nonatomic,strong)NSString *dataFilePath;
@property(nonatomic,strong)NSString *orgDataVersionsStr;

+(SearchIndex *)sharedIndexs;
- (NSString *)convertToNum:(NSString *)pinyin;

- (NSDictionary *)userNameStr_index:(Person *)person searchText:(NSString *)searchText;
- (NSDictionary *)pinyinNotIntStr_index:(Person *)person searchText:(NSString *)searchText;
- (NSDictionary *)pinyinStr_index:(Person *)person searchText:(NSString *)searchText;
- (NSDictionary *)phoneStr_index:(Person *)person searchText:(NSString *)searchText;

//- (void)saveOrgids:(NSArray *)arrOrgs;



//
//@property(nonatomic,strong)NSMutableArray *persons;
//@property(nonatomic,strong)NSString *indexStr;
//@property(nonatomic,strong)NSString *deptId;
//
//@property(nonatomic,strong)NSMutableDictionary *dicNum;


//
//@property(nonatomic,strong)NSArray *arrPinyin;
//@property(nonatomic,strong)NSArray *arrPhone;
//@property(nonatomic,strong)NSDictionary *memoPersons;
//- (NSArray *)objIds:(NSString *)num;
//
//- (NSArray *)idsFromName:(int)num;
//- (NSArray *)idsFromPhone:(int)num;

#pragma mark - idsFrom element
//- (NSArray *)idsFromOne:(NSString *)index deptId:(NSString *)deptId;
//- (NSArray *)nextArrFromOne;
//- (NSArray *)subArrFromPinYin:(NSString *)pinyin;
#pragma mark - init Arrs
//- (void)initArrs;
@end

