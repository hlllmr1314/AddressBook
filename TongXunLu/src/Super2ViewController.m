//
//  Super2ViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-15.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Super2ViewController.h"

#import "Person.h"
#define KDailSearchFunction @"22233344455566677778889999"
#import "SendAllViewController.h"
#import "UtilGetViews.h"
#import "DepartmentDetailView.h"
#import "PersonDetailViewController.h"
#import "Search2PersonViewController.h"
#import "MMSearchBar.h"
#import "SendWithDeptViewController.h"
#import "SendDeptPushViewController.h"
#import "SendDeptUtil.h"

@interface Super2ViewController ()

@end

@implementation Super2ViewController
{
    NSArray *arrDept;
    
    MMSearchBar *_searchBar;
    PersonSearchDisplayController *searchDisplay;
    
    UIView *viewHead;
    UITableView *_table;
    
    
    UIButton *_btnBumen;
    UIButton *_btnZiLiao;
    
    UIBarButtonItem *_leftBarBut;
    UIBarButtonItem *_leftBarButOld;
    DepartmentDetailView *departmentDetail;
    
    UILabel *searchResultCountL;
    NSMutableDictionary *dicPerson;
    NSMutableArray *searchByName;
    NSMutableArray *searchByPhone;
    
    NSArray *arrPersons;
    NSArray *arrDeparts;
    
    UILabel *titleLabel;
    UIButton *btnPro;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 320, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 2;
    }
    return self;
}

#pragma mark - button action
- (void)actionBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected) {
        return;
    }
    
    btn.selected = YES;
    if (btn.tag == 100) {
        _btnZiLiao.selected = NO;
       [_scrollViewH scrollRectToVisible:CGRectMake(0, 0, _scrollViewH.frame.size.width, _scrollViewH.frame.size.height) animated:YES];
        return;
    }
    _btnBumen.selected = NO;
    [_scrollViewH scrollRectToVisible:CGRectMake(_scrollViewH.frame.size.width, 0, _scrollViewH.frame.size.width, _scrollViewH.frame.size.height) animated:YES];
    
    
}

- (void)viewHeadInit
{
    if (!viewHead) {
        viewHead = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 88.0f)];
        viewHead.backgroundColor = [UIColor whiteColor];
        _searchBar = [[MMSearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        
        _searchBar.backgroundImage = [UIImage imageNamed:@"navbar.png"] ;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
        
        _searchBar.searchKeyboardtype = SearchKeyboardtypeDefault;
        
        searchDisplay = [[PersonSearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
        searchDisplay.dept = _dept;
        searchDisplay.personDelegate = self;
        [viewHead addSubview:_searchBar];
        
        _btnBumen = [[UIButton alloc]initWithFrame:CGRectMake(10, 5+44, 147, 33)];
        [_btnBumen setImage:[UIImage imageNamed:@"bumenchengyuan1"] forState:UIControlStateNormal];
        [_btnBumen setImage:[UIImage imageNamed:@"bumenchengyuan2"] forState:UIControlStateSelected];
        _btnBumen.tag = 100;
        _btnBumen.selected = YES;
        [_btnBumen addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnZiLiao = [[UIButton alloc]initWithFrame:CGRectMake(10+147, 5+44, 147, 33)];
        [_btnZiLiao setImage:[UIImage imageNamed:@"bumenziliao1"] forState:UIControlStateNormal];
        [_btnZiLiao setImage:[UIImage imageNamed:@"bumenziliao2"] forState:UIControlStateSelected];
        _btnZiLiao.tag = 101;
        [_btnZiLiao addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];        
        
        [viewHead addSubview:_btnBumen];
        [viewHead addSubview:_btnZiLiao];
    }   
    
}

- (void)wantPush:(Person *)person
{
   self.hidesBottomBarWhenPushed = YES;
    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
    viewController.person = person;
    viewController.thread = ContentThreadPrivate;
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)itemBarinit:(Boolean)haveDepartment
{
    if (!haveDepartment) {
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
    if (!btnPro) {
        btnPro = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
        [btnPro setImage:[UIImage imageNamed:@"btn_sendgroupmsg"] forState:UIControlStateNormal];
        [btnPro addTarget:self action:@selector(goSendMsg) forControlEvents:UIControlEventTouchUpInside];        
    }   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnPro];
    
}

- (void)goSendMsg
{
//    SendDeptPushViewController *sendDeptPushViewConPro = [[SendDeptPushViewController alloc]init];
//    sendDeptPushViewConPro.dept = _dept;
//   
//    [self presentModalViewController:[[UINavigationController alloc]initWithRootViewController:sendDeptPushViewConPro] animated:YES];    
//    return;
//    
//    SendWithDeptViewController *sendPro = [[SendWithDeptViewController alloc]init];
//    sendPro.dept = _dept;
//    
//    [self presentModalViewController:[[UINavigationController alloc]initWithRootViewController:sendPro] animated:YES];
//    return;
  //  UINavigationController *navPro = [[UINavigationController alloc]initWithRootViewController:[[SendAllViewController alloc] init]];
    
    UINavigationController *navPro = (UINavigationController *)[[UtilGetViews sharedGetViews] viewConFromId:@"nacSendAll"];
    ((SendAllViewController *)navPro.childViewControllers[0]).dept = _dept;
    //((SendAllViewController *)navPro.childViewControllers[0]).arrParam = self.sendMsgArray;
    [self presentModalViewController:navPro animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    if (_doMyself) {
        return;
    }
    
    if (_dept) {
        [self haveDepartMent];
    }
    
    
    //titleLabel.text = self.title;
    //
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_btnBumen){
        [self actionBtn:_btnBumen];
    }
    
     
    
}

- (void)haveDepartMent
{
    [self viewHeadInit];
    [self itemBarinit:YES];
    
    [self.view addSubview:viewHead];
    [self scrollHInit];
    
    [self tableviewInit];
    
    [self departmentDetailViewInit];
    if (viewHead) {
        viewHead.hidden = NO;
    }
    if (_scrollViewH) {
        _scrollViewH.hidden = NO;
    }
    
    if (titleLabel.text.length>8) {
        self.navigationItem.titleView = titleLabel;
    }
    
    _searchBar.placeholder = [NSString stringWithFormat:@"手机/名字/座机(共%d位联系人)",[_dept.searchPersons count]];
    
    [_table reloadData];
}

- (void)haveNoDepartMent
{
    [self itemBarinit:NO];
    if (viewHead) {
        viewHead.hidden = YES;
    }
    if (_scrollViewH) {
        _scrollViewH.hidden = YES;
    }
}

- (void)departmentDetailViewInit
{
    if (!departmentDetail) {
        departmentDetail = [[DepartmentDetailView alloc]initWithFrame:CGRectMake(_scrollViewH.frame.size.width, _table.frame.origin.y, _scrollViewH.frame.size.width, _scrollViewH.frame.size.height)];
        departmentDetail.dept = _dept;
        departmentDetail.delegate = self.deptDelegate;
        [_scrollViewH addSubview:departmentDetail];
    }else{
        departmentDetail.dept = _dept;
    }
    
}

- (void)scrollHInit
{
    if (!_scrollViewH) {
              
        _scrollViewH = [[UIScrollView alloc]initWithFrame:CGRectMake(0, viewHead.frame.size.height, self.view.frame.size.width, UI_SCREEN_HEIGHT-20-44-50-viewHead.frame.size.height)];
        _scrollViewH.contentSize = CGSizeMake(640, _scrollViewH.frame.size.height);
        [self.view addSubview:_scrollViewH];
        
        _scrollViewH.scrollEnabled = NO;
    }
   
}


- (void)tableviewInit
{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 320, _scrollViewH.frame.size.height)];
        
        _table.delegate = self;
        _table.dataSource = self;
        [_scrollViewH addSubview:_table];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, viewHead.frame.size.height-1, _scrollViewH.frame.size.width, 1)];
        line.backgroundColor = _table.separatorColor;
        [viewHead addSubview:line];
    }
    [_table reloadData];
//    _table.contentInset = UIEdgeInsetsMake(CGRectGetHeight(viewHead.bounds), 0, 0, 0);
//    _table.scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetHeight(viewHead.bounds), 0, 0, 0);
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    if ([dept.level integerValue]==0) {
        titleLabel.text = @"所有单位";
        self.title = @"所有单位";
    }else if([dept.level integerValue]>0){
        titleLabel.text = dept.name;
        self.title = dept.name;
    }
    
    arrPersons = [[[_dept subPerson] allObjects] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        return [((Person *)a).id compare:((Person *)b).id];
        
    }];
    arrDeparts  = [_dept arrDept];
}
//
//#pragma mark - Table view data source
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    if (scrollView.contentOffset.y < -CGRectGetHeight(viewHead.bounds)) {
//        viewHead.layer.zPosition = 0; // Make sure the search bar is below the section index titles control when scrolling up
//    } else {
//        viewHead.layer.zPosition = 1; // Make sure the search bar is above the section headers when scrolling down
//    }
//    
//    CGRect searchBarFrame = viewHead.frame;
//    searchBarFrame.origin.y = MAX(scrollView.contentOffset.y, -CGRectGetHeight(searchBarFrame));
//    
//    viewHead.frame = searchBarFrame;
//    
//}
#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrPersons count]+[arrDeparts count];
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
    
    if (indexPath.row<[arrPersons count]) {
        Person *person = arrPersons[indexPath.row];
        ((CustomCell *)cell).cLabel1.text = person.username;        
        ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"touxiang.png"];
        ((CustomCell *)cell).cLabel2.text = person.title;
        return cell;
    }
   
    Department *department = arrDeparts[indexPath.row - [arrPersons count]];
    
    ((CustomCell *)cell).cLabel1.text = department.name;
    
    //((CustomCell *)cell).cLabel2.text = [currentObj objectForKey:@"title"];
    ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"touxiang.png"];
    ((CustomCell *)cell).cLabel2.text = [NSString stringWithFormat:@"%d",[[department.searchPersonIds componentsSeparatedByString:@","] count]];
    return cell;
  // [_dept.subDepart allObjects]
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row<[arrPersons count]) {
        Person *person = arrPersons[indexPath.row];
        PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
        viewController.person = person;
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    
    Department *department = arrDeparts[indexPath.row - [arrPersons count]];
    Super2ViewController *viewPro = [[Super2ViewController alloc]init];
    viewPro.deptDelegate = _deptDelegate;
    viewPro.dept = department;
   
    [self.navigationController pushViewController:viewPro animated:YES];
    
}

//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar endEditing:YES];
//    Search2PersonViewController *searchResultVC = [[Search2PersonViewController alloc]init];
//    searchResultVC.dept = _dept;//[_dept.searchPersons allObjects];
//    self.hidesBottomBarWhenPushed = YES;
//    //searchResultVC.unitsArray = [SharedDepartmentDB sharedInstance].departmentDBArray;
//    [self.navigationController pushViewController:searchResultVC animated:YES];
//    return;
////    SearchPersonViewController *searchResultVC = [[SearchPersonViewController alloc]init];
////    searchResultVC.arrPersons = [_dept.searchPersons allObjects];
////     self.hidesBottomBarWhenPushed = YES;
////    //searchResultVC.unitsArray = [SharedDepartmentDB sharedInstance].departmentDBArray;
////    [self.navigationController pushViewController:searchResultVC animated:YES];
//}



- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    [super viewWillDisappear:animated];
}

@end
