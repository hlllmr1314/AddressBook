//
//  LableColor.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-20.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "LableColor.h"
#include <CoreText/CoreText.h>
@implementation LableColor
{
    
    
  //  NSMutableAttributedString *mutaString;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setText:(NSString *)text matchPos:(NSArray *)matchPos
{
    _matchPos = matchPos;
    self.text = text;
    
    [self setNeedsDisplay];
}

//- (NSArray *)matchPosToNSArr:(NSArray *)matchPos
//{
//    
//    NSMutableArray *arrNSRangPro = [[NSMutableArray alloc]initWithCapacity:[matchPos count]];
//    for (int i=0; i<[_matchPos count]; i++) {
//        NSNumber *num = _matchPos[i];
//        dicPro[@"start"] =  _matchPos[i];
//        if (i < [_matchPos count]-1) {
//            if ([_matchPos[i+1] integerValue] == [_matchPos[i] integerValue]+1) {
//                i++;
//            }
//        }
//        if ([_matchPos[i] integerValue] == [_matchPos[i-1] integerValue]+1) {
//            
//            i++;
//        }
//        if (i==0) {            
//            NSMutableDictionary *dicPro = [[NSMutableDictionary alloc] initWithCapacity:2];
//            dicPro[@"start"] = [NSNumber numberWithInt:0];
//            dicPro[@"length"] = [NSNumber numberWithInt:1];
//            [arrNSRangPro addObject:dicPro];
//        }
//    }
//}

- (NSAttributedString *)illuminatedString:(NSString *)text
                                     font:(UIFont *)AtFont{
    
    
    if (![text length]) {
        return  [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *mutaString =
    [[NSMutableAttributedString alloc] initWithString:text?text:@""];
    if (!_matchPos) {
        return  [[NSMutableAttributedString alloc] initWithString:text];
    }
    for (int i=0; i<[_matchPos count]; i++) {
//        if ([_matchPos[i] integerValue]-(i==0?0:([_matchPos[i-1] integerValue]+1)) != 0) {
//            [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
//                               value:(id)[UIColor darkGrayColor].CGColor
//                               range:NSMakeRange(i==0?0:[_matchPos[i-1] integerValue], [_matchPos[i] integerValue]-(i==0?0:([_matchPos[i-1] integerValue]+1)))];
//        }        
        [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                           value:(id)UIColorFromRGB(0xff7800).CGColor
                           range:NSMakeRange([_matchPos[i] integerValue], 1)];
    }
    
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)AtFont.fontName,
                                            AtFont.pointSize,
                                            NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName)
                       value:(__bridge id)ctFont
                       range:NSMakeRange(0, 1)];
  
    CFRelease(ctFont);
   
    return [mutaString copy];
}



- (void)drawRect:(CGRect)rect
{
    if (!self.text.length) {
        [super drawRect:rect];
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width/2,
                          self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    NSArray *fontArray = [UIFont familyNames];
    NSString *fontName;
    if ([fontArray count]) {
        fontName = [fontArray objectAtIndex:0];
    }
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)
                                                      [self illuminatedString:self.text font:self.font]);
  //  CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flush, rect.size.width);
    if (_alignment == alignmentRight) {
        CGSize size = [self.text sizeWithFont:self.font];
        float width2;
       // if( size.width < (self.bounds.size.width/2.0)){
            width2 =   self.bounds.size.width/2 - size.width;
      //  }
        CGContextSetTextPosition(context, ceill(width2),
                                 ceill(self.bounds.size.height/4));
    }else{
        CGContextSetTextPosition(context, ceill(-self.bounds.size.width/2),
                                 ceill(self.bounds.size.height/4));
    }
  
    
    CTLineDraw(line, context);
    CGContextRestoreGState(context);
    CFRelease(line);
    //CGContextRef myContext = UIGraphicsGetCurrentContext();
    //CGContextSaveGState(myContext);
    //[self MyColoredPatternPainting:myContext rect:self.bounds];
    //CGContextRestoreGState(myContext);
}


@end
