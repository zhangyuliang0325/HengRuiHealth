//
//  Connecter.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Connecter.h"

static NSString *_cookicValue =  @" ";

@implementation Connecter

+ (instancetype)shareInstance {
    static Connecter *connecter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connecter = [[Connecter alloc] init];
        connecter.requestSerializer = [AFHTTPRequestSerializer serializer];
        connecter.responseSerializer = [AFHTTPResponseSerializer serializer];
        connecter.requestSerializer.timeoutInterval = 20;
        [connecter.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [connecter.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [connecter.requestSerializer setHTTPShouldHandleCookies:YES];
    });
    [connecter.requestSerializer setValue:_cookicValue forHTTPHeaderField:@"Cookie"];
    return connecter;
}

- (void)setCookieValue:(NSString *)value {
    [self.requestSerializer setValue:value forHTTPHeaderField:@"Cookie"];
}

- (NSURLSessionDataTask *)connectServerPostWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result {
    NSString *url = [NSString stringWithFormat:@"%@api/%@", BasePath, file];
    NSURLSessionDataTask *dataTask = [self POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        result(dicResponse, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *errorInfo = error.userInfo;
        NSString *errorLocalized = errorInfo[@"NSLocalizedDescription"];
        if ([errorLocalized isEqualToString:@"The request timed out."]) {
            result(@"连接超时，请重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"Could not connect to the server."]) {
            result(@"无法连接服务器，请稍后重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"The Internet connection appears to be offline."]) {
            result(@"网络不存在，请检查后重试", NO);
            return;
        }
        id data = errorInfo[@"com.alamofire.serialization.response.error.data"];        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
//            NSLog(@"%@", jsonError);
            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@", errorString);
            result(errorString, NO);
        } else {
//            NSLog(@"%@", dict);
            NSString *errorMessage = dict[@"Message"];
            result(errorMessage, NO);
        }
    }];
//    NSURLSessionDataTask *dataTask = [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        result(dicResponse, YES);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSDictionary *errorInfo = error.userInfo;
//        NSString *errorLocalized = errorInfo[@"NSLocalizedDescription"];
//        if ([errorLocalized isEqualToString:@"The request timed out."]) {
//            result(@"连接超时，请重试", NO);
//            return;
//        } else if ([errorLocalized isEqualToString:@"Could not connect to the server."]) {
//            result(@"无法连接服务器，请稍后重试", NO);
//            return;
//        } else if ([errorLocalized isEqualToString:@"The Internet connection appears to be offline."]) {
//            result(@"网络不存在，请检查后重试", NO);
//            return;
//        }
//        id data = errorInfo[@"com.alamofire.serialization.response.error.data"];        NSError *jsonError;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
//        if (jsonError) {
////            NSLog(@"%@", jsonError);
//            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////            NSLog(@"%@", errorString);
//            result(errorString, NO);
//        } else {
////            NSLog(@"%@", dict);
//            NSString *errorMessage = dict[@"Message"];
//            result(errorMessage, NO);
//        }
//    }];
    return dataTask;
}

- (void)connectServerGetWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result {
    NSString *url = [NSString stringWithFormat:@"%@api/%@", BasePath, file];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = res.allHeaderFields;
//        NSLog(@"%@", allHeaders);
        result(dicResponse, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *errorInfo = error.userInfo;
        NSString *errorLocalized = errorInfo[@"NSLocalizedDescription"];
        if ([errorLocalized isEqualToString:@"The request timed out."]) {
            result(@"连接超时，请重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"Could not connect to the server."]) {
            result(@"无法连接服务器，请稍后重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"The Internet connection appears to be offline."]) {
            result(@"网络不存在，请检查后重试", NO);
            return;
        }
        id data = errorInfo[@"com.alamofire.serialization.response.error.data"];        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
//            NSLog(@"%@", jsonError);
            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@", errorString);
            result(errorString, NO);
        } else {
//            NSLog(@"%@", dict);
            NSString *errorMessage = dict[@"Message"];
            result(errorMessage, NO);
        }
    }];
}

- (void)connectServerPostForLoginWithPath:(NSString *)file parameters:(NSDictionary *)parameters result:(void(^)(id response, BOOL isSuccess))result {
    NSString *url = [NSString stringWithFormat:@"%@api/%@", BasePath, file];
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = res.allHeaderFields;
        _cookicValue = allHeaders[@"Cookie"];
        [[NSUserDefaults standardUserDefaults] setObject:allHeaders[@"Cookie"] forKey:@"Cookie_token"];
        result(dicResponse, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *errorInfo = error.userInfo;
        NSString *errorLocalized = errorInfo[@"NSLocalizedDescription"];
        if ([errorLocalized isEqualToString:@"The request timed out."]) {
            result(@"连接超时，请重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"Could not connect to the server."]) {
            result(@"无法连接服务器，请稍后重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"The Internet connection appears to be offline."]) {
            result(@"网络不存在，请检查后重试", NO);
            return;
        }
        id data = errorInfo[@"com.alamofire.serialization.response.error.data"];
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
            NSLog(@"%@", jsonError);
            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", errorString);
            result(errorString, NO);
        } else {
            NSLog(@"%@", dict);
            NSString *errorMessage = dict[@"Message"];
            result(errorMessage, NO);
        }
    }];
}

- (void)uploadFiles:(NSArray *)files forPath:(NSString *)path parameters:(NSDictionary *)parameters result:(void (^)(id, BOOL))result {
    NSString *url = [NSString stringWithFormat:@"%@api/%@", BasePath, path];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < files.count; i ++) {
            NSData *data = files[i];
            [formData appendPartWithFileData:data name:@"image" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        result(response, YES);
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *errorInfo = error.userInfo;
        NSString *errorLocalized = errorInfo[@"NSLocalizedDescription"];
        if ([errorLocalized isEqualToString:@"The request timed out."]) {
            result(@"连接超时，请重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"Could not connect to the server."]) {
            result(@"无法连接服务器，请稍后重试", NO);
            return;
        } else if ([errorLocalized isEqualToString:@"The Internet connection appears to be offline."]) {
            result(@"网络不存在，请检查后重试", NO);
            return;
        }
        id data = errorInfo[@"com.alamofire.serialization.response.error.data"];
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
            NSLog(@"%@", jsonError);
            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", errorString);
            result(errorString, NO);
        } else {
            NSLog(@"%@", dict);
            NSString *errorMessage = dict[@"Message"];
            result(errorMessage, NO);
        }
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }];
}

@end
