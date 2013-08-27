//
//  Search2PersonViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-21.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "CustomViewController.h"
#import "KeyboardView.h"
#import "Department.h"

@interface Search2PersonViewController : CustomViewController<KeyboardViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) Department *dept;

#pragma mark - use in commonUse
@property(nonatomic,strong) NSString *preSearchText;
@property(nonatomic,strong) UILabel *searchResultCountL;
@property(nonatomic,strong) NSMutableArray *arrPersonResult;
@property(nonatomic,strong) UITableView *table;
- (void)addNilImage:(Boolean)hidenTable;


- (NSPredicate*)predicateNum1:(NSString *)searchText;
- (NSPredicate*)predicateNum2:(NSString *)searchText;
- (NSPredicate*)predicateNum3:(NSString *)searchText;
@end
