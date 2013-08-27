//
//  SendWithDeptViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "SendShowView.h"
#import "SendWithDeptCell.h"
@interface SendWithDeptViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SendShowViewDelegate,SendWithDeptCellDelegate>
@property(nonatomic,strong)Department *dept;
@end
