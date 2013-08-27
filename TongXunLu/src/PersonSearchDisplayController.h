//
//  PersonSearchDisplayController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-7-19.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
@protocol PersonSearchDisplayControllerDelegate <NSObject>

- (void)wantPush:(Person *)person;

@end

@interface PersonSearchDisplayController : UISearchDisplayController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Department *dept;
@property(nonatomic,strong)id<PersonSearchDisplayControllerDelegate> personDelegate;
@end
