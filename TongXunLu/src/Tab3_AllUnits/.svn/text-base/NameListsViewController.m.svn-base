//
//  NameListsViewController.m
//  TongXunLu
//
//  Created by Pan on 13-3-18.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "NameListsViewController.h"
#import "PersonDetailViewController.h"

@interface NameListsViewController ()

@end

@implementation NameListsViewController
@synthesize departmentID;



- (id)init
{
    self = [super init];
    if (self) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
        [rightButton setImage:[UIImage imageNamed:@"btn_sendgroupmsg"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        sendGroupMsg = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
       
        
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
        [rightButton setImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        sendGroupMsg_Finished = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        
        self.navigationItem.rightBarButtonItem = sendGroupMsg;
        self.multipleChooseEnable = YES;

    }
    return self;
}

-(void)sendMessageMutipleChoose:(id)sender
{
    self.multipleChoosed = !self.multipleChoosed;
    
    if (!self.multipleChoosed) {
        
        if (self.mutipleChoosedMap.allKeys.count >0) {
            NSString *smsstr = @"";
            for (NSNumber *index in self.mutipleChoosedMap.allKeys) {
                NSDictionary *currentObj = (!self.searchFlag) ? [self.unitsArray objectAtIndex:[index intValue]]  : [[self.filteredArray objectAtIndex:[index intValue]] objectForKey:@"obj"];
                smsstr = [smsstr stringByAppendingFormat:[NSString stringWithFormat:@"%@,",[currentObj objectForKey:@"workcell"]], nil] ;
            }
            smsstr = [smsstr substringToIndex:smsstr.length -1];
            NSString *tel = [NSString stringWithFormat:@"sms:%@",smsstr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
            DLog(@"%@",tel);
        }
        
        [self.mutipleChoosedMap removeAllObjects];
        self.navigationItem.rightBarButtonItem = sendGroupMsg;
    }else
    {
        self.navigationItem.rightBarButtonItem = sendGroupMsg_Finished;
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tframe = self.tableView.frame;
    tframe.origin.y += 45;
    tframe.size.height -=45;
    self.tableView.frame = tframe;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *2, self.scrollView.frame.size.height);
    
    lBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 147, 35)];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan1.png"] forState:UIControlStateNormal];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateHighlighted];
    [lBtn setImage:[UIImage imageNamed:@"bumenchengyuan2.png"] forState:UIControlStateSelected];
    [lBtn addTarget:self action:@selector(swithList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lBtn];
   
    
    rBtn = [[UIButton alloc]initWithFrame:CGRectMake(167, 50, 146, 35)];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao1.png"] forState:UIControlStateNormal];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateHighlighted];
    [rBtn setImage:[UIImage imageNamed:@"bumenziliao2.png"] forState:UIControlStateSelected];
    [rBtn addTarget:self action:@selector(swithDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rBtn];
   
    
    lBtn.selected = YES;
    
    departmentDetail = [[DepartmentDetailView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, self.tableView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:departmentDetail];
   
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, self.scrollView.frame.size.width *2, 1)];
    line.backgroundColor = self.tableView.separatorColor;
    [self.scrollView addSubview:line];
   
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

-(void)loadDepartments:(NSDictionary *)departments withTitle:(NSString *)title
{
    //DLog(@"NamelistloadDepartments:%@",departments);

    self.departmentID = [departments objectForKey:@"deptid"];
    departmentDetail.departmentID = self.departmentID;
    
    [super loadInitedFunction];
    [super loadDepartments:departments withTitle:title];
    
    DLog(@"currentArraycount:%d",self.unitsArray.count);
    DLog(@"_searchFlag:%d",self.searchFlag);
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL _searchFlag = self.searchFlag;
    if (!_searchFlag) {  //画部门列表
        UITableViewCellStyle style =  UITableViewCellStyleDefault;
        CustomCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
        if (!cell){
            cell = [[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"];
        }
        
        NSArray *currentArray = self.unitsArray;
        NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
        
        cell.cLabel1.text = [currentObj objectForKey:@"name"];
        cell.cLabel2.text = [currentObj objectForKey:@"title"];
        cell.cImageView.image = [UIImage imageNamed:@"touxiang.png"];
        cell.index = indexPath.row;
        
        ((CustomCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
        if (self.multipleChooseEnable && self.multipleChoosed) {
            //多选状态
            ((CustomCell *)cell).multipleBtn.hidden = NO;
            ((CustomCell *)cell).cImageView.hidden = YES;
            
            UIButton *button = ((CustomCell *)cell).multipleBtn;
            if (button.imageView.image == nil) {
                [button setImage:[UIImage imageNamed:@"mutiple_unchoosed.png"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"mutiple_choosed.png"] forState:UIControlStateSelected];
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 275);
                
                [button addTarget:self action:@selector(mutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
            }

        }else
        {
            ((CustomCell *)cell).cImageView.hidden = NO;
            ((CustomCell *)cell).multipleBtn.hidden = YES;
        }
        
        return cell;
    }
    else{
        return [super tableView:aTableView cellForRowAtIndexPath:indexPath];
    }
    
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL search_flag = (aTableView != self.tableView);
	NSDictionary *currentObj = (!search_flag) ? [self.unitsArray objectAtIndex:indexPath.row]  : [[self.filteredArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
    
    DLog(@"selected:%d",indexPath.row);
    PersonDetailViewController *viewController = [[PersonDetailViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    
  //  [viewController loadPersonDetailWithDict:currentObj];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma - Mutiple choose func
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
@end
