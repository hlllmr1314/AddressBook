//
//  NameListsViewController.h
//  TongXunLu
//
//  Created by Pan on 13-3-18.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "AllUnitsViewController.h"
#import "DepartmentDetailView.h"

@interface NameListsViewController : AllUnitsViewController
{
    UIButton *lBtn;
    UIButton *rBtn;
    
    UIBarButtonItem *sendGroupMsg;
    UIBarButtonItem *sendGroupMsg_Finished;
    
    DepartmentDetailView *departmentDetail;
}
@property (retain) NSString *departmentID;
-(void)loadDepartments:(NSDictionary *)departments withTitle:(NSString *)title;
@end
