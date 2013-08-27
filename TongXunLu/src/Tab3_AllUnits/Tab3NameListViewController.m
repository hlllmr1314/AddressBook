//
//  Tab3NameListViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "Tab3NameListViewController.h"
#import "Tab3SearchResultViewController.h"
#import "CfgManager.h"
#import "SearchResultCell.h"

@interface Tab3NameListViewController ()

@end

@implementation Tab3NameListViewController

- (void)loadNameList:(NSDictionary *)nameListDict withTitle:(NSString *)title
{
//    NSArray *KEYINDB = @[@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    NSArray *KEYINDB = @[@"shortphone",@"workcell"];
    DLog(@"nameListDict:%@",nameListDict);
    self.departmentID = [nameListDict objectForKey:@"deptid"];
    departmentDetail.departmentID = self.departmentID;
    
    [self.unitsArray removeAllObjects];
    [self.sendMsgArray removeAllObjects];
    NSArray *names = [nameListDict objectForKey:@"subUnits"];
    if (names != nil ) {
        for (id item in names){
            [self.unitsArray addObject:item];
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
    self.title = title;
}

//-(void)dealloc
//{
//    [sendGroupMsg release];
//    [sendGroupMsg_Finished release];
//    
//    [super dealloc];
//}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setGroupSendMSGBtnShow:YES];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self swithList];
    NSString *tempDeptID = [CfgManager getConfig:@"departmentID"] ;
    if (tempDeptID != nil && [tempDeptID isEqualToString:self.departmentID]){
        [departmentDetail updateButtonStatus:YES];
    }else{
            
        [departmentDetail updateButtonStatus:NO];
        
    }
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tframe = self.tableView.frame;
    tframe.origin.y += 45;
    tframe.size.height -=45;
    self.tableView.frame = tframe;
    self.scrollViewH.contentSize = CGSizeMake(self.scrollViewH.frame.size.width *2, self.scrollViewH.frame.size.height);
    
    lBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 147, 35)];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan1.png"] forState:UIControlStateNormal];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateHighlighted];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateSelected];
    [lBtn addTarget:self action:@selector(swithList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lBtn];
  //  [lBtn release];
    
    rBtn = [[UIButton alloc]initWithFrame:CGRectMake(167, 50, 146, 35)];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao1.png"] forState:UIControlStateNormal];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateHighlighted];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateSelected];
    [rBtn addTarget:self action:@selector(swithDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rBtn];
 //   [rBtn release];
    
    lBtn.selected = YES;
    
    departmentDetail = [[DepartmentDetailView alloc]initWithFrame:CGRectMake(self.scrollViewH.frame.size.width, self.tableView.frame.origin.y, self.scrollViewH.frame.size.width, self.scrollViewH.frame.size.height)];
    departmentDetail.departmentID = self.departmentID;
    [self.scrollViewH addSubview:departmentDetail];
   // [departmentDetail release];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, self.scrollViewH.frame.size.width *2, 1)];
    line.backgroundColor = self.tableView.separatorColor;
    [self.scrollViewH addSubview:line];
   // [line release];
}

-(void)showOrHideGroupMsgBtn:(BOOL)bShow
{
    if (sendGroupMsg!=nil){
        if (bShow){
            self.navigationItem.rightBarButtonItem = sendGroupMsg;
        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
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

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (self.multipleChooseEnable && self.multipleChoosed) {
//        return self.sendMsgArray.count;
//    }
//    return self.unitsArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCellStyle style =  UITableViewCellStyleDefault;
//    UITableViewCell *cell = nil;
//
//    if (self.multipleChooseEnable && self.multipleChoosed) {
//        //多选状态
//        cell = [aTableView dequeueReusableCellWithIdentifier:@"sendMSGCell"];
//        if (!cell) {
//            cell = [[[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sendMSGCell"] autorelease];
//        }
//        ((SearchResultCell *)cell).multipleBtn.hidden = NO;
//        ((SearchResultCell *)cell).headImage.hidden = YES;
//        
//        NSArray *currentArray = self.sendMsgArray;
//        NSDictionary *currentObj = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
//        NSString *key = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"kname"];
//        
//        ((SearchResultCell *)cell).nameL.text = [currentObj objectForKey:@"name"];
//        ((SearchResultCell *)cell).titleL.text = [currentObj objectForKey:@"title"];
//        ((SearchResultCell *)cell).numberL.text = [currentObj objectForKey:key];
//        ((SearchResultCell *)cell).index = indexPath.row;
//
//        UIButton *button = ((SearchResultCell *)cell).multipleBtn;
//        if (button.imageView.image == nil) {
//            [button setImage:[UIImage imageNamed:@"mutiple_unchoosed.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"mutiple_choosed.png"] forState:UIControlStateSelected];
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 275);
//            
//            [button addTarget:self action:@selector(mutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        ((SearchResultCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
//
//    }else
//    {
//        cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
//
//        if (!cell){
//            cell = [[[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
//        }
//        ((CustomCell *)cell).cImageView.hidden = NO;
//        ((CustomCell *)cell).multipleBtn.hidden = YES;
//        
//        NSArray *currentArray = self.unitsArray;
//        NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
//        
//        ((CustomCell *)cell).cLabel1.text = [currentObj objectForKey:@"name"];
//        ((CustomCell *)cell).cLabel2.text = [currentObj objectForKey:@"title"];
//        ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"touxiang.png"];
//        ((CustomCell *)cell).index = indexPath.row;
//        //((CustomCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
//
//    }
//    
//    return cell;
//}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *currentObj =  [self.unitsArray objectAtIndex:indexPath.row];

    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
   // [viewController loadPersonDetailWithDict:currentObj];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    Tab3SearchResultViewController *searchResultVC = [[Tab3SearchResultViewController alloc]init];
    searchResultVC.departmentID = self.departmentID;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}

@end
