//
//  NetClient+ToPath.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-6.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (ToPath)

//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token isNotForm:(BOOL)isNotForm;
//
//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure toJson:(Boolean)toJson;
//
//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token;

- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token toJson:(Boolean)toJson isNotForm:(BOOL)isNotForm parameterEncoding:(AFHTTPClientParameterEncoding)parameterEncoding;

- (void)zipDownload:(NSString *)path processBlock:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))processBlock complate:(void(^)(id complateJson))complate failure:(void(^)(NSMutableDictionary *dic))failure;
@end
