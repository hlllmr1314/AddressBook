//
//  CustomCell.m
//  TongXunLu
//
//  Created by pan on 13-3-19.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize cImageView, cLabel1, cLabel2, multipleBtn;
@synthesize index;

#define PADDING 7
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.customSubviewFrames = NO;
        
        cImageView = [[UIImageView alloc]initWithFrame:CGRectMake(11, 0, self.contentView.frame.size.height, self.contentView.frame.size.height)];
        cImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:cImageView];
        cImageView.contentMode = UIViewContentModeScaleAspectFit;
        cImageView.userInteractionEnabled = YES;
        
        cLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(cImageView.frame.size.width + 11, 0, 180, self.contentView.frame.size.height)];
        cLabel1.font = [UIFont systemFontOfSize:16];
        cLabel1.textColor = [UIColor blackColor];
        cLabel1.numberOfLines = 2;
        cLabel1.textAlignment = NSTextAlignmentLeft;
        cLabel1.userInteractionEnabled = YES;
        [cLabel1 setBackgroundColor:[UIColor clearColor]];
        
        cLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, 120-11, self.contentView.frame.size.height)];
        cLabel2.font = [UIFont systemFontOfSize:16];
        cLabel2.textColor = UIColorFromRGB(0x838383);
        cLabel2.textAlignment = NSTextAlignmentRight;
        cLabel2.userInteractionEnabled = YES;
        
        [self.contentView addSubview:cLabel2];        
        [self.contentView addSubview:cLabel1];

       
        
        multipleBtn = [[UIButton alloc]initWithFrame:cImageView.bounds];
        multipleBtn.hidden = YES;
        [self.contentView addSubview:multipleBtn];
       
    }
    return self;
}

-(void)layoutSubviews
{
    //DLog(@"layoutSubviews");
    [super layoutSubviews];
    
    if (!self.customSubviewFrames) {
        cImageView.frame = CGRectMake(2, 9, self.frame.size.height, self.frame.size.height-18);
        cLabel1.frame = CGRectMake(cImageView.frame.size.width + 2, 0, 180, self.frame.size.height);
        cLabel2.frame = CGRectMake(200, 0, 120-11, self.frame.size.height);
        multipleBtn.frame = self.contentView.bounds;
    }
}


@end
