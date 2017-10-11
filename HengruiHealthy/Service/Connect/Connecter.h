//
//  Connecter.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface Connecter : AFHTTPSessionManager

+ (instancetype)shareInstance;

- (NSURLSessionDataTask *)connectServerPostWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result;
- (void)connectServerGetWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result;

- (void)connectServerPostForLoginWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result;

- (void)setCookieValue:(NSString *)value;

- (void)uploadFiles:(NSArray *)files forPath:(NSString *)path parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result;

@end
