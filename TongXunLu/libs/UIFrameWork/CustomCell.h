//
//  CustomCell.h
//  TongXunLu
//
//  Created by pan on 13-3-19.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property BOOL customSubviewFrames;
@property (nonatomic,retain) UILabel *cLabel1;
@property (nonatomic,retain) UILabel *cLabel2;
@property (nonatomic,retain) UIImageView *cImageView;
@property (nonatomic,retain) UIButton *multipleBtn;
@property int index;
@end
