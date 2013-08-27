//
//  FunctionButton.m
//  PocketZhe2
//
//  Created by Pan on 13-1-25.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import "FunctionButton.h"

@implementation FunctionButton
@synthesize title, titleLabel;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        UILabel *_titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleL.textAlignment = UITextAlignmentCenter;
        _titleL.backgroundColor = [UIColor clearColor];
        self.titleLabel = _titleL;
       
        
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

-(void)setTitle:(NSString *)atitle
{
    if ([atitle isEqual:[NSNull null]]) {
        atitle = @"";
    }
    title = [atitle copy];
    self.titleLabel.text = title;
}

@end
