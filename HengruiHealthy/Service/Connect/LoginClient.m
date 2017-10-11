//
//  LoginClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "LoginClient.h"

#import "Connecter.h"

@implementation LoginClient

+ (instancetype)shareInstance {
    static LoginClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LoginClient alloc] init];
    });
    return client;
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/Login";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"MobileNumber"] = account;
    parameters[@"Password"] = password;
    [[Connecter shareInstance] connectServerPostForLoginWithPath:file parameters:parameters result:handler];
}

- (void)obtainVertifyByMobile:(NSString *)mobile handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/SendMobileVerifyCode";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"MobileNumber"] = mobile;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)registWithAccount:(NSString *)account password:(NSString *)password vertify:(NSString *)vertify handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/Register";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"MobileNumber"] = account;
    parameters[@"MobileVerifyCode"] = vertify;
    parameters[@"Password"] = password;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)resetPasswordForAccount:(NSString *)account password:(NSString *)password vertify:(NSString *)vertify handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/ResetPassword";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"MobileNumber"] = account;
    parameters[@"MobileVerifyCode"] = vertify;
    parameters[@"Password"] = password;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

@end
