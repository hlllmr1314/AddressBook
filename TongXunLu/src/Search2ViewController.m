//
//  Search2ViewController.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-13.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Search2ViewController.h"
#import "UtilUnit.h"
#import "SearchResultCell.h"

@interface Search2ViewController ()

@end

@implementation Search2ViewController
{
    NSDictionary *_correspondGlob;
    NSDictionary *_correspondRegex;
    
    NSMutableArray *histroyTypedWords;
    NSMutableDictionary *letterDict;
    UILabel *searchResultCountL;
    UITableView *_table;
    
    NSArray *_arrPeaple;
    NSMutableArray *_arrRes;
    NSString *_regex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.hidesBottomBarWhenPushed = YES;
        histroyTypedWords = [[NSMutableArray alloc]initWithCapacity:10];
        
        
        letterDict = [[NSMutableDictionary alloc] init];
        [letterDict setObject:@"2" forKey:@"A"];
        [letterDict setObject:@"2" forKey:@"B"];
        [letterDict setObject:@"2" forKey:@"C"];
        [letterDict setObject:@"3" forKey:@"D"];
        [letterDict setObject:@"3" forKey:@"E"];
        [letterDict setObject:@"3" forKey:@"F"];
        [letterDict setObject:@"4" forKey:@"G"];
        [letterDict setObject:@"4" forKey:@"H"];
        [letterDict setObject:@"4" forKey:@"I"];
        [letterDict setObject:@"5" forKey:@"J"];
        [letterDict setObject:@"5" forKey:@"K"];
        [letterDict setObject:@"5" forKey:@"L"];
        [letterDict setObject:@"6" forKey:@"M"];
        [letterDict setObject:@"6" forKey:@"N"];
        [letterDict setObject:@"6" forKey:@"O"];
        [letterDict setObject:@"7" forKey:@"P"];
        [letterDict setObject:@"7" forKey:@"Q"];
        [letterDict setObject:@"7" forKey:@"R"];
        [letterDict setObject:@"7" forKey:@"S"];
        [letterDict setObject:@"8" forKey:@"T"];
        [letterDict setObject:@"8" forKey:@"U"];
        [letterDict setObject:@"8" forKey:@"V"];
        [letterDict setObject:@"9" forKey:@"W"];
        [letterDict setObject:@"9" forKey:@"X"];
        [letterDict setObject:@"9" forKey:@"Y"];
        [letterDict setObject:@"9" forKey:@"Z"];
        
        
        NSString *regex0 = @"[0]";
        NSString *regex1 = @"[1]";
        NSString *regex2 = @"[2A-Ca-c]";
        NSString *regex3 = @"[3D-Fd-f]";
        NSString *regex4 = @"[4G-Ig-i]";
        NSString *regex5 = @"[5J-Lj-l]";
        NSString *regex6 = @"[6M-Om-o]";
        NSString *regex7 = @"[7P-Sp-s]";
        NSString *regex8 = @"[8T-Vt-v]";
        NSString *regex9 = @"[9W-Zw-z]";
        _correspondRegex = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:regex0,regex1,regex2,regex3,regex4,regex5,regex6,regex7,regex8,regex9, nil]
                                                        forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
        
        
        
        NSString *glob0 = @"[0]";
        NSString *glob1 = @"[1]";
        NSString *glob2 = @"[2ABCabc]";
        NSString *glob3 = @"[3DEFdef]";
        NSString *glob4 = @"[4GHIghi]";
        NSString *glob5 = @"[5JKLjkl]";
        NSString *glob6 = @"[6MNOmno]";
        NSString *glob7 = @"[7PQRSpqrs]";
        NSString *glob8 = @"[8TUVtuv]";
        NSString *glob9 = @"[9WXYZwxyz]";
        _correspondGlob = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:glob0,glob1,glob2,glob3,glob4,glob5,glob6,glob7,glob8,glob9, nil]
                                                       forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
    }
    return self;
}





- (void)setUnitsArray:(NSArray *)unitsArray
{
    _unitsArray = unitsArray;
    _arrPeaple = [UtilUnit arrPeapleFrom:_unitsArray];
    _arrRes = [[NSMutableArray alloc]initWithCapacity:[_arrPeaple count]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self searchCountLab];
    
    [self tableviewInit];
    
    [self keyboard];
    
}

- (void)searchCountLab
{
    searchResultCountL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    searchResultCountL.backgroundColor = [UIColor colorWithRed:0.7451 green:0.8824 blue:0.9725 alpha:1];
    searchResultCountL.font = [UIFont systemFontOfSize:15];
    searchResultCountL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:searchResultCountL];
    
    searchResultCountL.text = @"0条搜索结果";
}

- (void)keyboard
{
    [self.view addSubview:[KeyboardView sharedKeyBoard]];
    [KeyboardView sharedKeyBoard].delegate = self;
    [KeyboardView resetKeyboard];
}

- (void)tableviewInit
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-50-20)];
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
}

- (void)KeyboardViewDidPressedKeyChanged:(NSString *)text
{
    [self regexFresh:text];
    _regex = [self histroyTypedWordsToString];
    [self filterInfoWithRegex:_regex];
}

- (NSString *)histroyTypedWordsToString
{
    NSString *t = @".*";
    for (NSString *str in histroyTypedWords) {
        t = [t stringByAppendingFormat:str,nil];
    }
    t = [t stringByAppendingFormat:@".*"];
    return t;
}

- (void)regexFresh:(NSString *)searchText
{
    if (searchText.length < histroyTypedWords.count) {
        //isBackWard = YES;
        [histroyTypedWords removeObjectsInRange:NSMakeRange(searchText.length, histroyTypedWords.count-searchText.length)];
    }else if(searchText.length > histroyTypedWords.count)
    {
        NSString *typedText = [searchText substringWithRange:NSMakeRange(searchText.length-1, 1)];
        if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeNumberPad){
            [histroyTypedWords addObject:[_correspondRegex objectForKey:typedText]];
        }
        else if([KeyboardView sharedKeyBoard].keyboardType == UIKeyboardTypeDefault)
        {
            [histroyTypedWords addObject:[NSString stringWithFormat:@"[%@%@]",[typedText uppercaseString],[typedText lowercaseString]]];
        }
    }
    
    
    NSLog(@"%@",histroyTypedWords);
}



-(void)filterInfoWithRegex:(NSString *)regex
{
    DLog(@"filterInfoWithRegex:%@",regex);
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSArray *keys = @[@"fullspell",@"shortspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
    
    [_arrRes removeAllObjects];
    for (NSDictionary *obj in _arrPeaple) {
        for (NSString *tkey in keys) {
                       NSString *nowValue = [obj objectForKey:tkey];
                        if ([pred evaluateWithObject:nowValue]) {
                           NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"obj",tkey,@"kname", nil];
                            [_arrRes addObject:dictionary];
                        }
                    }
    }
    [_table reloadData];
//    if (nowSearchText.length == 1) {
//        keys = @[@"fullspell",@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone"];
//    }
//    
//    [self.filteredArray removeAllObjects];
//    for (NSDictionary *obj in allUnitArray) {
//        for (NSString *tkey in keys) {
//            NSString *nowValue = [obj objectForKey:tkey];
//            if ([pred evaluateWithObject:nowValue]) {
//                NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:obj,@"obj",tkey,@"kname", nil];
//                [self.filteredArray addObject:dictionary];
//            }
//        }
//    }
//    
//    NSArray *sortedArray = [self sortArrByKey:self.filteredArray];
//    [self.filteredArray removeAllObjects];
//    [self.filteredArray addObjectsFromArray:sortedArray];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrRes count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"resCell";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SearchResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell refreshSearchResultCellWithDict:_arrRes[indexPath.row][@"obj"] keyword:_arrRes[indexPath.row][@"kname"] regex:_regex];
   
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
