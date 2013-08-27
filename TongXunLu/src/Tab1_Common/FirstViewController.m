//
//  FirstViewController.m
//  TongXunLu
//
//  Created by QuanMai on 13-3-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "FirstViewController.h"
#import "ColorbleLabel.h"
#import "PersonDetailViewController.h"
#import "FunctionButton.h"

#import "BaiduMobStat.h"
#import "CustomCell.h"
#import "Person.h"
#import "Department.h"
#import "NSManagedObject+SHM.h"
#import "Department.h"
#import "CommonUseViewController.h"

#import "MMSearchBar.h"

#import "Search2PersonViewController.h"
#import "GestureLock.h"
#import "DrawPatternLockViewController.h"

@interface FirstViewController ()

@end
 
@implementation FirstViewController
{
   
    MMSearchBar * _searchBar;
    UIImageView *_warningImage;
    UITableView *_table;
    NSArray *_arrParam;
    UILabel *label;
    
    PersonSearchDisplayController *searchDisplay;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"常用联系人";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    self.doMyself = YES;    
    [super viewDidLoad];
    self.title = @"常用联系人";
    if ([GestureLock sharedLock].onLock) {
        DrawPatternLockViewController *dpViewConPro = [[DrawPatternLockViewController alloc]init];
        dpViewConPro.typeLock = typeLockGo;
        [self.tabBarController presentModalViewController:dpViewConPro animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
    _arrParam = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"chanyong == %@",[NSNumber numberWithBool:YES]]  sortDescriptors:nil];
    self.dept = [Department objectByID:[NSNumber numberWithInt:0] createIfNone:NO];
    if (!_arrParam||[_arrParam count]==0) {
        [self myHaveNoPerson];
    }else{
        [self myHaveSomePerson];
        [_table reloadData];
    }
}


- (void)myHaveNoPerson
{
    [super itemBarinit:NO];
    if (!_searchBar) {
        _searchBar = [[MMSearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        
        _searchBar.backgroundImage = [UIImage imageNamed:@"navbar.png"];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
                
        searchDisplay = [[PersonSearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
        searchDisplay.dept = self.dept;
        searchDisplay.personDelegate = self;
        [self.view addSubview:_searchBar];
    }    
    _searchBar.placeholder = @"手机/名字/座机(共0位联系人)";
    
    if (!_warningImage) {
        _warningImage = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"changyongshouci"]  stretchableImageWithLeftCapWidth:1 topCapHeight:1 ]];
        // 240 300
        // self.view.backgroundColor =  UIColorFromRGB(0x868686);
        _warningImage.frame = CGRectMake(40, 65+15+3, 240, 300);
        
        [_warningImage setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:_warningImage];
        //    warningView = [[UIView alloc]initWithFrame:self.scrollViewH.bounds];
        //    [self.scrollViewH addSubview:warningView];
        //
        //    warningView.hidden = YES;
        //
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 320, 15)];
        label.text = @"请先设置常用联系人";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColorFromRGB(0x868686);
        [self.view addSubview:label];
    }
    
    if (_table) {
        _table.hidden = YES;
    }
    if (_warningImage) {
        _warningImage.hidden = NO;
    }
    if (label) {
        label.hidden = NO;
    }
    
    
}

- (void)myHaveSomePerson
{
    [super itemBarinit:YES];
    if (!_searchBar) {
        _searchBar = [[MMSearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        
        _searchBar.backgroundImage = [UIImage imageNamed:@"navbar.png"];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;        
        searchDisplay = [[PersonSearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
        searchDisplay.dept = self.dept;
        searchDisplay.personDelegate = self;
        [self.view addSubview:_searchBar];
        
    }
    _searchBar.placeholder = [NSString stringWithFormat:@"手机/名字/座机(共%d位联系人)",[self.dept.searchPersons count]];
    
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0,44, 320, self.view.frame.size.height-44)];
        _table.editing = NO;
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 1)];
        line.backgroundColor = _table.separatorColor;
        [self.view addSubview:line];
    }
    
    if (label) {
        label.hidden = YES;
    }
    if (_table) {
        _table.hidden = NO;
    }
    if (_warningImage) {
        _warningImage.hidden = YES;
    }
   
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
}
#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_arrParam count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellStyle style =  UITableViewCellStyleDefault;
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
    
    if (!cell){
        cell = [[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"];
    }
    ((CustomCell *)cell).cImageView.hidden = NO;
    ((CustomCell *)cell).multipleBtn.hidden = YES;
    
    
        Person *person = _arrParam[indexPath.row];
        ((CustomCell *)cell).cLabel1.text = person.username;
        ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"touxiang.png"];
        ((CustomCell *)cell).cLabel2.text = person.title;
        return cell;   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
        Person *person = _arrParam[indexPath.row];
        PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
        viewController.person = person;
        viewController.cancelChanyongBlock = ^(){
            [self.navigationController popViewControllerAnimated:YES];
        };
        [self.navigationController pushViewController:viewController animated:YES];
        return;
   
    
}

- (void)wantPush:(Person *)person
{
   
    self.hidesBottomBarWhenPushed = YES;   
    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
    viewController.person = person;
    viewController.thread = ContentThreadPrivate;
    viewController.cancelChanyongBlock = ^(){
        [searchDisplay setActive:NO];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:viewController animated:YES];
    return;
}

//-(void)loadUsedFromDB
//{
//    DLog(@"loadUsedFromDB");
////    [self.unitsArray removeAllObjects];
////    [self.sendMsgArray removeAllObjects];
//    
////    NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
//     NSArray *KEYINDB = @[@"shortphone",@"workcell"];
//    NSString *sql = [[NSString alloc] initWithFormat:GET_COMMON_USERS];
////    FMResultSet *rs = [self.db executeQuery:sql];
////    while ([rs next]){
////        [self.unitsArray addObject:[rs resultDictionary]];
////        
////        NSDictionary *item = [rs resultDictionary];
////        for (NSString *key in KEYINDB) {
////            NSString *phonenumber = [item objectForKey:key];
////            if (phonenumber != nil && ![phonenumber isEqual:[NSNull null]] && ![phonenumber isEqualToString:@""]) {
////                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:item,@"obj",key,@"kname", nil];
////                [self.sendMsgArray addObject:dictionary];
////            }
////        }
////    }
//}


//- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    UITableViewCellStyle style =  UITableViewCellStyleDefault;
//    CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
//    if (!cell){
//        cell = [[[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
//    }
//    NSArray *currentArray = self.unitsArray;
//    NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
//    
//    cell.cLabel1.text = [currentObj objectForKey:@"name"];
//    cell.cLabel2.text = [currentObj objectForKey:@"jobname"];
//    cell.cImageView.image = [UIImage imageNamed:@"touxiang.png"];
//
//    return cell;
//
//}

//- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	//NSDictionary *currentObj = [self.unitsArray objectAtIndex:indexPath.row];
//    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
//    viewController.cancelWithPopBack = YES;
//    
//    //取消常用按钮
////    FunctionButton *rightButton = [[FunctionButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
////    [rightButton setImage:[UIImage imageNamed:@"quxiaochangyong.png"] forState:UIControlStateNormal];
////    [rightButton addTarget:self action:@selector(deleteMyCommonUsed:) forControlEvents:UIControlEventTouchUpInside];
////    rightButton.index = [[currentObj objectForKey:@"id"] intValue];
////    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
////    [rightButton release];
////    viewController.navigationItem.rightBarButtonItem = rightItem;
////    [rightItem release];
//    
//    [self.navigationController pushViewController:viewController animated:YES];
//    
//    //[viewController loadPersonDetailWithDict:currentObj];
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       Person *person = _arrParam[indexPath.row];
        
        [((Department *)[Department objectByID:[NSNumber numberWithInt:0] createIfNone:NO]).searchPersonsSet removeObject:person];
        //[deptChanyong.searchPersonsSet addObject:_person];
        person.chanyongValue = NO;
        [[SHMData sharedData] saveContext];
        _arrParam = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"chanyong == %@",[NSNumber numberWithBool:YES]]  sortDescriptors:nil];
        self.dept = [Department objectByID:[NSNumber numberWithInt:0] createIfNone:NO];
        if (!_arrParam||[_arrParam count]==0) {
            [self myHaveNoPerson];
        }else{
            //[self myHaveSomePerson];
            [_table reloadData];
        }
    }

}

//-(void)deleteMyCommonUsed:(FunctionButton *)button
//{
//    [self deleteCommonusedByID:button.index];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)deleteCommonusedByID:(int)cid
//{
//    NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
//    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
//    if (![db open]) {
//        NSLog(@"Could not open db.");
//        return;
//    }
//    
//    //NSString *sql = [[[NSString alloc] initWithFormat:@"UPDATE address_list set bcommon=0 WHERE id = '%d'",cid] autorelease];
//    NSString *sql = [[NSString alloc] initWithFormat:@"DELETE FROM commonused_list WHERE id = '%d';",cid];
//    
//    DLog(@"deleted %d\nsql:%@",cid,sql);
//    if([db executeUpdate:sql])
//    {
//        sql = [[NSString alloc] initWithFormat:@"UPDATE address_list set bcommon=0 WHERE id = '%d';",cid];
//        [db executeUpdate:sql];
//        [[QAlertView sharedInstance] showAlertText:@"操作成功!" fadeTime:2];
//    }
//    [db close];
//   
//}

//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar endEditing:YES];
//    CommonUseViewController *searchResultVC = [[CommonUseViewController alloc]init];
//    searchResultVC.dept = self.dept;
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:searchResultVC animated:YES];
//    return;
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


@end
