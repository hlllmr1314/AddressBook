//
//  SelectDepartmentViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDepartmentViewController : UIViewController<UITabBarControllerDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *dicParam;
@property (retain, nonatomic) IBOutlet UITableView *table;

- (IBAction)back:(id)sender;
@end
