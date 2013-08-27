//
//  PersonDetailUIView.h
//  TongXunLu
//
//  Created by pan on 13-3-19.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonDetailUIView : UIView <UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,retain) NSMutableDictionary *_dict;
@property (assign) UIViewController *vController;
@property(nonatomic,strong)Person *person;
-(void)refreshView:(NSDictionary *)dict;
@end
