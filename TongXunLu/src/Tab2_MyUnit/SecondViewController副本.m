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

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize departmentID;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.departmentID != [CfgManager getConfig:@"departmentID"]) {
        self.departmentID = [CfgManager getConfig:@"departmentID"];
            }
    if (self.departmentID != nil) {
        departmentDetail.departmentID = self.departmentID;

        self.tableView.hidden = NO;
        [self.scrollView bringSubviewToFront:self.tableView];
        
        [self refreshMyDepartment:self.departmentID];
        [self.tableView reloadData];
        DLog(@"second didchange:%@",self.departmentID);
        departmentDetail.departmentID = self.departmentID;
        [self showOrHideDepartmentViewButton:YES];
    }else
    {
        self.tableView.hidden = YES;
        warningView.hidden = NO;
        self.title = @"本部门";
        [self showOrHideDepartmentViewButton:NO];
    }
    
    DLog(@"self.departmentID:%@",self.departmentID);
    //[super viewWillAppear:animated];
}
-(void)dealloc
{
    
    [super dealloc];
}
-(void)refreshMyDepartment:(NSString *)dID
{
    [self.unitsArray removeAllObjects];
    
    NSString *sql = [[[NSString alloc] initWithFormat:@"SELECT a.fullname as name,a.*,a.title as jobname,d.departname FROM address_list as a , department as d where d.deptid = '%@' and a.deptid = d.deptid order by a.id asc",dID] autorelease];
    FMResultSet *rs = [self.db executeQuery:sql];
    while ([rs next]){
        [self.unitsArray addObject:[rs resultDictionary]];
    }
    
    sql = [[[NSString alloc] initWithFormat:@"SELECT departname FROM department where deptid = '%@'",dID] autorelease];
    rs = [self.db executeQuery:sql];
    while ([rs next]){
        self.title = [rs stringForColumnIndex:0];
    }
}

-(void)showOrHideDepartmentViewButton:(BOOL)bShow
{
    if (bShow){
        CGRect tframe = self.tableView.frame;
        tframe.origin.y = initTableY + 45;
        tframe.size.height = initTableHeight - 45;
        self.tableView.frame = tframe;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *2, self.scrollView.frame.size.height);
        self.tableView.hidden = NO;
        warningView.hidden = YES;
        lBtn.hidden = NO;
        rBtn.hidden = NO;

        [self swithList];
        
    }else{
        CGRect tframe = self.tableView.frame;
        tframe.origin.y = initTableY - 45;
        tframe.size.height = initTableHeight + 45;
        self.tableView.frame = tframe;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
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
    
    warningView = [[UIView alloc]initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:warningView];
    [warningView release];
    warningView.hidden = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, self.scrollView.frame.size.width, 15)];
    label.text = @"请先设置本部门";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorFromRGB(0x868686);
    [warningView addSubview:label];
    [label release];
    
    UIImageView *warningImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiyitu"]];
    [warningView addSubview:warningImage];
    warningImage.frame = CGRectMake((self.scrollView.frame.size.width-warningImage.frame.size.width )/2, 44+50, warningImage.frame.size.width, warningImage.frame.size.height);
    [warningImage release];
    initTableY = self.tableView.frame.origin.y;
    initTableHeight = self.tableView.frame.size.height;
    //检查是否已设置了本部门，若有的话，就显示切换按钮
    /*
    CGRect tframe = self.tableView.frame;
    tframe.origin.y += 45;
    tframe.size.height -=45;
    self.tableView.frame = tframe;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *2, self.scrollView.frame.size.height);
    */
    
    lBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 147, 35)];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan1.png"] forState:UIControlStateNormal];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateHighlighted];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateSelected];
    [lBtn addTarget:self action:@selector(swithList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lBtn];
    [lBtn release];
    [lBtn setHidden:YES];
    
    
    rBtn = [[UIButton alloc]initWithFrame:CGRectMake(167, 50, 146, 35)];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao1.png"] forState:UIControlStateNormal];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateHighlighted];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateSelected];
    [rBtn addTarget:self action:@selector(swithDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rBtn];
    [rBtn setHidden:YES];
    [rBtn release];
    
    lBtn.selected = YES;
    
    departmentDetail = [[DepartmentDetailView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, self.tableView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:departmentDetail];
    [departmentDetail release];
    departmentDetail.delegate = self;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, self.scrollView.frame.size.width *2, 1)];
    line.backgroundColor = self.tableView.separatorColor;
    [self.scrollView addSubview:line];
    [line release];
//    self.title = @"本部门";
//
//    self.departmentID = [CfgManager getConfig:@"departmentID"];
//    
//    if (self.departmentID == nil || [self.departmentID isEqualToString:@""]) {
//        DLog(@"myDeparment nil!");
//        self.tableView.hidden = YES;
//        self.title = @"本部门";
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, self.scrollView.frame.size.width, 15)];
//        label.text = @"请先设置本部门";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont systemFontOfSize:15];
//        label.textColor = UIColorFromRGB(0x868686);
//        [self.scrollView addSubview:label];
//        [label release];
//        
//        UIImageView *warningImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiyitu"]];
//        [self.scrollView addSubview:warningImage];
//        warningImage.frame = CGRectMake((self.scrollView.frame.size.width-warningImage.frame.size.width )/2, 44+50, warningImage.frame.size.width, warningImage.frame.size.height);
//        [warningImage release];
//    }else
//    {
//        [self refreshMyDepartment:self.departmentID];
//    }
}


-(void)swithList
{
    rBtn.selected = NO;
    lBtn.selected = YES;
    
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    
}
-(void)swithDetail
{
    rBtn.selected = YES;
    lBtn.selected = NO;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellStyle style =  UITableViewCellStyleDefault;
    CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
    if (!cell){
        cell = [[[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
    }
        
    NSArray *currentArray = self.unitsArray;
    NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
    
    cell.cLabel1.text = [currentObj objectForKey:@"name"];
    cell.cLabel2.text = [currentObj objectForKey:@"jobname"];
    cell.cImageView.image = [UIImage imageNamed:@"touxiang.png"];
    
    return cell;
}
    
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentObj = [self.unitsArray objectAtIndex:indexPath.row];
    
    PersonDetailViewController *viewController = [[[PersonDetailViewController alloc]init] autorelease];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController loadPersonDetailWithDict:currentObj];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    Tab2ViewController *searchResultVC = [[[Tab2ViewController alloc]init] autorelease];
    searchResultVC.departmentID = self.departmentID;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}


#pragma delegate
-(void)departmentOnCancel
{
    [self showOrHideDepartmentViewButton:NO];
}
@end
