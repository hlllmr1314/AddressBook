//
//  POAPinyin.h
//  POA
//
//  Created by haung he on 11-7-18.
//  Copyright 2011年 huanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  struct pinyinTableCell{
    __unsafe_unretained   NSString * pinyin;
    __unsafe_unretained   NSString * hanzi;
}pinyinTableCell;

@interface POAPinyin : NSObject {
    
}

+ (NSString *) convert:(NSString *) hzString;//输入中文，返回拼音。

//  added by setimouse ( setimouse@gmail.com )
+ (NSString *)quickConvert:(NSString *)hzString;
+ (void)clearCache;
+ (NSString *) getRandName;
+(NSArray *) makePinYin:(NSString *) hz;
//  ------------------

@end
