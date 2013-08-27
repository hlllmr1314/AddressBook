//
//  SendWithDeptViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendWithDeptViewController.h"
#import "Person.h"
#import "SendAllCell.h"
#import "SendWithDeptCell.h"
#import "SendShowDeptViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Transform3dUse.h"

@interface SendWithDeptViewController ()

@end

@implementation SendWithDeptViewController
{
    UITableView *_table;
    NSArray *arrPersons;
    NSArray *arrDeparts;
    UIControl *control;
    NSMutableArray *arrShowViews;
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
    }
	_table.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 44);
    [self.view addSubview:_table];
    arrShowViews = [[NSMutableArray alloc]initWithCapacity:3];
}

- (void)backPop:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    self.title = @"选择联系人";
    
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
        return cell;
    }
    return cell;
}

- (void)selBtnAct:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.row<=[arrPersons count]) {
        return;
    }
    
    if (indexPath.row - [arrPersons count] <=[arrDeparts count]) {
        SendShowDeptViewController *sendShowViewConPro = [[SendShowDeptViewController alloc]init];
        sendShowViewConPro.dept = (Department *)arrDeparts[indexPath.row - [arrPersons count] -1];
        sendShowViewConPro.upperView = _table;
        [self addChildViewController:sendShowViewConPro];
        sendShowViewConPro.view.frame = CGRectMake(0, self.view.frame.size.height, 320, 300);
        [self.view addSubview:sendShowViewConPro.view];
        [arrShowViews addObject:sendShowViewConPro];
        
        if (!control) {
            control = [[UIControl alloc]initWithFrame:_table.bounds];
            [control addTarget:self action:@selector(removeAll) forControlEvents:UIControlEventTouchDown];
            
        }
        [_table addSubview:control];
        [UIView animateWithDuration:0.5 animations:^{
            //  CATransform3D skewedIdentityTransform= [self skewedIdentitiyTransformWithZDistance:1000];
            CATransform3D destLayerTrasnform = CATransform3DTranslate([Transform3dUse skewedIdentitiyTransformWithZDistance:1000], 0, -20, -150);
            _table.layer.transform = destLayerTrasnform;
            sendShowViewConPro.view.frame = CGRectMake(0, self.view.frame.size.height-300-44, 320, 300);
            
        }];
    }
}


- (void)addOne:(Department *)dept
{
    SendShowDeptViewController *sendShowViewConPro = [[SendShowDeptViewController alloc]init];
    sendShowViewConPro.dept = dept;
    sendShowViewConPro.upperView = _table;
    [self addChildViewController:sendShowViewConPro];
    sendShowViewConPro.view.frame = CGRectMake(0, self.view.frame.size.height, 320, 300);
    [self.view addSubview:sendShowViewConPro.view];
    [arrShowViews addObject:sendShowViewConPro];
    [UIView animateWithDuration:0.5 animations:^{
        //  CATransform3D skewedIdentityTransform= [self skewedIdentitiyTransformWithZDistance:1000];
//        CATransform3D destLayerTrasnform = CATransform3DTranslate([Transform3dUse skewedIdentitiyTransformWithZDistance:1000], 0, -20, -150);
//        _table.layer.transform = destLayerTrasnform;
        sendShowViewConPro.view.frame = CGRectMake(0, self.view.frame.size.height-300-44, 320, 300);
        
    }];
    NSLog(@"end");
}

- (void)removeOne:(UIViewController *)viewCon
{
    if ([arrShowViews indexOfObject:viewCon] == 0) {
        [self removeAll];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            viewCon.view.layer.transform = CATransform3DMakeTranslation(0,viewCon.view.frame.size.height+44,0);
        } completion:^(BOOL finished) {
            //     [viewCon.view removeFromSuperview];
            //       [viewCon removeFromParentViewController];
            [arrShowViews removeObject:viewCon];
        }];
    }
}

- (void)removeAll
{
    [control removeFromSuperview];
    for (UIViewController *viewCon in  arrShowViews) {
       
        [UIView animateWithDuration:0.5 animations:^{
            viewCon.view.layer.transform = CATransform3DMakeTranslation(0,viewCon.view.frame.size.height+44,0);
            _table.layer.transform = CATransform3DTranslate([Transform3dUse skewedIdentitiyTransformWithZDistance:1000], 0, 0, 0);
        } completion:^(BOOL finished) {
            [viewCon.view removeFromSuperview];
            [viewCon removeFromParentViewController];
            [arrShowViews removeAllObjects];
        }];
    }
}



@end







