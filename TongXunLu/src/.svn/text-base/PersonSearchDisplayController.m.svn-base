//
//  PersonSearchDisplayController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-19.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "PersonSearchDisplayController.h"
#import "Person.h"
#import "MMSearchBar.h"
#import "SearchCell.h"
#import "SearchIndex.h"
#import "PersonDetailViewController.h"

@implementation PersonSearchDisplayController
{
    UILabel *searchResultCountL;
    NSMutableArray *arrResult;
    NSString *searchStringJustNow;
    NSRecursiveLock *theLock;
}

- (id)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController
{
    if (self = [super initWithSearchBar:searchBar contentsController:viewController]) {
        self.delegate = self;
        self.searchResultsDataSource = self;
        self.searchResultsDelegate = self;
        // searchBar.delegate = self;
        arrResult = [[NSMutableArray alloc]initWithCapacity:100];
        
        searchResultCountL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        searchResultCountL.backgroundColor = [UIColor colorWithRed:0.7451 green:0.8824 blue:0.9725 alpha:1];
        searchResultCountL.font = [UIFont systemFontOfSize:15];
        searchResultCountL.textAlignment = NSTextAlignmentCenter;
        searchResultCountL.text = @"0条搜索结果";
        
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"Cell";
    
    SearchCell *cell = (SearchCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.imagetouxiang.image = [UIImage imageNamed:@"touxiang"];
		cell.selectionStyle=UITableViewCellSelectionStyleBlue;
	}
    // PersonIndex *person = arrPersonResult[indexPath.row];
    
    Person *person = (Person *)arrResult[indexPath.row];//[Person objectByKey:@"id" value:((PersonIndex *)arrPersonResult[indexPath.row]).id createIfNone:NO];
    cell.lableJob.text = [self pareDepartName:person.depart];
    
    if ([self haveChina:searchStringJustNow]) {
        NSDictionary *dicPro = [[SearchIndex sharedIndexs] userNameStr_index:person searchText:searchStringJustNow];
        [cell.lableName setText:person.username matchPos:dicPro[@"arr"]];
        
        cell.lablePinYin.matchPos = nil;
        cell.lablePinYin.text = person.pinyin;
        
        cell.lablePhone.matchPos = nil;
        cell.lablePhone.text = [NSString stringWithFormat:@"%d个电话",[[person arrAllDicPhones] count]];
    }else if(![self isPureInt:searchStringJustNow]){
        cell.lableName.matchPos = nil;
        cell.lableName.text = person.username;
        
        NSDictionary *dicPro = [[SearchIndex sharedIndexs] pinyinNotIntStr_index:person searchText:searchStringJustNow];
        [cell.lablePinYin setText:dicPro[@"str"] matchPos:dicPro[@"arr"]];
        
        cell.lablePhone.matchPos = nil;
        cell.lablePhone.text = [NSString stringWithFormat:@"%d个电话",[[person arrAllDicPhones] count]];
    }else{
        cell.lableName.matchPos = nil;
        cell.lableName.text = person.username;
        NSDictionary *dicPro = [[SearchIndex sharedIndexs] pinyinStr_index:person searchText:searchStringJustNow];
        [cell.lablePinYin setText:dicPro[@"str"] matchPos:dicPro[@"arr"]];
        NSDictionary *dicPro2 = [[SearchIndex sharedIndexs] phoneStr_index:person searchText:searchStringJustNow];
        [cell.lablePhone setText:dicPro2[@"str"] matchPos:dicPro2[@"arr"]];
    }    
    return cell;
}

- (NSString *)pareDepartName:(Department *)depart
{
    if (!depart.parentDept.name.length) {
        return depart.name;
    }else{
        return [self pareDepartName:depart.parentDept];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return searchResultCountL;
}


//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    
//    self.searchResultsTableView.frame = CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT-20-44);
//    if (!_dept) {
//        searchResultCountL.text = @"0条搜索结果";
//        [self.searchResultsTableView reloadData];
//        return;
//    }
//    
//    if (!searchText.length) {
//        return;
//    }
//    
//    @synchronized(arrResult){
//        [arrResult removeAllObjects];
//    }
//    if (!theLock) {
//        theLock = [[NSRecursiveLock alloc] init];
//    }
//    
//    searchStringJustNow = searchText;
//    if ([self haveChina:searchText]) {
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [theLock lock];
//            self.searchResultsTableView.scrollEnabled = NO;
//            if (![searchStringJustNow isEqualToString:searchText]) {
//                [theLock unlock];
//                return;
//            }
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and username contains %@",_dept,searchText];
//            NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
//            if (![searchStringJustNow isEqualToString:searchText]) {
//                [theLock unlock];
//                return;
//            }
//            @synchronized(arrResult){
//                [arrResult addObjectsFromArray:arrPro];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
//                NSLog(@"%@",self.searchResultsTableView);
//                @synchronized(arrResult){
//                    [self.searchResultsTableView reloadData];
//                }
//                self.searchResultsTableView.scrollEnabled = YES;
//                NSLog(@"...");
//                
//            });
//            [theLock unlock];
//        });
//        
//        return;
//    }
//    
//    
//    
//    if (((MMSearchBar *)self.searchBar).searchKeyboardtype == SearchKeyboardtypeDefault) {
//        if (![self isPureInt:searchText]) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSLog(@"lock");
//                //  [arrResult removeAllObjects];
//                [theLock lock];
//                self.searchResultsTableView.scrollEnabled = NO;
//                if (![searchStringJustNow isEqualToString:searchText]) {
//                    [theLock unlock];
//                    return;
//                }
//                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and pinyin4Search contains %@",_dept,searchText];
//                NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
//                if (![searchStringJustNow isEqualToString:searchText]) {
//                    [theLock unlock];
//                    return;
//                }
//                @synchronized(arrResult){
//                    [arrResult addObjectsFromArray:arrPro];
//                }
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
//                    @synchronized(arrResult){
//                        [self.searchResultsTableView reloadData];
//                    }
//                    self.searchResultsTableView.scrollEnabled = YES;
//                    NSLog(@"...");
//                    
//                });
//                [theLock unlock];
//            });
//            return;
//        }
//        if ([self isPureInt:searchText]) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSLog(@"lock");
//                
//                [theLock lock];
//                self.searchResultsTableView.scrollEnabled = NO;
//                if (![searchStringJustNow isEqualToString:searchText]) {
//                    [theLock unlock];
//                    return;
//                }
//                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and phoneNum4Search contains %@",_dept,searchText];
//                NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
//                if (![searchStringJustNow isEqualToString:searchText]) {
//                    [theLock unlock];
//                    return;
//                }
//                @synchronized(arrResult){
//                    [arrResult addObjectsFromArray:arrPro];
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
//                    @synchronized(arrResult){
//                        [self.searchResultsTableView reloadData];
//                    }
//                    self.searchResultsTableView.scrollEnabled = YES;
//                    NSLog(@"...");
//                    
//                });
//                [theLock unlock];
//            });
//        }
//    }
//    return;
//}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   
  //  return YES;
    if (!_dept) {
        searchResultCountL.text = @"0条搜索结果";
    //    [controller.searchResultsTableView reloadData];
        return YES;
    }
    
    if (!searchString.length) {
        return YES;
    }
    searchString = [searchString lowercaseString];
    @synchronized(arrResult){
        [arrResult removeAllObjects];
    }    
    if (!theLock) {
        theLock = [[NSRecursiveLock alloc] init];
    }
   
    searchStringJustNow = searchString;
    if ([self haveChina:searchString]) {       
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [theLock lock];
            controller.searchResultsTableView.scrollEnabled = NO;
            if (![searchStringJustNow isEqualToString:searchString]) {
                [theLock unlock];
                return;
            }
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and username contains %@",_dept,searchString];
            NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
            if (![searchStringJustNow isEqualToString:searchString]) {
                [theLock unlock];
                return;
            }
            @synchronized(arrResult){
                [arrResult addObjectsFromArray:arrPro];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
                @synchronized(arrResult){
                    [controller.searchResultsTableView reloadData];
                }
                controller.searchResultsTableView.scrollEnabled = YES;
                NSLog(@"...");
                                 
            });
           [theLock unlock];
        });
        
        return YES;
    }
    
    
    
    if (((MMSearchBar *)self.searchBar).searchKeyboardtype == SearchKeyboardtypeDefault) {
        if (![self isPureInt:searchString]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"lock");
              //  [arrResult removeAllObjects];
                [theLock lock];
                controller.searchResultsTableView.scrollEnabled = NO;
                if (![searchStringJustNow isEqualToString:searchString]) {
                    [theLock unlock];
                    return;
                }
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and pinyin4Search contains %@",_dept,[searchString lowercaseString]];
                NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
                if (![searchStringJustNow isEqualToString:searchString]) {
                    [theLock unlock];
                    return;
                }
                @synchronized(arrResult){
                    [arrResult addObjectsFromArray:arrPro];
                }
                 
                dispatch_async(dispatch_get_main_queue(), ^{
                    searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
                    @synchronized(arrResult){
                     [controller.searchResultsTableView reloadData];
                    }
                    controller.searchResultsTableView.scrollEnabled = YES;
                    NSLog(@"...");
                    
                });
               [theLock unlock];
            });
            return YES;
        }
        if ([self isPureInt:searchString]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"lock");
               
                [theLock lock];
                controller.searchResultsTableView.scrollEnabled = NO;
                if (![searchStringJustNow isEqualToString:searchString]) {
                    [theLock unlock];
                    return;
                }
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"superDeparts CONTAINS %@ and phoneNum4Search contains %@",_dept,searchString];
                NSArray *arrPro = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
                if (![searchStringJustNow isEqualToString:searchString]) {
                    [theLock unlock];
                    return;
                }
                @synchronized(arrResult){
                    [arrResult addObjectsFromArray:arrPro];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    searchResultCountL.text = [arrResult count]>=50?@">50条搜索结果":[NSString stringWithFormat:@"%d条搜索结果",[arrResult count]];
                    @synchronized(arrResult){
                    [controller.searchResultsTableView reloadData];
                    }
                    controller.searchResultsTableView.scrollEnabled = YES;
                    NSLog(@"...");
                    
                });
                [theLock unlock];
            });
        }
    }
    return YES;
}


- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    @synchronized(arrResult){
        [_personDelegate wantPush:(Person *)arrResult[indexPath.row]];
    }
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    }

- (BOOL)haveChina:(NSString *)searchText
{
    NSString *str = searchText;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isPureInt:(NSString *)searchText{
    NSScanner* scan = [NSScanner scannerWithString:searchText];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
