//
//  HealthyAdviceClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyAdviceClient.h"

#import "Connecter.h"

@implementation HealthyAdviceClient

+ (instancetype)shareInstance {
    static HealthyAdviceClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[HealthyAdviceClient alloc] init];
    });
    return client;
}

- (void)getHealthyAdvicesForUser:(NSString *)userId page:(NSString *)page limit:(NSString *)limit min:(NSString *)min max:(NSString *)max handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryHealthSuggestion";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserId"] = userId;
    parameters[@"PageIndex"] = page;
    parameters[@"QueryLimit"] = limit;
    parameters[@"CreateTimeMin"] = min;
    parameters[@"CreateTimeMax"] = max;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)readAdvices:(NSString *)adviceId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveHealthSuggestion";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = adviceId;
    parameters[@"IsRead"] = @"true";
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

@end
