//
//  AppointmentService.h
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppointmentBook;

@interface AppointmentService : NSObject

+ (instancetype)shareInstance;

- (void)getAppointmentBooks:(NSMutableDictionary *)params handler:(void(^)(NSArray<AppointmentBook *> *response, BOOL isSuccess))handler;

@end
