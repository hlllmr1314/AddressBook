//
//  SendAllViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@interface SendAllViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,MFMessageComposeViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UIButton *rightBut;

- (IBAction)back:(id)sender;
- (IBAction)send:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)Department *dept;
@end
