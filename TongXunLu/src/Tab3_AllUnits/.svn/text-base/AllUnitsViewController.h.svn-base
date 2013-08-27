//
//  AllUnitsViewController.h
//  TongXunLu
//
//  Created by QuanMai on 13-3-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedDepartmentDB.h"
#import "KeyboardView.h"
#import "CUISearchBar.h"
#import <MessageUI/MessageUI.h>

@interface AllUnitsViewController : CustomViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate,KeyboardViewDelegate, MFMessageComposeViewControllerDelegate>
{
    NSDictionary *_correspondRegex;
    NSMutableArray *histroyTypedWords;
	UISearchDisplayController *searchDC;
        
    BOOL bUpdatedScroll;
}

- (void)setMultipleChooseEnable:(BOOL)enable;
- (void)loadInitedFunction;
- (void)loadDepartments:(NSDictionary *)departments withTitle:(NSString *)title;
-(NSString *)getSQLWithKey:(NSString *)keyname;

@property BOOL searchFlag;
@property int searchStartPos;
@property (retain) FMDatabase *db;
@property (retain) CUISearchBar *searchBar;
@property (retain) UISearchDisplayController *searchDC;
@property (retain) UITableView *tableView;
@property (retain) UIScrollView *scrollView;
@property (retain) NSMutableArray *unitsArray;
@property (retain) NSMutableArray *_allUnitArray;
@property (retain) NSMutableArray *filteredArray;
@property BOOL needSearchDB;

@property (nonatomic) BOOL multipleChooseEnable;   //多选功能开关，NO的话下面功能无效
@property (nonatomic) BOOL multipleChoosed;    //管理多选状态显隐
@property (nonatomic,retain) NSMutableDictionary *mutipleChoosedMap;  //管理list obj状态

@end
