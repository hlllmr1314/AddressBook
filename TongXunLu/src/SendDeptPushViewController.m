//
//  SendDeptPushViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-30.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendDeptPushViewController.h"
#import "Person.h"


@interface SendDeptPushViewController ()

@end

@implementation SendDeptPushViewController
{
    UITableView *_table;
    NSArray *arrPersons;
    NSArray *arrDeparts;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _table = [[UITableView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:0];
    }
	_table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 44);
    [self.view addSubview:_table];
}

- (void)backPop:(id)sender
{
    if ([self.navigationController.childViewControllers count] == 0) {
        [self dismissModalViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    self.title = dept.name.length?dept.name:@"选择联系人";
    
    arrPersons = [[[_dept subPerson] allObjects] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        return [((Person *)a).id compare:((Person *)b).id];
        
    }];
    arrDeparts  = [_dept arrDept];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrPersons count]+[arrDeparts count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SendWithDeptCell *cell;
    
    if (indexPath.row == 0) {
        
        static NSString *CellIdentifier = @"CellSendAllSelect";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[SendWithDeptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.typeSendCell = typeSendCellSel;
            cell.labelName.text = @"全选";
            cell.cellDelegate = self;
            //cell.detailTextLabel.text = @"";
            // cell.labelJob.text = @"";
        }
        cell.butSel.selected = [self haveAllSelect:_dept];
        cell.indexPath = indexPath;
        return cell;
    }
    
    if (indexPath.row<=[arrPersons count]) {
        
        static NSString *CellIdentifier = @"CellSendAllPerson";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[SendWithDeptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.typeSendCell = typeSendCellPerson;
            cell.cellDelegate = self;
        }
        cell.labelName.text = ((Person *)arrPersons[indexPath.row-1]).username;
        if (((Person *)arrPersons[indexPath.row-1]).virtualCellPhone.length) {
            cell.labelPhone.text = ((Person *)arrPersons[indexPath.row-1]).virtualCellPhone;
        }else{
            cell.labelPhone.text = ((Person *)arrPersons[indexPath.row-1]).workCellPhone;
            
        }
        cell.indexPath = indexPath;
        cell.labelJob.text = ((Person *)arrPersons[indexPath.row-1]).title;
        return cell;
    }
    
    if (indexPath.row - [arrPersons count] <=[arrDeparts count]) {
        static NSString *CellIdentifier = @"CellSendAllDept";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[SendWithDeptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.typeSendCell = typeSendCellDept;
            cell.cellDelegate = self;
        }
        cell.indexPath = indexPath;
        Department *department = (Department *)arrDeparts[indexPath.row - [arrPersons count] -1];
        cell.labelName.text = department.name;
        cell.labelJob.text = [NSString stringWithFormat:@"%d", [department.searchPersons count]];
        cell.butSel.selected = [self haveAllSelect:department];
        return cell;
    }
    return cell;
}

- (BOOL)haveAllSelect:(Department *)department
{
    for (int i=0; i<[department.searchPersons count]; i++) {
        if (((Person *)[department.searchPersons allObjects][i]).isSelect == NO) {
            return NO;
        }  
    }
    return YES;
}

- (void)selBtnAct:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        for (int i=0; i<[_dept.searchPersons count]; i++) {
            ((Person *)[_dept.searchPersons allObjects][i]).isSelect = YES;
        }
    }
    [_table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row<=[arrPersons count]) {
        return;
    }
    
    if (indexPath.row <= [arrPersons count]) {
        [self selBtnAct:indexPath];
    }
    
    if (indexPath.row - [arrPersons count] <=[arrDeparts count]) {
        Department *department = (Department *)arrDeparts[indexPath.row - [arrPersons count] -1];
        SendDeptPushViewController *sendDeptPushViewConPro = [[SendDeptPushViewController alloc]init];
        sendDeptPushViewConPro.dept = department;
        [self.navigationController pushViewController:sendDeptPushViewConPro animated:YES];
    }
}


@end
