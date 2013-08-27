//
//  Super2ViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-15.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "CustomViewController.h"
#import "Department.h"
#import "DepartmentDetailView.h"
#import "PersonSearchDisplayController.h"

@interface Super2ViewController : CustomViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,DepartmentDetailViewDelegate,PersonSearchDisplayControllerDelegate>
@property(nonatomic,strong)Department *dept;
@property(nonatomic,strong)UIScrollView *scrollViewH;
@property(nonatomic,assign)Boolean doMyself;

@property(nonatomic,strong)void(^cancelSetMySelfDept)();
@property(nonatomic,strong)id<DepartmentDetailViewDelegate> deptDelegate;
- (void)haveDepartMent;
- (void)haveNoDepartMent;

- (void)itemBarinit:(Boolean)haveDepartment;
@end
