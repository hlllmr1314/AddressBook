//
//  SHMUser.h
//  TongXunLu
//
//  Created by Mac Mini on 13-6-7.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMUser : NSObject

+ (SHMUser *)sharedUser;

@property(nonatomic,strong)NSString *downloadURL;
@property(nonatomic,strong)NSNumber *forceUpdateAPP;
@property(nonatomic,strong)NSNumber *forceUpdateData;
@property(nonatomic,strong)NSNumber *lastAPP;
@property(nonatomic,strong)NSNumber *lastData;

@property(nonatomic,strong)NSString *cellPhone;

@property(nonatomic,strong)NSDate *dateShowAlertUpApp;

- (BOOL)canShowAlert;

@end
