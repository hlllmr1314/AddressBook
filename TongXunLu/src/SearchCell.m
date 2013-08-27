//
//  SearchCell.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-20.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imagetouxiang = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 35, 35)];
        
        _lableName = [[LableColor alloc]initWithFrame:CGRectMake(40, 0, 150, 30)];
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = [UIFont systemFontOfSize:15.5];
        _lableName.alignment = alignmentLeft;
        
        _lableJob = [[UILabel alloc]initWithFrame:CGRectMake(320-200, 30, 200, 30)];
        _lableJob.textAlignment = NSTextAlignmentRight;
        _lableJob.font = [UIFont systemFontOfSize:13.0];
        _lableJob.alpha = 0.45;
        _lablePhone = [[LableColor alloc]initWithFrame:CGRectMake(40, 30, 100, 20)];
        _lablePhone.alpha = 0.45;
        _lablePhone.font = [UIFont systemFontOfSize:12.0];
        _lablePhone.alignment = alignmentLeft;
        _lablePinYin = [[LableColor alloc]initWithFrame:CGRectMake(320-170, 0, 170, 30)];
        _lablePinYin.textAlignment = NSTextAlignmentRight;
        _lablePinYin.alpha = 0.45;
        _lablePinYin.font = [UIFont systemFontOfSize:12.0];
        _lablePinYin.alignment = alignmentRight;
        
        
    }
    return self;
}

- (void)setPerson:(Person *)person
{
    _person = person;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addSubview:_imagetouxiang];
   
    if (![_lableName superview]) {
         [self.contentView addSubview:_lableName];
    }
    if (![_lableJob superview]) {
        [self.contentView addSubview:_lableJob];
    }
    if (![_lablePhone superview]) {
        [self.contentView addSubview:_lablePhone];
    }
    if (![_lablePinYin superview]) {
        [self.contentView addSubview:_lablePinYin];
    }
    
//    [self.contentView addSubview:_lableName];
//    [self.contentView addSubview:_lableJob];
//    [self.contentView addSubview:_lablePhone];
//    [self.contentView addSubview:_lablePinYin];
}

@end
