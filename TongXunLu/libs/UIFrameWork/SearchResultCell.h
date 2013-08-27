//
//  SearchResultCell.h
//  TongXunLu
//
//  Created by pan on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorbleLabel.h"

@interface SearchResultCell : UITableViewCell

@property (retain)    ColorbleLabel *nameL;
@property (retain)    ColorbleLabel *spellL;
@property (retain)    ColorbleLabel *numberL;
@property (retain)    ColorbleLabel *titleL;

@property (retain) UIImageView *headImage;
@property (nonatomic,retain) UIButton *multipleBtn;
@property int index;

-(void)refreshSearchResultCellWithDict:(NSDictionary *)dict keyword:(NSString *)keyword regex:(NSString *)regex;
@end
