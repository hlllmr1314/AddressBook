//
//  SendShowView.h
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@protocol SendShowViewDelegate <NSObject>
- (void)removeOne:(UIViewController *)viewCon;
- (void)addOne:(Department *)dept;
@end

@interface SendShowView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Department *dept;
@property(nonatomic,strong)UIView *upperView;
@property(nonatomic,strong)id<SendShowViewDelegate> delegate;
@end
