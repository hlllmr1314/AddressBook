//
//  BookShelf.h
//  General Engine
//
//  Created by QuanMai on 11-12-7.
//  Copyright 2011年 QuanMai Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"



@interface PreferenceList : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UITableView *tableView;
    NSMutableArray *updateList;
    NSString *HostDefault;
    NSDictionary *jsonDict;
    NSString *savePath;
    NSMutableArray *updateItem;
    
    UIProgressView *progressView;
    float amountDone;
    UIView *overlay;
    float loadingTime;
    
    int updateCount;
    int currentDidSelectedIndex;
    int bDownloading;

    BOOL _reloading;
    int pageNumber;
    

}
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *updateList;
@property(nonatomic,retain) NSString *HostDefault;
@property(nonatomic,retain) NSDictionary *jsonDic;
@property (retain) NSString *savePath;
@property(nonatomic,retain) NSMutableArray *updateItem;
@property(nonatomic,retain) UIView *overlay;
@property(nonatomic,retain) UIProgressView *progressView;

- (NSString *)requestToServer:(NSString *)modalID par:(NSString *)req;
-(void)initUpdateList:(NSString *) listStr;
-(void)showErrorMsg:(NSString *)e;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
-(void)pageRefresh;
-(void)pageMore;
@end

