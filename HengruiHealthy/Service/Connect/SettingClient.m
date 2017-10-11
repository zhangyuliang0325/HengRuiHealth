//
//  SettingClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SettingClient.h"

#import "Connecter.h"

@implementation SettingClient

+ (instancetype)shareInstance {
    static SettingClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[SettingClient alloc] init];
    });
    return client;
}

- (void)logoutWithHandler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/LogOff";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:nil result:handler];
}

- (void)getMessageCount:(void (^)(id, BOOL))handler {
    NSString *file = @"Message/QueryRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    parameters[@"IsCountOnly"] = @"true";
    parameters[@"IsRead"] = @"false";
    parameters[@"InMessageType"] = @"健康-预约专家-回复;健康-健康建议";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)getMessages:(void (^)(id, BOOL))handler {
    NSString *file = @"Message/QueryRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    parameters[@"InMessageType"] = @"健康-预约专家-回复;健康-健康建议";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

@end
