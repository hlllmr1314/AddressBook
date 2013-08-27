//
//  QTextField.m
//  PocketZhe2
//
//  Created by Pan on 13-1-28.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import "QTextField.h"

@implementation QTextField
@synthesize verified;
@synthesize name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.returnKeyType = UIReturnKeyDone;

        UIImage *bgimage = [UIImage imageNamed:@"textfieldbg.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(7.5, 5, 7.5, 5);
        if ([bgimage respondsToSelector:@selector(resizableImageWithCapInsets::)]){
            bgimage = [bgimage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        }else{
            bgimage = [bgimage resizableImageWithCapInsets:insets];
        }        self.enabled = YES;
        self.background = bgimage;
        self.textAlignment = UITextAlignmentLeft;
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGSize fontsize = [@"A" sizeWithFont:self.font];
    return CGRectMake(4, (bounds.size.height - fontsize.height)/2, bounds.size.width-8, bounds.size.height-(bounds.size.height - fontsize.height));
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled) {
        UIImage *bgimage = [UIImage imageNamed:@"textinput_unenable.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(7.5, 5, 7.5, 5);
        if ([bgimage respondsToSelector:@selector(resizableImageWithCapInsets::)]){
            bgimage = [bgimage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        }else{
            bgimage = [bgimage resizableImageWithCapInsets:insets];
        }
        self.background = bgimage;
    }else
    {
        UIImage *bgimage = [UIImage imageNamed:@"textfieldbg.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(7.5, 5, 7.5, 5);
        if ([bgimage respondsToSelector:@selector(resizableImageWithCapInsets::)]){
            bgimage = [bgimage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        }else{
            bgimage = [bgimage resizableImageWithCapInsets:insets];
        }
        self.background = bgimage;
    }
}

-(void)setVerified:(BOOL)isv
{
    verified = isv;
    if (isv) {
        self.enabled = NO;
    }
}

-(void)setText:(NSString *)text
{
    if ((NSNull *)text == [NSNull null]) {
        text = @"";
    }
    [super setText:text];
}
@end
