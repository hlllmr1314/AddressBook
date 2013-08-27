//
//  SendAllViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SendAllViewController.h"
#import "SendAllCell.h"
#import "BaiduMobStat.h"
#import "Person.h"

#import "Search2ViewController.h"
#import "Search2PersonViewController.h"
#import "SendSelectViewController.h"
#import "UtilGetViews.h"
#import "SearchSendViewController.h"

@interface SendAllViewController ()

@end

@implementation SendAllViewController
{
    NSMutableArray *_arrSelect;
    Boolean _isSeleAll;
    UISearchBar *_searchBar;
    UISegmentedControl *segCon;
    
    NSMutableArray *_arrAllPersons;
    NSMutableArray *_arrSelectPersons;
    
    NSArray *personIds;
    NSRange range;
    NSRange rangeSelect;
    
    UITableView *_tableSelect;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择联系人";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:0];
   
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateNormal];
    [_rightBut setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateHighlighted];
    [_rightBut setTitle:@"发送" forState:UIControlStateNormal];
    [_rightBut setTitle:@"发送" forState:UIControlStateHighlighted];
    [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _rightBut.frame= CGRectMake(0, 7, 55, 44-14);
    _rightBut.hidden = YES;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];    
    _searchBar.backgroundImage = [UIImage imageNamed:@"navbar.png"];
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    _searchBar.placeholder = @"手机/名字/座机";   
    _searchBar.delegate = self;
    
    segCon = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"已选(0)"]];
    segCon.frame = CGRectMake(100.0, self.view.frame.size.height-44-30, 220, 30);
    segCon.selectedSegmentIndex = 0;
    segCon.alpha = 0.7;
    [segCon addTarget:self action:@selector(segConSelectbutton:) forControlEvents:UIControlEventValueChanged]; 
    if ([personIds count]>1000) {
        [segCon setTitle:@"全部(>1000)" forSegmentAtIndex:0];
    }else{
        [segCon setTitle:[NSString stringWithFormat:@"全部(%d)",[personIds count]] forSegmentAtIndex:0];
    }
   // [self.view addSubview:_searchBar];
    
  //  [_searchBar sizeToFit];
    
//    _searchDisPlayCon = [[SendSearchDisPlayController alloc] initWithSearchBar:_searchBar contentsController:self];
    SendSelectViewController *sendSelectCon = (SendSelectViewController *)[[UtilGetViews sharedGetViews] viewConFromId:@"SendSelectCon"];
    _tableSelect = sendSelectCon.tableView;
    _tableSelect.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    _tableSelect.contentInset = UIEdgeInsetsMake(CGRectGetHeight(_searchBar.bounds), 0, 0, 0);
    [self addChildViewController:sendSelectCon];
    [self.view addSubview:_tableSelect];
    _tableSelect.hidden = YES;
    _tableSelect.dataSource = self;
    _tableSelect.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    [self.view addSubview:_searchBar];
    [self.view addSubview:segCon];
//    
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(_searchBar.bounds), 0, 0, 0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetHeight(_searchBar.bounds), 0, 0, 0);
    
    
    
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    
    if([_dept.id isEqualToString:@"0"]){
        NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:[_dept.searchPersons count]];
        for (Person *person in [_dept.searchPersons allObjects]) {
            [arrPro addObject:person.id];
        }
        personIds = [NSArray arrayWithArray:arrPro];
    }else{
        personIds = [_dept.searchPersonIds componentsSeparatedByString:@","];
    }
        
   
    _arrAllPersons = [[NSMutableArray alloc]initWithCapacity:[personIds count]];
    NSArray *personIdsPro;
    range = NSMakeRange(0, 20);
    [self rangRenew];
    personIdsPro = [personIds subarrayWithRange:range];
    NSArray *persons2 = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", personIdsPro] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
    [_arrAllPersons addObjectsFromArray:persons2];

    
   // _arrAllPersons = [dept.searchPersons allObjects];
    _arrSelect = [[NSMutableArray alloc]initWithCapacity:personIds.count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//        if (scrollView.contentOffset.y < -CGRectGetHeight(_searchBar.bounds)) {
//            _searchBar.layer.zPosition = 0; // Make sure the search bar is below the section index titles control when scrolling up
//        } else {
//           _searchBar.layer.zPosition = 1; // Make sure the search bar is above the section headers when scrolling down
//        }
//        
//        CGRect searchBarFrame = _searchBar.frame;
//        searchBarFrame.origin.y = MAX(scrollView.contentOffset.y, -CGRectGetHeight(searchBarFrame));
//        
//        _searchBar.frame = searchBarFrame;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([tableView isEqual:_tableSelect])return [_arrSelectPersons count];
    return [_arrAllPersons count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SendAllCell *cell;
    if ([tableView isEqual:self.tableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellSendAll"];
        if(!cell){
            cell = [[SendAllCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellSendAll"];
        }
            
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellSendAllSelect"];
        if(!cell){
            cell = [[SendAllCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellSendAllSelect"];
        }
    }
   
   
    
    
    if (indexPath.row == 0&&[tableView isEqual:self.tableView]) {
       // cell.imageView.image = [UIImage imageNamed:@"mutiple_unchoosed"];
        cell.textLabel.text = @"全选";
        cell.detailTextLabel.text = @"";
        cell.labelJob.text = @"";
        if (_isSeleAll) {
            cell.imageView.image = [UIImage imageNamed:@"mutiple_choosed"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"mutiple_unchoosed"];
            
        }
        return cell;
    }
   
    Person *person;
    if ([tableView isEqual:self.tableView]) {
        person = (Person *)[_arrAllPersons objectAtIndex:indexPath.row-1];
    }else{
        person = (Person *)[_arrSelectPersons objectAtIndex:indexPath.row];
    }
    
//    NSDictionary *currentObj = [[_arrAllPersons objectAtIndex:indexPath.row-1] objectForKey:@"obj"];
//    NSString *key = [[_arrParam objectAtIndex:indexPath.row-1] objectForKey:@"kname"];
    
    cell.textLabel.text = person.username;
    if (person.workCellPhone.length) {
        cell.detailTextLabel.text = person.workCellPhone;
    }
    
//    if (person.virtualCellPhone.length) {
//        cell.detailTextLabel.text = person.virtualCellPhone;
//    }else{
//        cell.detailTextLabel.text = person.workCellPhone;
//    }
    
    cell.labelJob.text = person.title;
    
    if ([_arrSelect containsObject:person.id]) {
        cell.imageView.image = [UIImage imageNamed:@"mutiple_choosed"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"mutiple_unchoosed"];
        
    }
    
    return cell;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    SearchSendViewController *searchResultVC = [[SearchSendViewController alloc]init];
    searchResultVC.dept = _dept;
    searchResultVC.arrSelect = _arrSelect;
    searchResultVC.submit = ^(NSMutableArray *arrSelect){
        _arrSelect = arrSelect;
        [self setConSegTitleSelect];
        [self reloadSelectFromArrSelect];
        _rightBut.hidden = [_arrSelect count] == 0;
        [_tableView reloadData];
    };
    //searchResultVC.unitsArray = [SharedDepartmentDB sharedInstance].departmentDBArray;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"发送短信-选择联系人"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"发送短信-选择联系人"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0&&[tableView isEqual:self.tableView]) {
         _isSeleAll = !_isSeleAll;
        if (_isSeleAll) {
            [_arrSelect removeAllObjects];
            [_arrSelect addObjectsFromArray:personIds];
        }
        if (!_isSeleAll) {
            [_arrSelect removeAllObjects];
        }
        [self setConSegTitleSelect];
       _rightBut.hidden = [_arrSelect count] == 0;
        [self.tableView reloadData];
        return;
    }
    Person *person;
    if ([tableView isEqual:self.tableView]) {
       person = ((Person *)[_arrAllPersons objectAtIndex:indexPath.row-1]);
    }else{
        person = ((Person *)[_arrSelectPersons objectAtIndex:indexPath.row]);
    }
    
    if ([_arrSelect containsObject:person.id]) {
        [_arrSelect removeObject:person.id];
        if ([_arrSelectPersons containsObject:person]) {
            [_arrSelectPersons removeObject:person];
        }
    }else{
        [_arrSelect addObject:person.id];
    }
    [self setConSegTitleSelect];
     _rightBut.hidden = [_arrSelect count] == 0;
    if (segCon.selectedSegmentIndex == 0) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [_tableSelect reloadData];
        [self.tableView reloadData];
    }

}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - send action
- (IBAction)send:(id)sender {
    if ([_arrSelect count]>50) {
        [[[UIAlertView alloc]initWithTitle:@"号码太多了" message:@"建议您选择少于50个号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return;
    }
    NSMutableArray *smsRecipients = [[NSMutableArray alloc]initWithCapacity:[_arrSelect count]];
    NSArray *arrPersonPro = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", _arrSelect] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
    for (Person *person in arrPersonPro) {
        if (person.workCellPhone.length) {
            [smsRecipients addObject:person.workCellPhone];
        }
//        if(person.virtualCellPhone.length){
//            [smsRecipients addObject:person.virtualCellPhone];
//        }else{
//            [smsRecipients addObject:person.workCellPhone];
//        }
        
        
        //NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[rs resultDictionary],@"obj",@"fullspell",@"kname", nil];
        
    }
    [[BaiduMobStat defaultStat] logEvent:@"点击" eventLabel:@"发送短信"];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];
    picker.recipients = smsRecipients;
    [self presentModalViewController:picker animated:YES];
}



- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setRightBut:nil];
    _arrSelect = nil;
    _tableSelect = nil;
    _tableView = nil;
    _arrAllPersons = nil;
    personIds = nil;
    segCon = nil;
    [self setView:nil];
   
    [super viewDidUnload];
}


#pragma mark - scrollView

- (void)rangRenew
{
    if (range.location+range.length>[personIds count]) {
        range.length = [personIds count]-range.location;
    }
}

- (void)rangRenew2
{
    if (rangeSelect.location+rangeSelect.length>[_arrSelect count]) {
        rangeSelect.length = [_arrSelect count]-rangeSelect.location;
    }
}

static bool isInMore;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (segCon.selectedSegmentIndex == 0&&indexPath.row+2>[_arrAllPersons count]) {
        
        //range.location+=20;
        if (range.location+range.length>=[personIds count]||isInMore) {
            return;
        }
        range.location+=20;
        isInMore = YES;
        [self rangRenew];
        
        NSArray *nextPersonIds = [personIds subarrayWithRange:range];
        if (!nextPersonIds) {
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSArray *nextPersons2 = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", nextPersonIds] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
            [_arrAllPersons addObjectsFromArray:nextPersons2];
            dispatch_sync(dispatch_get_main_queue(), ^{[_tableView reloadData];isInMore = NO;});
        });
    }
    
    if (segCon.selectedSegmentIndex == 1&&indexPath.row+2>[_arrSelectPersons count]) {
        if (rangeSelect.location+rangeSelect.length>=[_arrSelect count]||isInMore) {
            return;
        }
        rangeSelect.location+=20;
        isInMore = YES;
        [self rangRenew2];
        
        NSArray *nextPersonIds = [_arrSelect subarrayWithRange:rangeSelect];
        if (!nextPersonIds) {
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSArray *nextPersons2 = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", nextPersonIds] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]];
            [_arrSelectPersons addObjectsFromArray:nextPersons2];
            dispatch_sync(dispatch_get_main_queue(), ^{[_tableSelect reloadData];isInMore = NO;});
        });
    }
}


#pragma mark - segCon Selectbutton

- (void)reloadSelectFromArrSelect
{
    if (!_arrSelectPersons) {
        _arrSelectPersons = [[NSMutableArray alloc]initWithCapacity:[personIds count]];
    }
    [_arrSelectPersons removeAllObjects];
    rangeSelect = NSMakeRange(0, 20);
    [self rangRenew2];
    NSArray *arrProIds = [_arrSelect subarrayWithRange:rangeSelect];
    [_arrSelectPersons addObjectsFromArray:[Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", arrProIds] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]]];
    [_tableSelect reloadData];
}

- (void)segConSelectbutton:(id)sender
{
    if (segCon.selectedSegmentIndex == 1) {
        self.tableView.hidden = YES;
        _tableSelect.hidden = NO;
        [self reloadSelectFromArrSelect];
        
    }else{
        self.tableView.hidden = NO;
        _tableSelect.hidden = YES;
        [_tableView reloadData];
    }
    
//    if (segCon.selectedSegmentIndex == 1) {
        if (!_arrSelectPersons) {
            _arrSelectPersons = [[NSMutableArray alloc]initWithCapacity:[personIds count]];
        }
//        [_arrSelectPersons removeAllObjects];
//       // NSArray *arrSelectIds = _arrSelect [personIds subarrayWithRange:range];
//        [_arrSelectPersons addObjectsFromArray:[Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)", _arrSelect] sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]]]];
//    }
//     
//      [_tableView reloadData];
}

- (void)setConSegTitleSelect
{
    if ([_arrSelect count]>1000) {
        [segCon setTitle:@"已选(>1000)" forSegmentAtIndex:1];
    }else{
        [segCon setTitle:[NSString stringWithFormat:@"已选(%d)",[_arrSelect count]] forSegmentAtIndex:1];
    }
}

@end
