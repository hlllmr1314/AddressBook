//
//  Search2PersonViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-21.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Search2PersonViewController.h"
#import "SearchCell.h"
#import "Person.h"
#import "SearchIndex.h"
#import "PersonDetailViewController.h"



@interface Search2PersonViewController ()
{
  
    UIImageView *tutorialView;
    //int threadCount;
    //BOOL inThread;
    dispatch_semaphore_t semaphore;
    NSConditionLock *conditionLock;
    NSRecursiveLock *theLock;
    Boolean isPoped;
}

@end

@implementation Search2PersonViewController
{
    NSPredicate *predicate;
    
    NSMutableDictionary *dicPerson;
    NSMutableArray *arrPersonResult;
    NSMutableArray *arrPhone3Pro;
    NSMutableArray *arrPhone4Pro;
    NSRange range;
    NSArray *personIds;
   
}
@synthesize preSearchText = preSearchText;
@synthesize searchResultCountL = searchResultCountL;
@synthesize arrPersonResult = arrPersonResult;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        preSearchText = @"";
        //        NSString *regex0 = @"[0]";
        //        NSString *regex1 = @"[1]";
        //        NSString *regex2 = @"[2A-Ca-c]";
        //        NSString *regex3 = @"[3D-Fd-f]";
        //        NSString *regex4 = @"[4G-Ig-i]";
        //        NSString *regex5 = @"[5J-Lj-l]";
        //        NSString *regex6 = @"[6M-Om-o]";
        //        NSString *regex7 = @"[7P-Sp-s]";
        //        NSString *regex8 = @"[8T-Vt-v]";
        //        NSString *regex9 = @"[9W-Zw-z]";
        //        _correspondRegex = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:regex0,regex1,regex2,regex3,regex4,regex5,regex6,regex7,regex8,regex9, nil]
        //                                                        forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self searchInit];
    [self searchCountLab];
    
    [self tableviewInit];
    
    [self keyboard];
    [[KeyboardView sharedKeyBoard] KeyboardPullDown];
    [self addNilImage:YES];
  //  conditionLock = [[NSConditionLock alloc] init];
    theLock = [[NSRecursiveLock alloc] init];
   // semaphore = dispatch_semaphore_create(0);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    dispatch_release(semaphore);
    predicate = nil;
    
    dicPerson = nil;
    arrPersonResult = nil;
    arrPhone3Pro = nil;
    tutorialView = nil;
    personIds = nil;
    preSearchText = nil;
    searchResultCountL = nil;
    arrPersonResult = nil;
    conditionLock = nil;
    theLock = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isPoped) {
        [KeyboardView resetKeyboard];
    }else{
        isPoped = NO;
    }
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  //  [[SearchIndex sharedIndexs] initArrs];
//    NSPredicate* predicate;
//  //  NSArray *arrayPro  = @[@"firstPinyinNum",@"firstPinyinNum1",@"firstPinyinNum2"];
//    predicate = [NSPredicate predicateWithFormat:@"firstPinyinNum like %@ or firstPinyinNum1 like %@ or firstPinyinNum2 like %@",@"2*",@"2*",@"2*"];
//    [searchNameArr addObjectsFromArray:[[_dept.searchPersons filteredSetUsingPredicate:predicate] allObjects]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[KeyboardView sharedKeyBoard] KeyboardPullDown];
    
}

- (void)searchInit
{
    arrPersonResult = [[NSMutableArray alloc] initWithCapacity:5000];
    arrPhone3Pro = [[NSMutableArray alloc] initWithCapacity:3000];
    arrPhone4Pro = [[NSMutableArray alloc] initWithCapacity:200];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchCountLab
{
    searchResultCountL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    searchResultCountL.backgroundColor = [UIColor colorWithRed:0.7451 green:0.8824 blue:0.9725 alpha:1];
    searchResultCountL.font = [UIFont systemFontOfSize:15];
    searchResultCountL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:searchResultCountL];
    
    searchResultCountL.text = @"0条搜索结果";
}

- (void)keyboard
{
    [self.view addSubview:[KeyboardView sharedKeyBoard]];
    [KeyboardView sharedKeyBoard].delegate = self;
    
}

- (void)tableviewInit
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-50-20-44)];
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
}

- (void)addNilImage:(Boolean)hidenTable
{
    if (!tutorialView) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIImage *tutorialImg = [UIImage imageNamed:@"viewTutorial.png"];
        tutorialView = [[UIImageView alloc] initWithImage:tutorialImg];
        tutorialView.frame = CGRectMake((self.view.bounds.size.width - tutorialImg.size.width*0.45)/2, -3.0f, tutorialImg.size.width*0.45,  tutorialImg.size.height*0.45);        
        [self.view addSubview:tutorialView];
    }
    _table.hidden = hidenTable;
    tutorialView.hidden = !hidenTable;
    
}





- (void)KeyboardViewDidPressedKeyChanged:(NSString *)searchText
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [theLock lock];
         dispatch_sync(dispatch_get_main_queue(),^{
    if (searchText.length<=0) {
        preSearchText = @"";
        [self addNilImage:YES];
        searchResultCountL.text = @"0条搜索结果";
       
    }else if(preSearchText.length == 0){
        [self addNilImage:NO];
    }
              });
        [theLock unlock];
    });
    if (searchText.length<=0) {
        return;
    }
    searchText = [[SearchIndex sharedIndexs] convertToNum:searchText];
           
  //  CGFloat time1111 = BNRTimeBlock(^{
   
        if (searchText.length == 1) {
            predicate = [self predicateNum1:searchText];
        }
        if (searchText.length == 2) {
            predicate = [self predicateNum2:searchText];
        }
        if (searchText.length == 3) {
            
            if (preSearchText.length > searchText.length) {
                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                      [theLock lock];
                      self.table.scrollEnabled = NO;
                [arrPersonResult removeAllObjects];
                [arrPersonResult addObjectsFromArray:arrPhone3Pro];
                       
                       dispatch_sync(dispatch_get_main_queue(),^{
                searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[arrPersonResult count]];
                preSearchText = searchText;
               
                        [_table reloadData];
                   
                            });
                      self.table.scrollEnabled = YES;
                      [theLock unlock];
                  });
                return;
            }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [theLock lock];
            self.table.scrollEnabled = NO;
           
            [arrPhone3Pro removeAllObjects];
            [arrPersonResult removeAllObjects];
            [arrPhone3Pro addObjectsFromArray:[Person objectArrayByPredicate:[self predicateNum1:searchText] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] thread:1]];
           // NSLog(@"arrPhone3Pro%d",arrPhone3Pro.count);
            [arrPersonResult addObjectsFromArray:arrPhone3Pro];
                 dispatch_sync(dispatch_get_main_queue(),^{
                 searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[arrPhone3Pro count]];
                 preSearchText = searchText;
                    
                             [_table reloadData];
                      
                 });
            self.table.scrollEnabled = YES;
             [theLock unlock];
             });
            
            return;
           // predicate = [self predicateNum3:searchText];
        }
    
    if (searchText.length == 4) {
        
        if (preSearchText.length > searchText.length) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [theLock lock];
                self.table.scrollEnabled = NO;
                [arrPersonResult removeAllObjects];
                [arrPersonResult addObjectsFromArray:arrPhone4Pro];
                
                dispatch_sync(dispatch_get_main_queue(),^{
                    searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[arrPersonResult count]];
                    preSearchText = searchText;
                    
                    [_table reloadData];
                    
                });
                self.table.scrollEnabled = YES;
                [theLock unlock];
            });
            return;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [theLock lock];
            self.table.scrollEnabled = NO;
            
            [arrPhone4Pro removeAllObjects];
            [arrPersonResult removeAllObjects];
            [arrPhone4Pro addObjectsFromArray:[Person objectArrayByPredicate:[self predicateNum3:searchText] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] thread:1]];
            // NSLog(@"arrPhone3Pro%d",arrPhone3Pro.count);
            [arrPersonResult addObjectsFromArray:arrPhone4Pro];
            dispatch_sync(dispatch_get_main_queue(),^{
                searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[arrPersonResult count]];
                preSearchText = searchText;
                
                [_table reloadData];
                
            });
            self.table.scrollEnabled = YES;
            [theLock unlock];
        });
        
        return;
        // predicate = [self predicateNum3:searchText];
    }
    
    
        if (searchText.length > 4) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [theLock lock];
               self.table.scrollEnabled = NO;
            [arrPersonResult removeAllObjects];
            [arrPersonResult addObjectsFromArray:[arrPhone4Pro filteredArrayUsingPredicate:[self predicateNum3:searchText]]];
            
            dispatch_sync(dispatch_get_main_queue(),^{
            searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[arrPersonResult count]];
            preSearchText = searchText;
                 
                        [_table reloadData];
               
                                    });
                self.table.scrollEnabled = YES;
                 [theLock unlock];
           });
           
            return;
            //[arrPersonResult addObjectsFromArray:];
        }
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [theLock lock];
             self.table.scrollEnabled = NO;
               [arrPersonResult removeAllObjects];
         range = NSMakeRange(0, 50);
      NSArray *arr = [Person objectArrayByPredicate:predicate sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:0 limit:50 thread:1];
        if ([arr count]<50) {
            range.length = arr.count;
        }
        [arrPersonResult addObjectsFromArray:arr];
   
         dispatch_sync(dispatch_get_main_queue(),^{
             
    if (range.length >= 50) {
        searchResultCountL.text = @">50条搜索结果";
    }else{
        searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",range.length];
    }
 //   NSLog(@"time1111%f",time1111);
     preSearchText = searchText;
             
                     [_table reloadData];
             
                });
              self.table.scrollEnabled = YES;
              [theLock unlock];
              });
  //      });
    return;
//    //CGFloat time = BNRTimeBlock(^{
//         personIds = [[SearchIndex sharedIndexs] idsFromOne:searchText deptId:_dept.id];
//   // });
//  //  NSLog (@"isEqual: time0: %f\n", time);
//    
//           
//    if ([personIds count]>1000) {
//         searchResultCountL.text = @">1000条搜索结果";
//    }else{
//         searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[personIds count]];
//    }
//            NSArray *personIdsPro;
//            range = NSMakeRange(0, 20);
//            [self rangRenew];
//            personIdsPro = [personIds subarrayWithRange:range];
//    // CGFloat time1 = BNRTimeBlock(^{
//            NSArray *persons2 = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", personIdsPro] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
//          [arrPersonResult addObjectsFromArray:persons2];
//  //   });
//           
   //  NSLog (@"isEqual: time1: %f\n", time1);
   //  preSearchText = searchText;
   //  [_table reloadData];
    return;
}

- (NSPredicate*)predicateNum1:(NSString *)searchText
{
    
    return [NSPredicate predicateWithFormat:@"( firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ ) and depart.id like %@",searchText,searchText,searchText,[NSString stringWithFormat:@"%@*",_dept.id]];
}

- (NSPredicate*)predicateNum3:(NSString *)searchText
{
    
    return [NSPredicate predicateWithFormat:@"( firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ or pinyinNum CONTAINS %@ or pinyinNum1 CONTAINS %@ or pinyinNum2 CONTAINS %@ or homePhone CONTAINS %@ or personalCellPhone CONTAINS %@ or shortNum CONTAINS %@ or shortNum2 CONTAINS %@ or virtualCellPhone CONTAINS %@ or workCellPhone CONTAINS %@ or workingPhone CONTAINS %@ or workPhone2 CONTAINS %@ ) and depart.id like %@",searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,[NSString stringWithFormat:@"%@*",_dept.id]];
}

- (NSPredicate*)predicateNum2:(NSString *)searchText
{
    //NSString *searchText2 = [NSString stringWithFormat:@"%@*",searchText];
    return [NSPredicate predicateWithFormat:@"( firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ or pinyinNum CONTAINS %@ or pinyinNum1 CONTAINS %@ or pinyinNum2 CONTAINS %@ )and depart.id like %@",searchText,searchText,searchText,searchText,searchText,searchText,[NSString stringWithFormat:@"%@*",_dept.id]];
}

- (NSPredicate*)predicate:(NSArray *)arrayPro searchText:(NSString *)searchText isLike:(Boolean)isLike
{
    if (isLike) {
        searchText = [NSString stringWithFormat:@"%@*",searchText];
    }
  
    NSMutableString *mutStr = [[NSMutableString alloc]initWithCapacity:[arrayPro count]];
    for (int i=0; i<[arrayPro count]; i++) {
        if (i==0) {
            [mutStr appendFormat:@"%@ %@ %@",arrayPro[i],isLike?@"like":@"match",searchText];
            continue;
        }
        [mutStr appendFormat:@" or %@ %@ %@",arrayPro[i],isLike?@"like":@"match",searchText];
    }
    //NSString *strFormat = mutStr;
    return [NSPredicate predicateWithFormat:mutStr ];
}


- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrPersonResult count];
}


- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"Cell";
  
    SearchCell *cell = (SearchCell*)[_tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.imagetouxiang.image = [UIImage imageNamed:@"touxiang"];
		cell.selectionStyle=UITableViewCellSelectionStyleBlue;
	}
   // PersonIndex *person = arrPersonResult[indexPath.row];
    
    Person *person = (Person *)arrPersonResult[indexPath.row];//[Person objectByKey:@"id" value:((PersonIndex *)arrPersonResult[indexPath.row]).id createIfNone:NO];
    
    cell.lableName.text = person.username;
    NSDictionary *dicPro = [[SearchIndex sharedIndexs] pinyinStr_index:person searchText:preSearchText];
    [cell.lablePinYin setText:dicPro[@"str"] matchPos:dicPro[@"arr"]];
    
    cell.lableJob.text = [self pareDepartName:person.depart];
     NSDictionary *dicPro2 = [[SearchIndex sharedIndexs] phoneStr_index:person searchText:preSearchText];
    [cell.lablePhone setText:dicPro2[@"str"] matchPos:dicPro2[@"arr"]];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!tableView.scrollEnabled) {
        return;
    }
        isPoped = YES;
        Person *person = (Person *)self.arrPersonResult[indexPath.row];
        PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
        viewController.person = person;
        viewController.thread = ContentThreadPrivate;
        [self.navigationController pushViewController:viewController animated:YES];   
    
}




#pragma mark - scrollView

- (void)rangRenew
{
    if (range.location+range.length>[personIds count]) {
        range.length = [personIds count]-range.location;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         
    if (preSearchText.length>=3) {
        return;
    }
    
    if (indexPath.row+2>[arrPersonResult count]) {
        if (range.length<50) {
            return;
        }
        
        
        [theLock lock];
            range.location =[arrPersonResult count] - 1;
            [self rangRenew];
        NSArray *nextPersons2 = [Person objectArrayByPredicate:predicate
                                               sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]] offSet:range.location limit:range.length thread:1];
        if ([nextPersons2 count]<50) {
            range.length = [nextPersons2 count];
        }
        [arrPersonResult addObjectsFromArray:nextPersons2];
        dispatch_sync(dispatch_get_main_queue(), ^{[_table reloadData];});
             [theLock unlock];
    }});
        return;
    
            //range.location+=20;
            if (range.location+range.length>=[personIds count]) {
                return;
            }
        range.location+=20;
        
        [self rangRenew];
        
        NSArray *nextPersonIds = [personIds subarrayWithRange:range];
        if (!nextPersonIds) {
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
        NSArray *nextPersons2 = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", nextPersonIds] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
        [arrPersonResult addObjectsFromArray:nextPersons2];
            dispatch_sync(dispatch_get_main_queue(), ^{[_table reloadData];});
        });
    
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{        
          dispatch_sync(dispatch_get_main_queue(), ^{
    if (![KeyboardView sharedKeyBoard].didPullDown) {
        [[KeyboardView sharedKeyBoard] KeyboardPullDown];
    }
              });
         
     });
}
@end
