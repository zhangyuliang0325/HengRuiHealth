//
//  ExpertAppointmentTime.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertAppointmentTime.h"

@implementation ExpertAppointmentTime

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"expertId":@"ExpertId",
             @"isFull":@"IsReservationFull",
             @"count":@"ReservationCount",
             @"time":@"ReservationTime"
             };
}

@end
