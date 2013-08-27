//
//  SearchCell.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-20.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LableColor.h"
#import "Person.h"

@interface SearchCell : UITableViewCell
@property(nonatomic,strong)LableColor *lableName;
@property(nonatomic,strong)UILabel *lableJob;
@property(nonatomic,strong)LableColor *lablePhone;
@property(nonatomic,strong)LableColor *lablePinYin;
@property(nonatomic,strong)UIImageView *imagetouxiang;

@property(nonatomic,strong)Person *person;
@end
