//
//  SendAllCell.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SendAllCell.h"

@implementation SendAllCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self labelInit];
    }
    return self;
}

- (void)labelInit
{
    _labelJob = [[UILabel alloc]initWithFrame:CGRectMake(300-170, 5, 170, 30)];
    _labelJob.backgroundColor = [UIColor clearColor];
    _labelJob.textAlignment = UITextAlignmentRight;
    _labelJob.font = [UIFont systemFontOfSize:10.0];
    _labelJob.alpha = 7.7;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self labelInit];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (![_labelJob superview]) {
         [self.contentView addSubview:_labelJob];
    }
   
}

@end
