//
//  AppointmentRemark.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentRemark.h"

@implementation AppointmentRemark

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"createTime":@"CreateTime",
             @"remarkId":@"Id",
             @"remarkContent":@"ReplyContent",
             @"remarkerName":@"ReplyUser.FullName",
             @"remarkerMobile":@"ReplyUser.MobileNumber",
             @"remarkerId":@"ReplyUserId",
             @"remarkerType":@"ReplyUserType",
             @"appointmentId":@"ReservationId"
             };
}

@end
