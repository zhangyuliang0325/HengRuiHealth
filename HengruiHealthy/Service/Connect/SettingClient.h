//
//  SettingClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingClient : NSObject

+ (instancetype)shareInstance;

- (void)logoutWithHandler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getMessageCount:(void(^)(id response, BOOL isSuccess))handler;
- (void)getMessages:(void(^)(id response, BOOL isSuccess))handler;

@end
