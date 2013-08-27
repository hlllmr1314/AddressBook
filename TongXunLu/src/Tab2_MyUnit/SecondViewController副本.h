//
//  SecondViewController.h
//  TongXunLu
//
//  Created by QuanMai on 13-3-8.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperBaseViewController.h"
#import "DepartmentDetailView.h"

@interface SecondViewController : SuperBaseViewController<DepartmentDetailViewDelegate>
{
    UIView *warningView;
    UIButton *lBtn;
    UIButton *rBtn;
    float initTableY;
    float initTableHeight;
    DepartmentDetailView *departmentDetail;
}
@property (retain) NSString *departmentID;
@end
