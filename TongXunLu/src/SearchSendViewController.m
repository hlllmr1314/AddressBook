//
//  SearchSendViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-30.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SearchSendViewController.h"
#import "SearchCell.h"
#import "Person.h"
#import "SearchIndex.h"

@interface SearchSendViewController ()

@end

@implementation SearchSendViewController
{
    UIButton *okBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
        [okBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [okBtn setImage:[UIImage imageNamed:@"wancheng.png"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    self.navigationItem.rightBarButtonItem = okItem;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)KeyboardViewDidPressedKeyChanged:(NSString *)searchText
{
    
    if ([self.dept.id isEqualToString:@"0"]) {
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
        
        NSLog(@"searchPersons%@,%d",self.dept.searchPersons,[self.dept.searchPersons count]);
        [self.arrPersonResult addObjectsFromArray:[[self.dept.searchPersons filteredSetUsingPredicate:[self predicateNum3:searchText]] allObjects]];
        self.searchResultCountL.text = [NSString stringWithFormat:@"%d条搜索结果",[self.arrPersonResult count]];
        
        self.preSearchText = searchText;
        [self.table reloadData];
    }else{
        [self.table scrollRectToVisible:CGRectMake(0, 0, 320, 10) animated:NO];
        [super KeyboardViewDidPressedKeyChanged:searchText];
    }
    
}

- (NSPredicate*)predicateNum3:(NSString *)searchText
{
    if ([self.dept.id isEqualToString:@"0"]) {
        return [NSPredicate predicateWithFormat:@"( firstPinyinNum CONTAINS %@ or firstPinyinNum1 CONTAINS %@ or firstPinyinNum2 CONTAINS %@ or pinyinNum CONTAINS %@ or pinyinNum1 CONTAINS %@ or pinyinNum2 CONTAINS %@ or homePhone CONTAINS %@ or personalCellPhone CONTAINS %@ or shortNum CONTAINS %@ or shortNum2 CONTAINS %@ or virtualCellPhone CONTAINS %@ or workCellPhone CONTAINS %@ or workingPhone CONTAINS %@ or workPhone2 CONTAINS %@ )",searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText,searchText];

    }
    return [super predicateNum3:searchText];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Person *person = (Person *)self.arrPersonResult[indexPath.row];
    
    SearchCell *cell = (SearchCell *)[super tableView:_tableView cellForRowAtIndexPath:indexPath];
    cell.imagetouxiang.frame = CGRectMake(6, 10, 25, 25);
    if ([_arrSelect containsObject:person.id]) {
        cell.imagetouxiang.image = [UIImage imageNamed:@"mutiple_choosed"];
    }else{
        cell.imagetouxiang.image = [UIImage imageNamed:@"mutiple_unchoosed"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!tableView.scrollEnabled) {
        return;
    }
    Person *person = (Person *)self.arrPersonResult[indexPath.row];
    if ([_arrSelect containsObject:person.id]) {
        [_arrSelect removeObject:person.id];
    }else{
        [_arrSelect addObject:person.id];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)submit:(id)sender
{
    if (_submit) {
        _submit(_arrSelect);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
