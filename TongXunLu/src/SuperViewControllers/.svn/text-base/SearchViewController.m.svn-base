//
//  SearchViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultCell.h"
#import "PersonDetailViewController.h"
#import "txlTabBarController.h"
#import "BaiduMobStat.h"

@interface SearchViewController ()

@end



@implementation SearchViewController
@synthesize tableView;
@synthesize filteredArray, allUnitArray;
@synthesize needSearchDB, db;
@synthesize searchStartPos;
@synthesize multipleChoosed, multipleChooseEnable, mutipleChoosedMap;



- (id)init
{
    self = [super init];
    if (self) {
        SEARCH_STEP = 1;
        nowSearchText = nil;
        self.hidesBottomBarWhenPushed = YES;
        histroyTypedWords = [[NSMutableArray alloc]initWithCapacity:10];
        self.mutipleChoosedMap= [[NSMutableDictionary alloc]initWithCapacity:10];
        self.allUnitArray = [[NSMutableArray alloc]initWithCapacity:100];
        self.filteredArray = [[NSMutableArray alloc]initWithCapacity:100];
        nowRegexDict = [[NSMutableDictionary alloc]init];
        
        needSearchDB = YES;
        bUpdatedScroll = NO;
        
        self.departmentID = @"";
        
        letterDict = [[NSMutableDictionary alloc] init];
        [letterDict setObject:@"2" forKey:@"A"];
        [letterDict setObject:@"2" forKey:@"B"];
        [letterDict setObject:@"2" forKey:@"C"];
        [letterDict setObject:@"3" forKey:@"D"];
        [letterDict setObject:@"3" forKey:@"E"];
        [letterDict setObject:@"3" forKey:@"F"];
        [letterDict setObject:@"4" forKey:@"G"];
        [letterDict setObject:@"4" forKey:@"H"];
        [letterDict setObject:@"4" forKey:@"I"];
        [letterDict setObject:@"5" forKey:@"J"];
        [letterDict setObject:@"5" forKey:@"K"];
        [letterDict setObject:@"5" forKey:@"L"];
        [letterDict setObject:@"6" forKey:@"M"];
        [letterDict setObject:@"6" forKey:@"N"];
        [letterDict setObject:@"6" forKey:@"O"];
        [letterDict setObject:@"7" forKey:@"P"];
        [letterDict setObject:@"7" forKey:@"Q"];
        [letterDict setObject:@"7" forKey:@"R"];
        [letterDict setObject:@"7" forKey:@"S"];
        [letterDict setObject:@"8" forKey:@"T"];
        [letterDict setObject:@"8" forKey:@"U"];
        [letterDict setObject:@"8" forKey:@"V"];
        [letterDict setObject:@"9" forKey:@"W"];
        [letterDict setObject:@"9" forKey:@"X"];
        [letterDict setObject:@"9" forKey:@"Y"];
        [letterDict setObject:@"9" forKey:@"Z"];
        
        
        NSString *regex0 = @"[0]";
        NSString *regex1 = @"[1]";
        NSString *regex2 = @"[2A-Ca-c]";
        NSString *regex3 = @"[3D-Fd-f]";
        NSString *regex4 = @"[4G-Ig-i]";
        NSString *regex5 = @"[5J-Lj-l]";
        NSString *regex6 = @"[6M-Om-o]";
        NSString *regex7 = @"[7P-Sp-s]";
        NSString *regex8 = @"[8T-Vt-v]";
        NSString *regex9 = @"[9W-Zw-z]";
        _correspondRegex = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:regex0,regex1,regex2,regex3,regex4,regex5,regex6,regex7,regex8,regex9, nil]
                                                        forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
        
        
        
        NSString *glob0 = @"[0]";
        NSString *glob1 = @"[1]";
        NSString *glob2 = @"[2ABCabc]";
        NSString *glob3 = @"[3DEFdef]";
        NSString *glob4 = @"[4GHIghi]";
        NSString *glob5 = @"[5JKLjkl]";
        NSString *glob6 = @"[6MNOmno]";
        NSString *glob7 = @"[7PQRSpqrs]";
        NSString *glob8 = @"[8TUVtuv]";
        NSString *glob9 = @"[9WXYZwxyz]";
        _correspondGlob = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:glob0,glob1,glob2,glob3,glob4,glob5,glob6,glob7,glob8,glob9, nil]
                                                       forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
        
        NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
        self.db = [[FMDatabase alloc] initWithPath:dbPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_HEIGHT - 64);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 890;
    [btn setImage:[UIImage imageNamed:@"btn_sendgroupmsg"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_sendgroupfinished"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(0, 0, 64, 30);
    [btn addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
   
    sendMSGBtn = btn;
    sendMSGBtn.hidden = YES;
    
    msgReceiveView = [[MsgReceiveView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [self.view addSubview:msgReceiveView];
   
    msgReceiveView.vController = self;
    
    searchResultCountL = [[UILabel alloc]initWithFrame:CGRectMake(0, msgReceiveView.frame.size.height, self.view.frame.size.width, 20)];
    searchResultCountL.backgroundColor = [UIColor colorWithRed:0.7451 green:0.8824 blue:0.9725 alpha:1];
    searchResultCountL.font = [UIFont systemFontOfSize:15];
    searchResultCountL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:searchResultCountL];
   
    searchResultCountL.text = @"0条搜索结果";

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, searchResultCountL.frame.size.height-1, searchResultCountL.frame.size.width, 1)];
    [searchResultCountL addSubview:line];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height - 69)];
    
	tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
   
    line.backgroundColor = self.tableView.separatorColor;
    
    [self.view addSubview:[KeyboardView sharedKeyBoard]];
    [KeyboardView sharedKeyBoard].delegate = self;
    [KeyboardView resetKeyboard];
    
    
    //2013-04-28 新增
    UIImage *tutorialImg = [UIImage imageNamed:@"viewTutorial.png"];
    tutorialView = [[UIImageView alloc] initWithImage:tutorialImg];
    tutorialView.frame = CGRectMake((self.view.bounds.size.width - tutorialImg.size.width*0.45)/2, -3.0f, tutorialImg.size.width*0.45,  tutorialImg.size.height*0.45);
    
    [self.view addSubview:tutorialView];
    
   
    //先隐藏搜索条相关界面
    [self displayTutorialImage:YES];
}

-(void)resetMsgReceiveFrame
{
    [UIView animateWithDuration:0.3 animations:^{
         searchResultCountL.frame = CGRectMake(0, msgReceiveView.frame.size.height, self.view.frame.size.width, 20);
         self.tableView.frame = CGRectMake(0.0f, 20.0f+ msgReceiveView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 69 - msgReceiveView.frame.size.height);
     }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"搜索"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"搜索"];
    //[KeyboardView sharedKeyBoard].dailText.text = @"";
    
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected) [self.tableView deselectRowAtIndexPath:selected animated:YES];
    
    
    DLog(@"search list view will appear");
    //进入list后,搜索是没有记录的，所以先显示教程图片
    //先判断是否有记录，有记录就不显示新手指南
    //没有记录才显示
    if (nowSearchText != nil && [nowSearchText length]>0){
        [self displayTutorialImage:NO];
    }else{
        [self displayTutorialImage:YES];
    }
    
    
}
-(void)displayTutorialImage:(BOOL) bDisplayTutorial
{
    if (bDisplayTutorial){
        [tutorialView setHidden:NO];
        //先隐藏搜索条相关界面
        [searchResultCountL setHidden:YES];
        [tableView setHidden:YES];
        [msgReceiveView setHidden:YES];
    }else{
        [tutorialView setHidden:YES];
        //显示搜索条相关界面
        [msgReceiveView setHidden:NO];
        [searchResultCountL setHidden:NO];
        [tableView setHidden:NO];
    }
}

-(void)KeyboardViewDidPressedKeyChanged:(NSString *)searchText
{
//    self.multipleChoosed = NO;
//    if (sendMSGBtn.selected) {
//        sendMSGBtn.selected = NO;
//        self.multipleChoosed = NO;
//    }
    DLog(@"searchText:%@",searchText);
    nowSearchText = searchText;
    
    if (searchText.length == 0) {
        [self.filteredArray removeAllObjects];
        [self.tableView reloadData];
        [histroyTypedWords removeAllObjects];
        searchResultCountL.text = @"0条搜索结果";
        [self displayTutorialImage:YES];
        return;
    }else{
        [self displayTutorialImage:NO];
    }

    Boolean isBackWard = NO;
    if (searchText.length < histroyTypedWords.count) {
        isBackWard = YES;
        [histroyTypedWords removeObjectsInRange:NSMakeRange(searchText.length, histroyTypedWords.count-searchText.length)];
    }else if(searchText.length > histroyTypedWords.count)
    {
        NSString *typedText = [searchText substringWithRange:NSMakeRange(searchText.length-1, 1)];
        if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeNumberPad){
            [histroyTypedWords addObject:[_correspondRegex objectForKey:typedText]];
        }
        else if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeDefault)
        {
            [histroyTypedWords addObject:[NSString stringWithFormat:@"[%@%@]",[typedText uppercaseString],[typedText lowercaseString]]];
        }
    }
    NSLog(@"%@",histroyTypedWords);
    //DLog(@"histroyTypedWords:%@",histroyTypedWords);  //done!!
    
    //第一种情况:如果数据库的返回记录大于前一结果结果集的已缓存数,则查库，否则 则启用内存筛选机制
    NSString *sql = [self getSQLWithKey:@"sql_selectCount"];
    int resCount = [db intForQuery:sql];
    DLog(@"sql is %@,total count is %d",sql,resCount);
    DLog(@"allUnitArray:%d",[allUnitArray count]);
    
    Boolean fixEnforceSearchDB = NO;
    if (preSearchResultCount > filteredArray.count) {
        //上次搜索结果没有完全载入
        fixEnforceSearchDB = YES;
    }
    preSearchResultCount = resCount;
    if (!needSearchDB) {
        NSString *regex = @".*";
        for (NSString *str in histroyTypedWords) {
            regex = [regex stringByAppendingFormat:str,nil];
        }
        regex = [regex stringByAppendingFormat:@".*"];
        [self filterInfoWithRegex:regex];
    }
    else if (YES || (!isBackWard && (fixEnforceSearchDB || resCount > [allUnitArray count] || searchText.length == 1))) {
        DLog(@"start searching");
        if ([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeNumberPad) {
            self.searchStartPos = 0;
            [self filterInDatabaseByNumber:searchText];
        }else if ([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeDefault)
        {
            self.searchStartPos = 0;
            [self filterInDatabaseByABC:searchText];
        }
        DLog(@"finish searching");
    }
    else if(searchText.length >= 1){
        NSString *regex = @".*";
        for (NSString *str in histroyTypedWords) {
            regex = [regex stringByAppendingFormat:str,nil];
        }
        regex = [regex stringByAppendingFormat:@".*"];
        [self filterInfoWithRegex:regex];
    }
    
    [self.tableView reloadData];

    if (needSearchDB && resCount > [allUnitArray count]) {
        searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",resCount];
    }else
        searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",self.filteredArray.count];
}

#pragma -----------------------------
#pragma -filter function --
#pragma -----------------------------

-(void)filterInDatabaseByABC:(NSString *)searchText
{
    
    if (self.searchStartPos == 0){
        [self.filteredArray removeAllObjects];
        [allUnitArray removeAllObjects];
    }
    
    NSString *sql = [self getSQLWithKey:@"sql_filterABC"];
    DLog(@"filterInDatabaseByABC:%@!,sql is %@",searchText,sql);
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]){
        
        int matchCount = 0;
        NSString *phoneNumber4Unique = @"";
        NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
        for (NSString *key in KEYINDB) {
            NSString *tempPhoneKey = (NSString *)[[rs resultDictionary] objectForKey:key];
            if (tempPhoneKey != nil && tempPhoneKey!=[NSNull null] && ![tempPhoneKey isEqualToString:@""]) {
                matchCount +=1;
                phoneNumber4Unique = tempPhoneKey;
            }
        }

        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[rs resultDictionary]];
        if (matchCount == 1){
            [dict setValue:[NSString stringWithFormat:@"A%@",phoneNumber4Unique] forKey:@"matchnumber"];
        }else{
            [dict setValue:[NSString stringWithFormat:@"%d个电话",matchCount] forKey:@"matchnumber"];
        }

        

        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dict,@"obj",@"fullspell",@"kname", nil];
        [self.filteredArray addObject:dictionary];
        [allUnitArray addObject:[rs resultDictionary]];
       
    }
    
//    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
//    [self.filteredArray removeAllObjects];
//    [self.filteredArray addObjectsFromArray:sortedArray];
    
    DLog(@"filterInDatabaseByABC:%d",self.filteredArray.count);
}

-(void)filterInDatabaseByNumber:(NSString *)searchText
{
    if (self.searchStartPos == 0){
        [self.filteredArray removeAllObjects];
        [allUnitArray removeAllObjects];
    }
    
    NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone",@"fullspell",@"shortspell"];

    NSString *sql = [self getSQLWithKey:@"sql_filterNumber"];
    //DLog(@"sql is %@",sql);
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]){
        //在这里分解index_search, 根据逗号的序号来判断是哪个字段匹配到了
        NSString *matchedStr = [rs stringForColumn:@"new_index_search"];

        NSArray *matchedComponent = [matchedStr componentsSeparatedByString:@","];
        
        searchText = [self transferString2Number:searchText];
        int matchCount = 0;
        int matchIndex = 0;
        NSString *matchKey = nil;

        for (int mi=0 ; mi< matchedComponent.count; mi++){
            NSString *tempStr  = [matchedComponent objectAtIndex:mi];
            if ([tempStr rangeOfString:searchText].length > 0){
                
                if (mi < 5) {
                    matchCount +=1;
                }

                if (matchKey == nil) {
                    matchIndex = mi;
                    matchKey = [KEYINDB objectAtIndex:mi];
                    //DLog(@"matchKey:%@",matchKey);
                }
            }
        }
        NSString *phoneNumber4Unique = @"";
        if (matchCount == 0 && matchIndex >=5) {
            matchCount = 0;
            NSArray *KEYB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
            for (NSString *key in KEYB) {
                NSString *tempPhoneKey = (NSString *)[[rs resultDictionary] objectForKey:key];
                if (tempPhoneKey != nil && tempPhoneKey!=[NSNull null] && ![tempPhoneKey isEqualToString:@""])
                {
                    matchCount +=1;
                    phoneNumber4Unique = tempPhoneKey;
                }
            }
        }
        
        NSString *regex = [nowRegexDict objectForKey:searchText];
        if (regex == nil) {
            [nowRegexDict removeAllObjects];
            
            NSString *t = @".*";
            for (NSString *str in histroyTypedWords) {
                t = [t stringByAppendingFormat:str,nil];
            }
            t = [t stringByAppendingFormat:@".*"];
            regex = t;
            [nowRegexDict setValue:regex forKey:searchText];
            //2013-4-24 有异常
            nowPred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            
            DLog(@"xxxregex:%@",regex);
        }

        NSDictionary *dict = [rs resultDictionary];
        NSString *kname = nil;
        if ([nowPred evaluateWithObject:[dict objectForKey:@"shortspell"]]) {
            kname = @"shortspell";
        }else if ([nowPred evaluateWithObject:[dict objectForKey:@"fullspell"]]){
            kname = @"fullspell";
        }
        
        //先尝试匹配名字
        if (kname != nil) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[rs resultDictionary]];

            //matchCount＝＝1也有可能是 用户只有一个电话
            if (matchCount == 1){
                if (matchIndex >=5){
                    [dict setValue:phoneNumber4Unique forKey:@"matchnumber"];
                }else{
                    [dict setValue:matchKey forKey:@"matchnumber"];
                }
                
            }else{
                [dict setValue:[NSString stringWithFormat:@"%d个电话",matchCount] forKey:@"matchnumber"];
            }
                        
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dict,@"obj",kname,@"kname", nil];
           
            
            [self.filteredArray addObject:dictionary];
        }else if (matchCount == 1) {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[rs resultDictionary],@"obj",matchKey,@"kname", nil];
            [self.filteredArray addObject:dictionary];
        }else
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[rs resultDictionary]];
            [dict setValue:[NSString stringWithFormat:@"%d个电话",matchCount] forKey:@"matchnumber"];

            NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:dict,@"obj",@"matchnumber",@"kname", nil];
            [self.filteredArray addObject:dictionary];
           
        }

        [allUnitArray addObject:[rs resultDictionary]];
    }
    
    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
    [self.filteredArray removeAllObjects];
    [self.filteredArray addObjectsFromArray:sortedArray];
    DLog(@"========== filteredArray count %d",[filteredArray count]);
    DLog(@"========== all count %d",[allUnitArray count]);

}

-(void)filterInfoWithRegex:(NSString *)regex
{
    DLog(@"filterInfoWithRegex:%@",regex);
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSArray *keys = @[@"fullspell",@"shortspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    if (nowSearchText.length == 1) {
        keys = @[@"fullspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    }
    
    [self.filteredArray removeAllObjects];
    for (NSDictionary *obj in allUnitArray) {
        for (NSString *tkey in keys) {
            NSString *nowValue = [obj objectForKey:tkey];
            if ([pred evaluateWithObject:nowValue]) {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"obj",tkey,@"kname", nil];
                [self.filteredArray addObject:dictionary];
            }
        }
    }
    
    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
    [self.filteredArray removeAllObjects];
    [self.filteredArray addObjectsFromArray:sortedArray];
}

-(NSArray *)sortArrByKey:(NSArray *)needSortArray
{
    NSArray *SORT = @[@"shortspell",@"fullspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone",@"matchnumber"];
    NSArray *sortedArray = [needSortArray sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([SORT indexOfObject:[obj1 objectForKey:@"kname"]] < [SORT indexOfObject:[obj2 objectForKey:@"kname"]] )
        {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ([SORT indexOfObject:[obj1 objectForKey:@"kname"]] > [SORT indexOfObject:[obj2 objectForKey:@"kname"]]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return sortedArray;
    //return needSortArray;
}

-(NSString *)getSQLWithKey:(NSString *)keyname
{
    NSString *search_keyword = [NSString stringWithFormat:@"'%%%@%%'",nowSearchText];
    NSString *returnstr = @"";
    
    if ([keyname isEqualToString:@"sql_selectCount"]){
        //linwei, 考虑到有查多次的情况，需用[0-9]+来匹配
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
        if ([pred evaluateWithObject:nowSearchText]) {
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT a.id from address_list as a  , spell_list as s where (a.index_search like %@ or s.index_search like %@) and a.id = s.aid group by a.id )",search_keyword,search_keyword];
        }else{
            search_keyword = [self transferNumber2String:nowSearchText];
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT aid from spell_list where fullspell GLOB '*%@*' or  shortspell GLOB '*%@*' group by aid)",search_keyword,search_keyword];
        }
    }
    if ([keyname isEqualToString:@"sql_filterABC"]) {
        search_keyword = [self transferNumber2String:nowSearchText];
        returnstr = [[NSString alloc]initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.email,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM address_list as a ,spell_list as s, department as d where (s.shortspell GLOB '*%@*' or s.fullspell GLOB '*%@*') and a.deptid = d.deptid and a.id = s.aid group by a.id order by a.id asc", search_keyword, search_keyword];
    }
    if ([keyname isEqualToString:@"sql_filterNumber"]) {
        returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where (a.index_search like %@ or s.index_search like %@) and a.deptid = d.deptid and a.id = s.aid group by a.id order by a.id asc limit %d,%d", search_keyword,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
    }
    return returnstr;
}

-(NSString *)getSQLWithKey:(NSString *)keyname step:(int)step
{
    return [self getSQLWithKey:keyname];
}
-(NSString *)transferNumber2String:(NSString *)number
{
    NSString *transferedStr = @"";
    for (int i=0;i<number.length;i++){
        NSString *key = [number substringWithRange:NSMakeRange(i, 1)];
        //DLog(@"key is %@",key);
        if ([_correspondGlob objectForKey:key] != nil){
            transferedStr = [transferedStr stringByAppendingFormat:@"%@",[_correspondGlob objectForKey:key]];
        }else{
            transferedStr = [transferedStr stringByAppendingFormat:@"[%@%@]",key,[key lowercaseString]];

        }
    
    }
    
    return transferedStr;
}
-(NSString *)transferString2Number:(NSString *)string
{
    NSString *transferedStr = @"";
    for (int i=0;i<string.length;i++){
        NSString *key = [string substringWithRange:NSMakeRange(i, 1)];
        //DLog(@"key is %@",key);
        if ([letterDict objectForKey:key] != nil){
            transferedStr = [transferedStr stringByAppendingFormat:@"%@",[letterDict objectForKey:key]];
        }else{
            transferedStr = [transferedStr stringByAppendingFormat:@"%@",key];
            
        }
        
    }
    
    return transferedStr;
}


#pragma -----------------------------
#pragma - tableView delegate --------
#pragma -----------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"SearchResult"];
    if (!cell) cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResult"];
    
    NSArray *currentArray = self.filteredArray;
    NSDictionary *currentObj = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
    
    //regex string like [1][2A-C]
    NSString *regex = @"";
    for (NSString *str in histroyTypedWords) {
        regex = [regex stringByAppendingFormat:str,nil];
    }
    //DLog(@"drawcell regex:%@",regex);
    [(SearchResultCell *)cell refreshSearchResultCellWithDict:currentObj keyword:[[currentArray objectAtIndex:indexPath.row] objectForKey:@"kname"] regex:regex];
    ((SearchResultCell *)cell).index = indexPath.row;
    
    ((SearchResultCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
    if (self.multipleChooseEnable && self.multipleChoosed) {
        //DLog(@"多选状态");
        ((SearchResultCell *)cell).multipleBtn.hidden = NO;
        ((SearchResultCell *)cell).headImage.hidden = YES;
        
        UIButton *button = ((SearchResultCell *)cell).multipleBtn;
        if (button.imageView.image == nil) {
            [button setImage:[UIImage imageNamed:@"mutiple_unchoosed.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"mutiple_choosed.png"] forState:UIControlStateSelected];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 275);
            
            [button addTarget:self action:@selector(mutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }else
    {
        //DLog(@"正常状态");
        ((SearchResultCell *)cell).headImage.hidden = NO;
        ((SearchResultCell *)cell).multipleBtn.hidden = YES;
    }
   // DLog(@"done draw cell:%d",indexPath.row);

	return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *currentObj = [[self.filteredArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
    DLog(@"selected search result!");
    PersonDetailViewController *personDetail = [[PersonDetailViewController alloc] init];
    [self.navigationController pushViewController:personDetail animated:YES];
  //  [personDetail loadPersonDetailWithDict:currentObj];
}

-(void)scrollViewDidScroll:(UIScrollView *)ascrollView
{
    if (![KeyboardView sharedKeyBoard].didPullDown && !bPullKeyboardScroll) {
        [[KeyboardView sharedKeyBoard] KeyboardPullDown];
        bPullKeyboardScroll = YES;
    }
    if (ascrollView.contentSize.height - ascrollView.contentOffset.y < 1000 && !bUpdatedScroll){
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
        if ( self.needSearchDB && preSearchResultCount > filteredArray.count && [pred evaluateWithObject:nowSearchText]) {
            DLog(@"scroll load:%d",allUnitArray.count);
            self.searchStartPos = [allUnitArray count];
            [self filterInDatabaseByNumber:nowSearchText];
            bUpdatedScroll = YES;
            [self.tableView reloadData];
        }else if ( self.needSearchDB && preSearchResultCount > filteredArray.count && [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\w+"] evaluateWithObject:nowSearchText]) {
            DLog(@"scroll load:%d",allUnitArray.count);
            self.searchStartPos = [allUnitArray count];
            [self filterInDatabaseByABC:nowSearchText];
            bUpdatedScroll = YES;
            [self.tableView reloadData];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    bUpdatedScroll = NO;
    bPullKeyboardScroll = NO;
}

#pragma - nonatomic property
-(void)setMultipleChoosed:(BOOL)choosed
{
    if (self.multipleChooseEnable) {
        if (multipleChoosed != choosed) {
            multipleChoosed = choosed;
            [self.tableView reloadData];
            
            if(!multipleChoosed){
                //[self.mutipleChoosedMap removeAllObjects];
                msgReceiveView.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
                [self resetMsgReceiveFrame];
            }
            
        }
    }
}

#pragma - self Mutiple choose func
-(void)mutipleChoose:(UIButton *)button
{
    button.selected = !button.selected;
    
    int index = ((CustomCell *)button.superview.superview).index;
    if (button.selected) {
        [self.mutipleChoosedMap setObject:@"1" forKey:[NSNumber numberWithInt:index]];
    }else
    {
        [self.mutipleChoosedMap removeObjectForKey:[NSNumber numberWithInt:index]];
    }
    
    
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithCapacity:5];
    for (NSNumber *index in self.mutipleChoosedMap.allKeys) {
        NSDictionary *currentDict = [self.filteredArray objectAtIndex:[index intValue]];
        NSDictionary *currentObj = [currentDict objectForKey:@"obj"];
        [nameArray addObject:[currentObj objectForKey:@"name"]];
    }
    [msgReceiveView refreshWithArray:nameArray withResetFrame:YES];
    [nameArray removeAllObjects];
   
    [self resetMsgReceiveFrame];
}

-(void)sendMessageMutipleChoose:(UIButton *)sender
{
    self.multipleChooseEnable = YES;
    self.multipleChoosed = !self.multipleChoosed;
    
    DLog(@"self.multipleChoosed:%d  %@",self.multipleChoosed,self.mutipleChoosedMap.allKeys);
    if (!self.multipleChoosed) {
        if (self.mutipleChoosedMap.allKeys.count >0) {
            
            NSMutableArray *smsRecipients = [[NSMutableArray alloc]initWithCapacity:5];
            for (NSNumber *index in self.mutipleChoosedMap.allKeys) {
                NSDictionary *currentObj = [[self.filteredArray objectAtIndex:[index intValue]] objectForKey:@"obj"];
                NSString *currKey = [[self.filteredArray objectAtIndex:[index intValue]] objectForKey:@"kname"];
                if ([currKey isEqualToString:@"fullspell"] || [currKey isEqualToString:@"shortspell"]) {
                    currKey = @"workcell";
                }
                [smsRecipients addObject:[currentObj objectForKey:currKey]];
            }
            DLog(@"smsRecipients:%@",smsRecipients);
            
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];
            picker.recipients = smsRecipients;
            [self presentModalViewController:picker animated:YES];
            
        }
        [self.mutipleChoosedMap removeAllObjects];
    }
    sender.selected = !sender.selected;
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
