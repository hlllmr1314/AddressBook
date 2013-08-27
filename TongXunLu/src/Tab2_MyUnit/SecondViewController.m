//
//  SecondViewController.m
//  TongXunLu
//
//  Created by QuanMai on 13-3-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SecondViewController.h"
#import "CfgManager.h"
#import "PersonDetailViewController.h"
#import "Tab2ViewController.h"
#import "BaiduMobStat.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize departmentID;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
    self.multipleChoosed = NO;
    [self.mutipleChoosedMap removeAllObjects];
    
    if (self.departmentID != [CfgManager getConfig:@"departmentID"]) {
        self.departmentID = [CfgManager getConfig:@"departmentID"];
            }
    if (self.departmentID != nil) {
        departmentDetail.departmentID = self.departmentID;

        self.tableView.hidden = NO;
        [self.scrollViewH bringSubviewToFront:self.tableView];
        
        [self refreshMyDepartment:self.departmentID];
        [self.tableView reloadData];
        DLog(@"second didchange:%@",self.departmentID);
        departmentDetail.departmentID = self.departmentID;
        [self showOrHideDepartmentViewButton:YES];
        [super showOrHideGroupMsgBtn:YES];
    }else
    {
        
        self.tableView.hidden = YES;
        warningView.hidden = NO;
        self.title = @"本部门";
        [self showOrHideDepartmentViewButton:NO];
        [super showOrHideGroupMsgBtn:NO];
    }
    
    DLog(@"self.departmentID:%@",self.departmentID);
    //[super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
}

-(void)refreshMyDepartment:(NSString *)dID
{
    [self.unitsArray removeAllObjects];
    [self.sendMsgArray removeAllObjects];

    NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where d.deptid = '%@' and a.deptid = d.deptid order by a.id asc",dID];
    FMResultSet *rs = [self.db executeQuery:sql];
    while ([rs next]){
        [self.unitsArray addObject:[rs resultDictionary]];
        
        NSDictionary *item = [rs resultDictionary];
        for (NSString *key in KEYINDB) {
            NSString *phonenumber = [item objectForKey:key];
            if (phonenumber != nil && ![phonenumber isEqual:[NSNull null]] && ![phonenumber isEqualToString:@""]) {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:item,@"obj",key,@"kname", nil];
                [self.sendMsgArray addObject:dictionary];
            }
        }
    }
    
    sql = [[NSString alloc] initWithFormat:@"SELECT departname FROM department where deptid = '%@'",dID];
    rs = [self.db executeQuery:sql];
    while ([rs next]){
        self.title = [rs stringForColumnIndex:0];
    }
}


-(void)showOrHideDepartmentViewButton:(BOOL)bShow
{
    if (bShow){
        //tframe.origin.y = initTableY + 45;
        //tframe.size.height = initTableHeight - 45;
        //self.tableView.frame = tframe;
        self.scrollViewH.contentSize = CGSizeMake(self.scrollViewH.frame.size.width *2, self.scrollViewH.frame.size.height);
        self.tableView.hidden = NO;
        warningView.hidden = YES;
        lBtn.hidden = NO;
        rBtn.hidden = NO;

        [self swithList];
        
    }else{
        CGRect tframe = self.tableView.frame;
        //tframe.origin.y = initTableY - 45;
        //tframe.size.height = initTableHeight + 45;
        self.tableView.frame = tframe;
        self.scrollViewH.contentSize = CGSizeMake(self.scrollViewH.frame.size.width, self.scrollViewH.frame.size.height);
        self.tableView.hidden = YES;
        warningView.hidden = NO;
        self.title = @"本部门";
        
        lBtn.hidden = YES;
        rBtn.hidden = YES;

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    warningView = [[UIView alloc]initWithFrame:self.scrollViewH.bounds];
    [self.scrollViewH addSubview:warningView];
   
    warningView.hidden = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, self.scrollViewH.frame.size.width, 15)];
    label.text = @"请先设置本部门";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorFromRGB(0x868686);
    [warningView addSubview:label];
   
    
    UIImageView *warningImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiyitu"]];
    [warningView addSubview:warningImage];
    warningImage.frame = CGRectMake((self.scrollViewH.frame.size.width-warningImage.frame.size.width )/2, 44+50, warningImage.frame.size.width, warningImage.frame.size.height);
   
    initTableY = self.tableView.frame.origin.y;
    initTableHeight = self.tableView.frame.size.height;
    departmentDetail.delegate = self;
}


-(void)swithList
{
    rBtn.selected = NO;
    lBtn.selected = YES;
    
    [self.scrollViewH scrollRectToVisible:CGRectMake(0, 0, self.scrollViewH.frame.size.width, self.scrollViewH.frame.size.height) animated:YES];
    
}
-(void)swithDetail
{
    rBtn.selected = YES;
    lBtn.selected = NO;
    [self.scrollViewH scrollRectToVisible:CGRectMake(self.scrollViewH.frame.size.width, 0, self.scrollViewH.frame.size.width, self.scrollViewH.frame.size.height) animated:YES];
    
}

    
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *currentObj = [self.unitsArray objectAtIndex:indexPath.row];
//    
//    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
//    [self.navigationController pushViewController:viewController animated:YES];
//    [viewController loadPersonDetailWithDict:currentObj];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    Tab2ViewController *searchResultVC = [[Tab2ViewController alloc]init];
    searchResultVC.departmentID = self.departmentID;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}


#pragma delegate
-(void)departmentOnCancel
{
    [self showOrHideDepartmentViewButton:NO];
    [super showOrHideGroupMsgBtn:NO];
}
@end
