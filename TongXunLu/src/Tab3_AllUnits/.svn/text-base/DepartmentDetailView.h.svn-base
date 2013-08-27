//
//  DepartmentDetailView.h
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
@protocol DepartmentDetailViewDelegate <NSObject>

- (void)departmentOnCancel;
- (void)departmentOnSet;
@end


@interface DepartmentDetailView : UIView

@property (nonatomic,retain) Department *dept;
@property (nonatomic,retain) NSDictionary *dict;
@property (assign) id<DepartmentDetailViewDelegate> delegate;
-(void)updateButtonStatus:(BOOL)bStatus;
@end
