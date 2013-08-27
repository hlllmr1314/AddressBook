//
//  SuperBaseViewController.h
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedDepartmentDB.h"
#import "CustomViewController.h"
#import "CUISearchBar.h"
#import <MessageUI/MessageUI.h>

@interface SuperBaseViewController : CustomViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate , MFMessageComposeViewControllerDelegate>
{
    UIBarButtonItem *sendGroupMsg;
    UIBarButtonItem *sendGroupMsg_Finished;
}

-(void)setGroupSendMSGBtnShow:(BOOL)show;

@property (retain) FMDatabase *db;
@property (retain) UITableView *tableView;
@property (retain) UIScrollView *scrollViewH;
@property (retain) NSMutableArray *unitsArray;
@property (retain) CUISearchBar *searchBar;

@property (nonatomic) BOOL multipleChooseEnable;   //多选功能开关，NO的话下面功能无效
@property (nonatomic) BOOL multipleChoosed;    //管理多选状态显隐
@property (nonatomic,retain) NSMutableDictionary *mutipleChoosedMap;  //管理list obj状态
@property (retain) NSMutableArray *sendMsgArray;


@end
