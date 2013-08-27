//
//  Second2ViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-23.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Second2ViewController.h"
#import "CfgManager.h"
#import "Department.h"
#import "PersonSearchDisplayController.h"

@interface Second2ViewController ()

@end

@implementation Second2ViewController
{
    UISearchBar *_searchBar;
    UIImageView *warningImage;
    UILabel *label;
    PersonSearchDisplayController *searchDisplay;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.doMyself = YES;
    [super viewDidLoad];
    self.deptDelegate = self;
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([CfgManager getConfig:@"departmentID"]&&![[CfgManager getConfig:@"departmentID"] isEqualToString:@""]) {
        self.dept = [Department objectByID: [NSNumber numberWithInt:[((NSString *)[CfgManager getConfig:@"departmentID"]) integerValue]] createIfNone:NO];
        [self haveDepartMent0];
    }else{
        [self haveNoDepartMent0];
    }
    
}

- (void)haveDepartMent0
{
    if (warningImage) {
        warningImage.hidden = YES;
    }
    if (_searchBar) {
        _searchBar.hidden = YES;
        
    }
    if (label) {
        label.hidden = YES;
    }
    
    [super haveDepartMent];
}

- (void)haveNoDepartMent0
{
    self.title = @"本部门";
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        
        _searchBar.backgroundImage = [UIImage imageNamed:@"navbar.png"];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
        
        searchDisplay = [[PersonSearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
       // searchDisplay.dept = self.dept;
        searchDisplay.personDelegate = self;
        [self.view addSubview:_searchBar];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 320, 15)];
        label.text = @"请先设置本部门";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColorFromRGB(0x868686);
        [self.view addSubview:label];
    }
     _searchBar.placeholder = @"手机/名字/座机(共0位联系人)";
   
    if (!warningImage) {
        warningImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiyitu"]];
        warningImage.frame = CGRectMake(320/2-204/2, 44+50, 204, 204);
        [self.view addSubview:warningImage];
    }
    
    if (warningImage) {
        warningImage.hidden = NO;
    }
    if (_searchBar) {
        _searchBar.hidden = NO;
    }
    if (label) {
        label.hidden = NO;
    }

    [super haveNoDepartMent];
}

- (void)departmentOnCancel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self haveNoDepartMent0];
}

- (void)departmentOnSet
{
    [self.navigationController popToRootViewControllerAnimated:YES];
     self.dept = [Department objectByID: [NSNumber numberWithInt:[((NSString *)[CfgManager getConfig:@"departmentID"]) integerValue]] createIfNone:NO];
    [self haveDepartMent0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
