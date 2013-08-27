//
//  Tab3ViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "Tab3ViewController.h"
#import "Tab3NameListViewController.h"
#import "Tab3SearchResultViewController.h"
#import "BaiduMobStat.h"

@interface Tab3ViewController ()

@end

@implementation Tab3ViewController

- (id)init
{
    if (self = [super init]) {
         [self setGroupSendMSGBtnShow:YES];
      

    }
   return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sendMsgArray removeAllObjects];
    NSArray *KEYINDB = @[@"virtualCellPhone",@"workcell"];
    NSLog(@"departmentID%@",self.departmentID);
    NSString *sql;
    if (self.departmentID) {
        [self sendMsgArrayFresh:self.departmentID];
        return;
    }else{
        sql = [[NSString alloc] initWithFormat:@"SELECT a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where a.deptid = d.deptid order by a.id asc"];
    }
    
    FMResultSet *rs = [self.db executeQuery:sql];
    while ([rs next]){
        //    [self.unitsArray addObject:[rs resultDictionary]];
        
        NSDictionary *item = [rs resultDictionary];
        for (NSString *key in KEYINDB) {
            NSString *phonenumber = [item objectForKey:key];
            if (phonenumber != nil && ![phonenumber isEqual:[NSNull null]] && ![phonenumber isEqualToString:@""]) {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:item,@"obj",key,@"kname", nil];
                [self.sendMsgArray addObject:dictionary];
                break;
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
   // [self.unitsArray removeAllObjects];
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
}

- (void)sendMsgArrayFresh:(NSString *)departmentID
{
    
    NSArray *arrPro0 = [[SharedDepartmentDB sharedInstance] getPeopleUnderDepartment:[departmentID integerValue]];
    
    if (arrPro0&&[arrPro0 count]>0) {
         NSArray *KEYINDB = @[@"virtualCellPhone",@"workcell"];
        for (NSDictionary *item in arrPro0) {
            for (NSString *key in KEYINDB) {
                NSString *phonenumber = [item objectForKey:key];
                if (phonenumber != nil && ![phonenumber isEqual:[NSNull null]] && ![phonenumber isEqualToString:@""]) {
                    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:item,@"obj",key,@"kname", nil];
                    [self.sendMsgArray addObject:dictionary];
                    break;
                }
            }
        }
    }else{
      NSArray *arrPro1 = [[SharedDepartmentDB sharedInstance] recursiveGetDepartment:[departmentID integerValue]];
        if (arrPro1&&[arrPro1 count]>0) {
            for (NSDictionary *dic in arrPro1) {
                [self sendMsgArrayFresh:dic[@"deptid"]];
            }
        }
    }
    
}

-(void)loadInitedFunction
{
    self.title = @"所有单位";
    [self.unitsArray removeAllObjects];
    [self.unitsArray addObjectsFromArray:[SharedDepartmentDB sharedInstance].departmentDBArray];
}

- (void)loadDepartments:(NSDictionary *)departments withTitle:(NSString *)title
{
    [self.unitsArray removeAllObjects];
    NSArray *names = [departments objectForKey:@"subUnits"];
    for (int i=0;i<[names count];i++){
        //DLog(@"loadDepartments ++");
        [self.unitsArray addObject:[names objectAtIndex:i]];

    }
    self.departmentID = [departments objectForKey:@"deptid"];
    self.title = title;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *currentObj = [self.unitsArray objectAtIndex:indexPath.row];
    BOOL bLeaf = NO;
    if ([[currentObj objectForKey:@"subDeptCount"] intValue] > 0){
        bLeaf = NO;
    }else{
        bLeaf = YES;
    }
    DLog(@"subDeptCount is %d",[[currentObj objectForKey:@"subDeptCount"] intValue] );
    if (bLeaf) {
        Tab3NameListViewController *nameList = [[Tab3NameListViewController alloc] init];
        [nameList loadNameList:currentObj withTitle:[currentObj objectForKey:@"name"]];
        [self.navigationController pushViewController:nameList animated:YES];
    }
    else
    {
        Tab3ViewController *departments = [[Tab3ViewController alloc] init];
       
        [departments loadDepartments:currentObj withTitle:[currentObj objectForKey:@"name"]];
        [self.navigationController pushViewController:departments animated:YES];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    Tab3SearchResultViewController *searchResultVC = [[Tab3SearchResultViewController alloc]init];
    //searchResultVC.departmentID = self.departmentID;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}

@end
