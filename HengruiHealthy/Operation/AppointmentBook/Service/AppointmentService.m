//
//  AppointmentService.m
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentService.h"
#import "Connecter.h"
#import "AppointmentBook.h"
#import <MJExtension.h>

@implementation AppointmentService

+ (instancetype)shareInstance {
    static AppointmentService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[AppointmentService alloc] init];
    });
    return service;
}

- (void)getAppointmentBooks:(NSMutableDictionary *)params handler:(void (^)(NSArray<AppointmentBook *> *, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpert";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:params result:^(id response, BOOL isSuccess) {
        NSLog(@"%@",response);
        //NSArray *records = [AppointmentRecord mj_objectArrayWithKeyValuesArray:response[@"Items"]];
        NSArray *books = [AppointmentBook mj_objectArrayWithKeyValuesArray:response[@"Items"]];
        handler(books,isSuccess);
    }];
}


@end






