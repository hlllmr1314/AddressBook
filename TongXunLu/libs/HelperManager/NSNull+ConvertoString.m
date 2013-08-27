//
//  @interface NSString(setstring) NSString+ConvertoString.m
//  PocketZhe2
//
//  Created by Pan on 13-3-8.
//  Copyright (c) 2013年 qm. All rights reserved.
//

#import "NSNull+ConvertoString.h"

@implementation NSNull (ConvertoString)

-(NSString *)toString
{
    return @"";
}

//-(BOOL)isEqualToString:(NSString *)str
//{
//    DLog(@"isEqualToString:%@",[self class]);
//    return NO;
//}
//
//-(int)length
//{
//    return 0;
//}

@end

@implementation NSString (ConvertoString)

-(NSString *)toString
{
    return [NSString stringWithFormat:@"%@",self];
}
@end