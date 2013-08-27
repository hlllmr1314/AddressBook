//
//  Tab3NameListViewController.h
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperBaseViewController.h"
#import "DepartmentDetailView.h"
#import "PersonDetailViewController.h"

@interface Tab3NameListViewController : SuperBaseViewController
{
    UIButton *lBtn;
    UIButton *rBtn;
    
    DepartmentDetailView *departmentDetail;
}
- (void)loadNameList:(NSDictionary *)nameListDict withTitle:(NSString *)title;

@property (retain) NSString *departmentID;
-(void)showOrHideGroupMsgBtn:(BOOL)bShow;

@end
