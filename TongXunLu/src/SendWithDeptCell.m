//
//  SendWithDeptCell.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendWithDeptCell.h"

@implementation SendWithDeptCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _butSel = [UIButton buttonWithType:UIButtonTypeCustom];
        _butSel.frame = CGRectMake(10, 30-15, 30, 30);
        [_butSel setImage:[UIImage imageNamed:@"mutiple_unchoosed"] forState:UIControlStateNormal];
        [_butSel setImage:[UIImage imageNamed:@"mutiple_choosed"] forState:UIControlStateSelected];
        [_butSel addTarget:self action:@selector(butSelAct) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_butSel];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 180, 60)];
        _labelName.font = [UIFont systemFontOfSize:16];
        _labelName.textColor = [UIColor blackColor];
        _labelName.numberOfLines = 2;
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.userInteractionEnabled = YES;
        [_labelName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelName];
        
        _labelJob = [[UILabel alloc]initWithFrame:CGRectMake(310-60, 0, 60, 60)];
        _labelJob.font = [UIFont systemFontOfSize:12];
        _labelJob.textColor = [UIColor grayColor];
        //_labelJob.numberOfLines = 2;
        _labelJob.textAlignment = NSTextAlignmentRight;
        _labelJob.userInteractionEnabled = YES;
        [_labelJob setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelJob];
        
        _labelPhone = [[UILabel alloc]initWithFrame:CGRectMake(45, 40, 180, 20)];
        _labelPhone.font = [UIFont systemFontOfSize:12];
        _labelPhone.textColor = [UIColor grayColor];
       // _labelPhone.numberOfLines = 2;
        _labelPhone.textAlignment = NSTextAlignmentLeft;
        _labelPhone.userInteractionEnabled = YES;
        [_labelPhone setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelPhone];        
    }
    return self;
}

- (void)butSelAct
{
    [self.cellDelegate selBtnAct:_indexPath];
}

- (void)setTypeSendCell:(typeSendCell )typeSendCell
{
    _typeSendCell = typeSendCell;
    if (_typeSendCell == typeSendCellPerson) {
        _labelName.frame = CGRectMake(45,0,180,40);
    }
}

- (void)setTypeSendCellWidth:(typeSendCellWidth)typeSendCellWidth
{
    _typeSendCellWidth = typeSendCellWidth;
    if (_typeSendCellWidth == typeSendCellWidthSub) {
        _labelJob.frame = CGRectMake(290-60, 0, 60, 60);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{

    [super layoutSubviews];
    
}

@end
