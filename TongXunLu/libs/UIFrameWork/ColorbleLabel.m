//
//  ColorbleLabel.m
//  TongXunLu
//
//  Created by pan on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "ColorbleLabel.h"

@implementation ColorbleLabel

-(void)dealloc
{
    if (_regexstr != nil)   [_regexstr release];
    if (_regexcolor != nil) [_regexcolor release];
    if (_keyword !=nil) [_keyword release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect
{
    if (_regexstr == nil) {
        [super drawTextInRect:rect];
        return;
    }
    
    float paddingx = 0;
    
    float fontwidth = 0;
    for (int i=0 ;i< self.text.length; i++) {
        NSString *nowStr = [self.text substringWithRange:NSMakeRange(i, 1)];
        fontwidth += [nowStr sizeWithFont:self.font].width;
    }
    
    switch (self.textAlignment) {
        case NSTextAlignmentLeft:
            paddingx = 0;
            break;
        case NSTextAlignmentRight:
            paddingx = self.frame.size.width - fontwidth;
            break;
        case NSTextAlignmentCenter:
            paddingx = (self.frame.size.width - fontwidth)/2;
            break;
        default:
            paddingx = 0;
            break;
    }
    CGPoint startPoint = CGPointMake(rect.origin.x + paddingx, rect.size.height/2 - [self.text sizeWithFont:self.font].height /2);

    DLog(@"_regexstr is %@",_regexstr);
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",[NSString stringWithFormat:@".*%@.*",_regexstr]];
    if (_regexstr != nil && [pred evaluateWithObject:self.text] && _keyword == nil) {

        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:_regexstr options:NSRegularExpressionCaseInsensitive error:nil];
        NSRange regexRange =[expression rangeOfFirstMatchInString:self.text options:NSMatchingCompleted range:NSMakeRange(0, [self.text length])];
        
        NSString *currentstr = [self.text substringWithRange:regexRange];
        NSString *befroestr = [self.text substringToIndex:regexRange.location];
        NSString *afterstr = [self.text substringFromIndex:(regexRange.location+ regexRange.length)];
        
        float nowWidth = 0;

        [self.textColor set];
        for (int i=0 ;i< befroestr.length; i++) {
            NSString *nowStr = [befroestr substringWithRange:NSMakeRange(i, 1)];
            [nowStr drawAtPoint:CGPointMake(startPoint.x + nowWidth, startPoint.y) withFont:self.font];
            nowWidth += [nowStr sizeWithFont:self.font].width;
        }
    
        [_regexcolor set];
        for (int i=0 ;i< currentstr.length; i++) {
            NSString *nowStr = [currentstr substringWithRange:NSMakeRange(i, 1)];
            [nowStr drawAtPoint:CGPointMake(startPoint.x + nowWidth, startPoint.y) withFont:self.font];
            nowWidth += [nowStr sizeWithFont:self.font].width;
        }

        
        [self.textColor set];
        for (int i=0 ;i< afterstr.length; i++) {
            NSString *nowStr = [afterstr substringWithRange:NSMakeRange(i, 1)];
            [nowStr drawAtPoint:CGPointMake(startPoint.x + nowWidth, startPoint.y) withFont:self.font];
            nowWidth += [nowStr sizeWithFont:self.font].width;
        }

    }
    else if (_keyword != nil)
    {
        //按正则匹配到的字符串中的keyword染色
        float nowWidth = 0;
        int currentKeywordIndex = 0;
        for (int i=0 ;i< self.text.length; i++) {
            [self.textColor set];
            
            NSString *nowStr = [self.text substringWithRange:NSMakeRange(i, 1)];
            if (_keyword != nil) {
                for (int j=currentKeywordIndex; j< _keyword.length; j++) {
                    NSString *nowkeyword = [_keyword substringWithRange:NSMakeRange(j, 1)];
                    
                    if ([nowStr isEqualToString:nowkeyword]) {
                        [_regexcolor set];
                        //DLog(@"区配到 %@,%@",nowStr,nowkeyword);
                        currentKeywordIndex++;
                        break;
                    }
                }
                
            }
            [nowStr drawAtPoint:CGPointMake(startPoint.x + nowWidth, startPoint.y) withFont:self.font];
            nowWidth += [nowStr sizeWithFont:self.font].width;
        }
    }else {
        float nowWidth = 0;
        
        for (int i=0 ;i< self.text.length; i++) {
            [self.textColor set];
            NSString *nowStr = [self.text substringWithRange:NSMakeRange(i, 1)];
            [nowStr drawAtPoint:CGPointMake(startPoint.x + nowWidth, startPoint.y) withFont:self.font];
            nowWidth += [nowStr sizeWithFont:self.font].width;
            //DLog(@"nowStr is %@",nowStr);
        }
    }

}

-(void)cleanColor
{
    _keyword = nil;
    _regexstr = @"";
    [self setNeedsDisplay];
}
-(void)ColorRegex:(NSString *)regexstr withColor:(UIColor *)color
{
    DLog(@"ColorRegex regexstr %@",regexstr);
    _regexcolor = [color retain];
    _regexstr = [regexstr retain];
    _keyword = nil;
    
    [self setNeedsDisplay];
}

-(void)ColorRegex:(NSString *)regexstr byKeyword:(NSString *)keyword withColor:(UIColor *)color
{
    DLog(@"ColorRegex regexstrbyKeyword %@,%@",regexstr,keyword);
    _regexcolor = [color retain];
    _regexstr = [regexstr retain];
    _keyword = [keyword retain];
    
    [self setNeedsDisplay];
}

@end
