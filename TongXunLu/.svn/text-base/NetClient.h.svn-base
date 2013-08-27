//
//  NetClient.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-6.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
/*mogenerator -m /Users/macmini/Desktop/txl_ios/trunk/SVN_TXL_Shinemo/TongXunLu/AddressBook.xcdatamodeld/AddressBook.xcdatamodel -M /Users/macmini/Desktop/txl_ios/trunk/SVN_TXL_Shinemo/TongXunLu/data/class -H /Users/macmini/Desktop/txl_ios/trunk/SVN_TXL_Shinemo/TongXunLu/data/_class --template-var arc=true
 */
//

#import "AFHTTPClient.h"
#import "Reachability.h"

@interface NetClient : AFHTTPClient
@property (nonatomic,strong) Reachability *r;

+ (NetClient *)sharedClient;

+ (NSString *)strFromDic:(NSDictionary *)dic;
@end
