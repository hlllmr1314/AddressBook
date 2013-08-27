//
//  SelectDepartmentViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SelectDepartmentViewController.h"

@interface SelectDepartmentViewController ()

@end

@implementation SelectDepartmentViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择公司";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:0];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dicParam count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSelectDepart"];
    cell.textLabel.text = @"xxx";
    return cell;
}


- (void)viewDidUnload {
    [self setTable:nil];
    [super viewDidUnload];
}

- (IBAction)back:(id)sender {
     [self.navigationController dismissModalViewControllerAnimated:YES];
}
@end
