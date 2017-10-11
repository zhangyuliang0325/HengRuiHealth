//
//  HealthyAdviceClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthyAdviceClient : NSObject

+ (instancetype)shareInstance;

- (void)getHealthyAdvicesForUser:(NSString *)userId page:(NSString *)page limit:(NSString *)limit min:(NSString *)min max:(NSString *)max handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)readAdvices:(NSString *)adviceId handler:(void(^)(id response, BOOL isSuccess))handler;

@end
