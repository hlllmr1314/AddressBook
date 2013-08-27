//
//  UtilUnit.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-13.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "UtilUnit.h"

@implementation UtilUnit
+ (NSArray *)arrPeapleFrom:(NSArray *)unitArray
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:100];
    for (NSDictionary *dicUnit in unitArray) {
        if ([dicUnit[@"subDeptCount"] isEqualToString:@"0"]) {
            [arrPro addObjectsFromArray:dicUnit[@"subUnits"]];
        }else{
          [arrPro addObjectsFromArray:[self arrPeapleFrom:dicUnit[@"subUnits"]]];
        }
    
    }    
    return arrPro;
}
@end
