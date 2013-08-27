//
//  NetClient+ToPath.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-6.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "NetClient+ToPath.h"
#import "TokenManager.h"
#import "SBJsonParser.h"

@implementation NetClient (ToPath)

//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token isNotForm:(BOOL)isNotForm
//{
//    [self doPath:method path:path parameters:parameters success:success failure:failure withToken:token toJson:YES isNotForm:isNotForm];
//}
//
//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token
//{
//    [self doPath:method path:path parameters:parameters success:success failure:failure withToken:token isNotForm:NO];
//}
//
//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token toJson:(Boolean)toJson
//{
//    
//    [self doPath:method path:path parameters:parameters success:success failure:failure withToken:token toJson:toJson isNotForm:NO];
//}
//
//- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure toJson:(Boolean)toJson
//{
//    [self doPath:method path:path parameters:parameters success:success failure:failure withToken:NO toJson:toJson isNotForm:NO];
//}

- (void)doPath:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure withToken:(Boolean)token toJson:(Boolean)toJson isNotForm:(BOOL)isNotForm parameterEncoding:(AFHTTPClientParameterEncoding)parameterEncoding
{
    if (token) {
        if (![TokenManager sharedInstance].token) {
            if (failure) {
                failure((NSMutableDictionary *)@{@"500":@"token错误"});
                return;
            }
        }else{
            [self setDefaultHeader:@"token" value:[TokenManager sharedInstance].token];
        }
    }
    
    self.isNotForm = isNotForm;
    self.parameterEncoding = parameterEncoding;
   
    if (![self isNetWork:failure]) {
        return;
    }
    if ([method isEqualToString:@"get"]) {
        [super getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self processSuccess:success responseObject:responseObject operation:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self processFailure:failure statuCode:operation.response.statusCode];
        }];
        return;
    }
    
    if ([method isEqualToString:@"post"]) {
        [super postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (!toJson) {
                [self processSuccess:success responseObject:responseObject operation:operation];
                return;
            }            
            if (success) {
                if (responseObject) {
                    success([self JSONDictionaryWithResponse:responseObject]);
                }else{
                    success(nil);
                }
            
            }          
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {            
            [self processFailure:failure statuCode:operation.response.statusCode];
        }];
        return;
    }

}


- (void)zipDownload:(NSString *)path processBlock:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))processBlock complate:(void(^)(id complateJson))complate failure:(void(^)(NSMutableDictionary *dic))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_ADD,path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //
    [request setValue:[TokenManager sharedInstance].token forHTTPHeaderField:@"Token"];
    [request setValue:@"true" forHTTPHeaderField:@"gzip"];
    [request setValue:@"3" forHTTPHeaderField:@"apiVersion"];
    [request setTimeoutInterval:120];
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *aoperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [aoperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *ope, id responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:ope.responseData encoding:NSUTF8StringEncoding];
        NSData *data = [result dataUsingEncoding:NSISOLatin1StringEncoding];
        data = [data gunzippedData];
//        NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //DLog(@"responseData:%@",responseData);
//        
//        
//        SBJsonParser *parser = [[SBJsonParser alloc]init];
//        id JSON = [parser objectWithString:responseData];
        complate([self JSONDictionaryWithResponse:data]);
       
       
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processFailure:failure statuCode:operation.response.statusCode];
    }];
    [aoperation setDownloadProgressBlock:processBlock ];
    [self enqueueHTTPRequestOperation:aoperation];
}

- (Boolean)isNetWork:(void (^)(NSMutableDictionary *))failure

{
    if ([self.r currentReachabilityStatus] == NotReachable) {
        if (failure) {
            NSMutableDictionary *result = [[NSMutableDictionary alloc]initWithCapacity:2];
            result[@"state"] = [NSNumber numberWithInt:1000];
            result[@"note"] = @"网络连接不可用";
            failure(result);           
        }
        return NO;
    }
    return YES;
}

- (void)processSuccess:(void (^)(NSMutableDictionary *))success responseObject:(id)responseObject operation:(AFHTTPRequestOperation *)operation
{
//    NSLog(@"%@",responseObject);
    NSMutableDictionary *responseDict = [[NSMutableDictionary alloc]initWithCapacity:3];
    if (operation.responseString) {
        responseDict[@"operation"] = operation.responseString;
    }    
    success(responseDict);
    
}

- (void)processFailure:(void (^)(NSMutableDictionary *))failure statuCode:(NSInteger)statuCode
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc]initWithCapacity:2];
    switch (statuCode) {
        case 403:
            result[@"state"] = [NSNumber numberWithInt:403];
            result[@"note"] = @"用户验证失败";
            break;
        case 404:
            result[@"state"] = [NSNumber numberWithInt:404];
            result[@"note"] = @"用户不在群组中";
            break;
        case 409:
            result[@"state"] = [NSNumber numberWithInt:409];
            result[@"note"] = @"该号码目前为丢失状态，请联系管理员";
            break;
        case 410:
            result[@"state"] = [NSNumber numberWithInt:410];
            result[@"note"] = @"您的许可证过期，请联系管理员";
            break;
        case 500:
            result[@"state"] = [NSNumber numberWithInt:500];
            result[@"note"] = @"服务器返回异常";
            break;
        case 304:
            result[@"state"] = [NSNumber numberWithInt:304];
            result[@"note"] = @"已经是最新版本";
            break;
        default:
            result[@"state"] = [NSNumber numberWithInt:1001];
            result[@"note"] = @"网络连接错误";
            break;
    }
    
    if (failure) {
        failure(result);
    }
    
}


- (NSMutableDictionary *)JSONDictionaryWithResponse:(NSData *)responseData
{
    
    //    NSString *base64 = [[NSString alloc] initWithBytes:[responseData bytes]
    //                                                length:[responseData length]
    //                                              encoding:NSASCIIStringEncoding];
    // NSData *decodedData = [NSData dataWithBase64EncodedString:base64];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
    // NSLog(@"%@",base64);
    NSMutableDictionary *result = dict;
    
    if (result[@"state"]) {
        NSNumber *state = result[@"state"];
        if ([state isEqualToNumber:[NSNumber numberWithInt:0]]) {
            return result;
        }
        if ([state isEqualToNumber:[NSNumber numberWithInt:-1000]]) {
            result[@"note"] = @"服务器忙，请稍后再试";
            return result;
        }
        
        if ([state isEqualToNumber:[NSNumber numberWithInt:-999]]) {
            result[@"note"] = @"无效的密钥";
            return result;
        }
        return result;
    }
    if (!result) {
        result = [[NSMutableDictionary alloc]initWithCapacity:2];
    }
    result[@"state"] = [NSNumber numberWithInt:-1001];
    result[@"note"] = @"服务器忙，请稍后再试";
    return result;
    
}
@end
