//
//  GestureLockViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-24.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "GestureLockViewController.h"
#import "GestureLock.h"
#import "DrawPatternLockViewController.h"

@interface GestureLockViewController ()

@end

@implementation GestureLockViewController
{
    NSArray *arrParam;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = UIColorFromRGB(0xe1e0de);
    
    arrParam = @[@"手势锁",@"修改手势锁"];
    
    if (self.navigationController.viewControllers.count >1) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];        
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)backPop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier0 = @"Cell0";
    static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *aswitch = [[UISwitch alloc]initWithFrame:CGRectMake(220, 8, 40, 40)];
            [aswitch addTarget:self action:@selector(swapWifiSwitch:) forControlEvents:UIControlEventValueChanged];
            aswitch.on = [GestureLock sharedLock].onLock;
            [cell addSubview:aswitch];
        }
    }
    
    if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    cell.textLabel.text = arrParam[indexPath.row];
    return cell;
}

- (void)swapWifiSwitch:(UISwitch *)aswitch
{
    
        [GestureLock sharedLock].onLock = aswitch.on;
    
    
    if (aswitch.on && ![GestureLock sharedLock].lockKey) {
       DrawPatternLockViewController *dPViewConPro = [[DrawPatternLockViewController alloc]init];
        dPViewConPro.typeLock = typeLockSet;
        dPViewConPro.setFinish = ^(BOOL finish){
            aswitch.on = finish;
            [GestureLock sharedLock].onLock = aswitch.on;
        };        
        [self presentModalViewController:[[UINavigationController alloc]initWithRootViewController:dPViewConPro] animated:YES];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        DrawPatternLockViewController *dPViewConPro = [[DrawPatternLockViewController alloc]init];
        dPViewConPro.typeLock = typeLockReSet;
//        dPViewConPro.setFinish = ^(BOOL finish){
//           
//        };
        [self.navigationController presentModalViewController:[[UINavigationController alloc]initWithRootViewController:dPViewConPro] animated:YES];
    }
  
    
}

@end
