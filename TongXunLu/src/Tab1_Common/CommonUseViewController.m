//
//  CommonUseViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-29.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "CommonUseViewController.h"
#import "SearchIndex.h"

@interface CommonUseViewController ()

@end

@implementation CommonUseViewController

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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)KeyboardViewDidPressedKeyChanged:(NSString *)searchText
{    
    if (searchText.length<=0) {        
        [super addNilImage:YES];
        self.preSearchText = @"";
        self.searchResultCountL.text = @"0条搜索结果";
        return;
    }else if(self.preSearchText.length == 0){
        [super addNilImage:NO];
    }
    searchText = [[SearchIndex sharedIndexs] convertToNum:searchText];
    [self.arrPersonResult removeAllObjects];
    
   
    [self.arrPersonResult addObjectsFromArray:[[self.dept.searchPersons filteredSetUsingPredicate:[self predicateNum3:searchText]] allObjects]];
    self.searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[self.arrPersonResult count]];
       
    self.preSearchText = searchText;
    [self.table reloadData];
   
}


- (NSPredicate*)predicateNum2:(NSString *)searchText
{
    //NSString *searchText2 = [NSString stringWithFormat:@"%@*",searchText];
    return [NSPredicate predicateWithFormat:@"firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ or pinyinNum CONTAINS %@ or pinyinNum1 CONTAINS %@ or pinyinNum2 CONTAINS %@",searchText,searchText,searchText,searchText,searchText,searchText];
}

- (NSPredicate*)predicateNum3:(NSString *)searchText
{
    
    return [NSPredicate predicateWithFormat:@"firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ or pinyinNum CONTAINS %@ or pinyinNum1 CONTAINS %@ or pinyinNum2 CONTAINS %@ or homePhone CONTAINS %@ or personalCellPhone CONTAINS %@ or shortNum CONTAINS %@ or shortNum2 CONTAINS %@ or virtualCellPhone CONTAINS %@ or workCellPhone CONTAINS %@ or workingPhone CONTAINS %@ or workPhone2 CONTAINS %@ ",searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
