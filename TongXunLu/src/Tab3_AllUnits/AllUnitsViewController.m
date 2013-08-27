//
//  AllUnitsViewController.m
//  TongXunLu
//
//  Created by QuanMai on 13-3-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "AllUnitsViewController.h"
#import "SBJsonParser.h"
#import "NameListsViewController.h"
#import "PersonDetailViewController.h"
#import "SearchResultCell.h"
#import "KeyboardView.h"

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define LIST_MAX_LENGTH 20
#define CACHE_IN_MEM_STARTSIZE 500
@interface AllUnitsViewController ()

@end

@implementation AllUnitsViewController
@synthesize searchBar,searchDC;
@synthesize tableView,scrollView;
@synthesize unitsArray,filteredArray,_allUnitArray;
@synthesize searchFlag;
@synthesize multipleChooseEnable, multipleChoosed, mutipleChoosedMap;
@synthesize db, searchStartPos;
@synthesize needSearchDB;

-(NSString *)getSQLWithKey:(NSString *)keyname
{
    NSString *search_keyword = [NSString stringWithFormat:@"'%%%@%%'",self.searchBar.text];
    NSString *returnstr = @"";
    
    if ([keyname isEqualToString:@"sql_selectCount"]) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]"];
        if ([pred evaluateWithObject:self.searchBar.text]) {
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from address_list where index_search like %@",search_keyword];
        }else
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from address_list where fullname like %@",search_keyword];
    }
    if ([keyname isEqualToString:@"sql_filterABC"]) {
        returnstr = [[NSString alloc]initWithFormat:@"SELECT a.id AS PERSONID, a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where (a.fullspell like %@ or a.shortspell like %@) and a.deptid = d.deptid order by a.id asc", search_keyword, search_keyword];
    }
    if ([keyname isEqualToString:@"sql_filterNumber"]) {
        returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID, a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where (a.index_search like %@) and a.deptid = d.deptid order by a.id asc limit %d,%d", search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
    }
    return returnstr;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"所有单位";
        
        self.view.frame = [[[UIApplication sharedApplication] delegate] window].frame;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
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
        
        _allUnitArray = [[NSMutableArray alloc]initWithCapacity:100];
        mutipleChoosedMap = [[NSMutableDictionary alloc]initWithCapacity:10];
        histroyTypedWords = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return self;
}

-(void)loadInitedFunction
{
    [self.filteredArray removeAllObjects];
    [self.unitsArray removeAllObjects];
    [self.unitsArray addObjectsFromArray:[SharedDepartmentDB sharedInstance].departmentDBArray];
}

- (void)loadDepartments:(NSDictionary *)departments withTitle:(NSString *)title
{
    [self.filteredArray removeAllObjects];
    [self.unitsArray removeAllObjects];
    
    NSArray *names = [departments objectForKey:@"subUnits"];
    if (names != nil ) {
        for (id item in names){
            [self.unitsArray addObject:item];
        }
    }
    self.title = title;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    needSearchDB = YES;
    self.filteredArray = [[NSMutableArray alloc]init];
	self.unitsArray = [[NSMutableArray alloc] init];
    
    NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
    self.db = [[FMDatabase alloc] initWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 46-46)];
    [self.view addSubview:scrollView];
   
    scrollView.scrollEnabled = NO;
    
	// Create a search bar
	self.searchBar = [[CUISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    self.searchBar.backgroundImage = [UIImage imageNamed:@"search-bg.png"];
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.searchBar.keyboardType = UIKeyboardTypeNumberPad;
    self.searchBar.placeholder = @"手机/名字/座机";
    self.searchBar.delegate = self;
    self.searchBar.tar = self;
    [self.view addSubview:searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, self.view.frame.size.width, scrollView.frame.size.height - 44)];
    [scrollView addSubview:tableView];   
	tableView.delegate = self;
    tableView.dataSource = self;
    
	self.searchDC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
	self.searchDC.searchResultsDataSource = self;
	self.searchDC.searchResultsDelegate = self;
    self.searchDC.delegate = self;
    
    bUpdatedScroll = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    //[tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected) [self.tableView deselectRowAtIndexPath:selected animated:YES];
}

-(void)KeyboardViewTryHideKeyboard
{
    DLog(@"hide keyboard delegated called in allUVC!");
    [self.searchDC setActive:NO animated:YES];
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
    UISearchBar *asearchBar = self.searchDisplayController.searchBar;
    [asearchBar setShowsCancelButton:YES animated:NO];
    
    for(UIView *subView in asearchBar.subviews){
        if([subView isKindOfClass:UIButton.class]){
            [(UIButton*)subView setTitle:@"啊啊YYY" forState:UIControlStateNormal];
            if (subView.subviews.count <= 1) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.selected = NO;
                [btn setImage:[UIImage imageNamed:@"btn_sendgroupmsg"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"btn_sendgroupfinished"] forState:UIControlStateSelected];
                btn.frame = CGRectMake(0, 0, 64, 30);
                [btn addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
                [subView addSubview:btn];
            }
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    DLog(@"cancel!!");
	[self.searchBar setText:@""];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    BOOL isBackWard = NO;
    if (searchText.length < histroyTypedWords.count) {
        isBackWard = YES;
        [histroyTypedWords removeObjectsInRange:NSMakeRange(searchText.length, histroyTypedWords.count-searchText.length)];
    }else if(searchText.length > histroyTypedWords.count)
    {
        NSString *typedText = [self.searchBar.text substringWithRange:NSMakeRange(searchText.length-1, 1)];
        if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeNumberPad){
            [histroyTypedWords addObject:[_correspondRegex objectForKey:typedText]];
        }
        else if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeDefault)
        {
            [histroyTypedWords addObject:[NSString stringWithFormat:@"[%@%@]",[typedText uppercaseString],[typedText lowercaseString]]];
        }
    }
    //DLog(@"histroyTypedWords:%@",histroyTypedWords);  //done!!
    
    //第一种情况:如果数据库的返回记录大于前一结果结果集的已缓存数,则查库，否则 则启用内存筛选机制
    //NSString *sql = [[[NSString alloc] initWithFormat:@"SELECT count(*) as total from address_list where index_search like'%%%@%%' ",searchText] autorelease];
    NSString *sql = [self getSQLWithKey:@"sql_selectCount"];
    FMResultSet *rs = [db executeQuery:sql];
    int resCount = 0;
    if ([rs next])
        resCount = [rs intForColumnIndex:0];
    DLog(@"sql is %@,total count is %d",sql,resCount);

    if (needSearchDB && !isBackWard && (resCount > [_allUnitArray count] || searchText.length == 1)) {
        DLog(@"start searching");
        if ([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeNumberPad) {
            self.searchStartPos = 0;
            [self filterInDatabaseByNumber:searchText];
        }else if ([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeDefault)
        {
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
}

#pragma -----------------------------
#pragma -filter function --
#pragma -----------------------------

-(void)filterInDatabaseByABC:(NSString *)searchText
{
    DLog(@"filterInDatabaseByABC:%@!",searchText);
    [self.filteredArray removeAllObjects];
    [_allUnitArray removeAllObjects];
    
    NSString *sql = [self getSQLWithKey:@"sql_filterABC"];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[rs resultDictionary],@"obj",@"fullspell",@"kname", nil];
        [self.filteredArray addObject:dictionary];
        [_allUnitArray addObject:[rs resultDictionary]];
    }
    
    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
    [self.filteredArray removeAllObjects];
    [self.filteredArray addObjectsFromArray:sortedArray];
    
    DLog(@"filterInDatabaseByABC:%d",self.filteredArray.count);
}

-(void)filterInDatabaseByNumber:(NSString *)searchText
{
    if (self.searchStartPos == 0){
        [self.filteredArray removeAllObjects];
        [_allUnitArray removeAllObjects];
    }
    int testLen = 0;
    int indexPos = 0;

    NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone",@"fullspell",@"shortspell"];
    NSString *sql = [self getSQLWithKey:@"sql_filterNumber"];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]){
        testLen ++;
        //在这里分解index_search, 根据逗号的序号来判断是哪个字段匹配到了
        NSString *matchedStr = [rs stringForColumn:@"index_search"];
        NSArray *matchedComponent = [matchedStr componentsSeparatedByString:@","];
        for (int mi=0;mi<[matchedComponent count];mi++){
            NSString *tempStr = [matchedComponent objectAtIndex:mi];
            
            if ([tempStr rangeOfString:searchText].length>0){
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[rs resultDictionary],@"obj",[KEYINDB objectAtIndex:mi],@"kname", nil];
                [self.filteredArray addObject:dictionary];
            }
        }
        [_allUnitArray addObject:[rs resultDictionary]]; 
    }
    indexPos ++;

    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
    [self.filteredArray removeAllObjects];
    [self.filteredArray addObjectsFromArray:sortedArray];
    DLog(@"========== all count %d",[_allUnitArray count]);
}

-(void)filterInfoWithRegex:(NSString *)regex
{
    DLog(@"filterInfoWithRegex:%@",regex);
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSArray *keys = @[@"fullspell",@"shortspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    if (self.searchBar.text.length == 1) {
        keys = @[@"fullspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    }
    
    [self.filteredArray removeAllObjects];
    for (NSDictionary *obj in _allUnitArray) {
        for (NSString *tkey in keys) {
            NSString *nowValue = [obj objectForKey:tkey];
            //DLog(@"now value is %@",nowValue);
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
    NSArray *SORT = @[@"shortspell",@"fullspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
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
    self.searchFlag = (aTableView != tableView);

    if (aTableView == tableView)
        return 60;
    else
        return 53;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    //DLog(@"start draw tableview!");
    self.searchFlag = (aTableView != tableView);

	if (aTableView == tableView){
        DLog(@"cellCOunt:%d",self.unitsArray.count);
        return self.unitsArray.count;
    }
    else{
        DLog(@"cellCOunt:%d",self.filteredArray.count);
        return self.filteredArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DLog(@"draw cell:%d",indexPath.row);
    id cell = nil;
    self.searchFlag = (aTableView != tableView);
    if (!self.searchFlag) {  //画部门列表
        cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
        if (!cell) cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseCell"];
        
        NSArray *currentArray = self.unitsArray;
        NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
        int subCount = [[currentObj objectForKey:@"subUnits"] count];
        
        ((CustomCell *)cell).cLabel1.text = [NSString stringWithFormat:@"%@",[currentObj objectForKey:@"name"]];
        ((CustomCell *)cell).cLabel2.text = [NSString stringWithFormat:@"%d",subCount];
        ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"bumentouxiang"];
    }
    else{   //画搜索结果列表
        cell = [aTableView dequeueReusableCellWithIdentifier:@"SearchResult"];
        if (!cell) cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResult"];
        
        NSArray *currentArray = self.filteredArray;
        NSDictionary *currentObj = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
        
        //regex string like [1][2A-C]
        NSString *regex = @"";
        for (NSString *str in histroyTypedWords) {
            regex = [regex stringByAppendingFormat:str,nil];
        }
        DLog(@"drawcell regex:%@",regex);
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
        DLog(@"done draw cell:%d",indexPath.row);
    }
	return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL _searchFlag = (aTableView != tableView);
	NSDictionary *currentObj = (!_searchFlag) ? [self.unitsArray objectAtIndex:indexPath.row]  : [[self.filteredArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
    BOOL bLeaf = NO;

    //DLog(@"currentObj:%@",currentObj);
    //当前是部门列表
    if (!_searchFlag) {
        //加入判断来判断部门下面是否还有小部门，如果有则显示units否则显示名单菜单
        //点击后显示该部门所有的人员名单
        //判断下一个结点是否是叶结点
        NSArray *childNodes = [currentObj objectForKey:@"subUnits"];    //将取道的值创建为一个数组
        if (childNodes != nil && [childNodes count]> 0){
            NSArray *firstChildNode = [[childNodes objectAtIndex:0] objectForKey:@"subUnits"];
            bLeaf =  !(firstChildNode != nil && firstChildNode.count > 0) ;
        }
        
        if (bLeaf) {
            NameListsViewController *nameList = [[NameListsViewController alloc] init];
            [nameList loadDepartments:currentObj withTitle:[currentObj objectForKey:@"fullname"]];
            [self.navigationController pushViewController:nameList animated:YES];
        }
        else
        {
            AllUnitsViewController *departments = [[AllUnitsViewController alloc] init];
            [departments loadDepartments:currentObj withTitle:[currentObj objectForKey:@"name"]];
            [self.navigationController pushViewController:departments animated:YES];
        }
    }
    //当前是搜索结果表
    else{
        DLog(@"selected search result!");
        PersonDetailViewController *personDetail = [[PersonDetailViewController alloc] init];
      //  [personDetail loadPersonDetailWithDict:currentObj];
        [self.navigationController pushViewController:personDetail animated:YES];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)ascrollView
{
    if (ascrollView.contentSize.height - ascrollView.contentOffset.y < 1000 && !bUpdatedScroll){
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]"];
        if ( self.needSearchDB && [pred evaluateWithObject:self.searchBar.text]) {
            self.searchStartPos = [_allUnitArray count];
            [self filterInDatabaseByNumber:searchBar.text];
            bUpdatedScroll = YES;
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    bUpdatedScroll = NO;
}


#pragma - nonatomic property
-(void)setMultipleChoosed:(BOOL)choosed
{
    if (self.multipleChooseEnable) {
        if (multipleChoosed != choosed) {
            multipleChoosed = choosed;
            if (self.searchFlag) {
                [self.searchDC.searchResultsTableView reloadData];
            }else
            {
                [self.tableView reloadData];
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
        [self.mutipleChoosedMap setObject:@"" forKey:[NSNumber numberWithInt:index]];
    }else
    {
        [self.mutipleChoosedMap removeObjectForKey:[NSNumber numberWithInt:index]];
    }
}

-(void)sendMessageMutipleChoose:(UIButton *)sender
{
    self.multipleChooseEnable = YES;
    self.multipleChoosed = !self.multipleChoosed;

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
    [self.tabBarController dismissModalViewControllerAnimated:YES];
}

@end
