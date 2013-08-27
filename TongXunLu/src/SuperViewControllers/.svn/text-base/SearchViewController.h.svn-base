//
//  SearchViewController.h
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "KeyboardView.h"
//#import "FMDatabase.h"
#import "MsgReceiveView.h"
#define LIST_MAX_LENGTH 30
#define SEARCH_STEP_SHORTSPELL 1
#define SEARCH_STEP_FULLSPELL 2
#define SEARCH_STEP_TEL 3
#define CACHE_TABLE_LEVEL 2

@interface SearchViewController : CustomViewController <UITableViewDataSource, UITableViewDelegate, KeyboardViewDelegate, MFMessageComposeViewControllerDelegate>
{
    int preSearchResultCount;
    NSMutableArray *histroyTypedWords;
    NSDictionary *_correspondRegex;
    NSDictionary *_correspondGlob;
    
    NSString *nowSearchText;
    
    UILabel *searchResultCountL;
    BOOL bUpdatedScroll;
    BOOL bPullKeyboardScroll;
    
    MsgReceiveView *msgReceiveView;
    UIButton *sendMSGBtn;
    
    NSMutableDictionary *letterDict;
    NSMutableDictionary *nowRegexDict;
    NSPredicate * nowPred;
    
    int SEARCH_STEP;
    
    UIImageView *tutorialView;

}
@property (nonatomic,retain) UITableView *tableView;
@property (retain) NSMutableArray *allUnitArray;
@property (retain) NSMutableArray *filteredArray;
@property BOOL needSearchDB;
//@property (retain) FMDatabase *db;
@property (retain) NSString *departmentID;
@property int searchStartPos;

@property (nonatomic) BOOL multipleChooseEnable;   //多选功能开关，NO的话下面功能无效
@property (nonatomic) BOOL multipleChoosed;    //管理多选状态显隐
@property (nonatomic,retain) NSMutableDictionary *mutipleChoosedMap;  //管理list obj状态

-(void)resetMsgReceiveFrame;
-(NSString *)transferNumber2String:(NSString *)number;

@end
