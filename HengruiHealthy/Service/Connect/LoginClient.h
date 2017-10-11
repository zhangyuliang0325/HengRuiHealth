//
//  LoginClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginClient : NSObject

+ (instancetype)shareInstance;

- (void)loginWithAccount:(NSString *)account password:(NSString *)password handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)obtainVertifyByMobile:(NSString *)mobile handler:(void(^)(id responese, BOOL isSuccess))handler;
- (void)registWithAccount:(NSString *)account password:(NSString *)password vertify:(NSString *)vertify handler:(void(^)(id responese, BOOL isSuccess))handler;
- (void)resetPasswordForAccount:(NSString *)account password:(NSString *)password vertify:(NSString *)vertify handler:(void(^)(id responese, BOOL isSuccess))handler;

@end
