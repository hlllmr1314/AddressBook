//
//  NetClient.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-6.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "NetClient.h"

@implementation NetClient
+(NetClient *)sharedClient
{
    static NetClient *sharedInstance; 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetClient alloc] initWithBase];
    });
    
    return sharedInstance;
}

- (id)initWithBase
{
    self.r = [Reachability reachabilityWithHostname:@"www.apple.com"];
   
    self = [super initWithBaseURL:[NSURL URLWithString:SERVER_ADD]];
    
    if (self) {
        //        [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        /**
         受当前服务器糟糕设计的限制，暂时不做限制。
         */
        //        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
    }
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    [request setTimeoutInterval:120];
    return request;
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
   
    [request setTimeoutInterval:120];
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

+ (NSString *)strFromDic:(NSDictionary *)dic
{
    return [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONReadingMutableContainers error:nil] encoding:NSUTF8StringEncoding];
}

@end
