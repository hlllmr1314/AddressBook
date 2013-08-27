//
//  PersonDetailCell.m
//  TongXunLu
//
//  Created by Mac Mini on 13-6-4.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "PersonDetailCell.h"

@implementation PersonDetailCell
{
    UIImageView *msgVIew;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)singleTap:(id)sender
{
    msgVIew.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.15 animations:^{
        msgVIew.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finish){
        [UIView animateWithDuration:0.12 animations:^{
            msgVIew.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
    if (_singleTap) {
        _singleTap();
    }
}

- (void)setImageMsg:(UIImage *)imageMsg
{
    if (!imageMsg) {
        msgVIew = nil;
    }else{
        msgVIew = [[UIImageView alloc]initWithFrame:CGRectMake(300-30-15, 5, 30, 30)];
        msgVIew.image = imageMsg;
        msgVIew.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [msgVIew addGestureRecognizer:singleRecognizer];
    }
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =  [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
  
    if (currentLocation.x>220) {
        return;
    }
    [super touchesBegan:touches withEvent:event];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (msgVIew) {
        [self.contentView addSubview:msgVIew];
    }
}

@end
