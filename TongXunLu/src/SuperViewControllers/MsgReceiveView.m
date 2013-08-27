//
//  MsgReceiveView.m
//  TongXunLu
//
//  Created by pan on 13-4-7.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "MsgReceiveView.h"
#import "SearchViewController.h"

@implementation MsgReceiveView
@synthesize vController;

#define DEFAULT_HEIGHT 40
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        nameArrow = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 37, 0, 37, 37)];
        nameArrow.imageView.contentMode = UIViewContentModeCenter;
        [nameArrow setImage:[UIImage imageNamed:@"nameArrow.png"] forState:UIControlStateNormal];
        [nameArrow addTarget:self action:@selector(nameArrow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nameArrow];
       
        nameArrow.backgroundColor = [UIColor clearColor];
        
        tLablel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, 10, 40)];
        [self addSubview:tLablel];
       
        tLablel.text = @"收件人:";
        tLablel.textColor = UIColorFromRGB(0x838383);
        tLablel.font = [UIFont systemFontOfSize:15];
        tLablel.backgroundColor = [UIColor clearColor];
        
        nameLabel = [[UILabel alloc]init];
        [self addSubview:nameLabel];
       
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.numberOfLines = 1;
    }
    return self;
}

-(void)refreshWithArray:(NSArray *)nameArray withResetFrame:(BOOL)resetBool
{
    if (nameArray == nil || nameArray.count == 0) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, 0);
        return;
    }else{
        tLablel.text = [NSString stringWithFormat:@"收件人(%d):",[nameArray count]];
        [tLablel sizeToFit];
        
        nameLabel.frame = CGRectMake(tLablel.frame.origin.x + tLablel.frame.size.width +10, 8, self.frame.size.width - (tLablel.frame.origin.x + tLablel.frame.size.width +10)- DEFAULT_HEIGHT, 20);
        NSString *nL = @"";
        for (NSString *name in nameArray) {
            nL = [nL stringByAppendingFormat:name,nil];
            nL = [nL stringByAppendingFormat:@"；",nil];
        }
        nameLabel.text = nL;
        
        if (pulledStatue == YES) {
            [self pullOut];
        }else{
            [self pullBack];
            //self.frame = CGRectMake(0, 0, self.frame.size.width, DEFAULT_HEIGHT);
        }

    }

}

-(void)nameArrow:(UIButton *)btn
{
    CGSize s = [nameLabel.text sizeWithFont:nameLabel.font];
    if(self.frame.size.height > DEFAULT_HEIGHT)
    {
        [self pullBack];
    }
    else if (s.width > nameLabel.frame.size.width) {
        [self pullOut];
    } 
}

-(void)pullOut
{
    pulledStatue = YES;
    [UIView animateWithDuration:0.3 animations:^{
        nameArrow.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    nameLabel.numberOfLines = 0;
    [nameLabel sizeToFit];
    self.frame = CGRectMake(0, 0, self.frame.size.width, nameLabel.frame.size.height + 16);
    [(SearchViewController *)vController resetMsgReceiveFrame];
}

-(void)pullBack
{
    pulledStatue = NO;
    [UIView animateWithDuration:0.3 animations:^{
        nameArrow.transform = CGAffineTransformMakeRotation(0);
    }];
    nameLabel.numberOfLines = 1;
    nameLabel.frame = CGRectMake(tLablel.frame.origin.x + tLablel.frame.size.width +10, 8, self.frame.size.width - (tLablel.frame.origin.x + tLablel.frame.size.width +10)- DEFAULT_HEIGHT, 20);
    self.frame = CGRectMake(0, 0, self.frame.size.width, DEFAULT_HEIGHT);
    [(SearchViewController *)vController resetMsgReceiveFrame];
}


@end
