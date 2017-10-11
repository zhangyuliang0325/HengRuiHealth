//
//  Family.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Family.h"

@implementation Family

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"nickName":@"Appellation",
             @"familyId":@"Id",
             @"person":@"PatientUser"
             };
}

@end
