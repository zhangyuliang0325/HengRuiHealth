//
//  BloodProsure.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BloodProsure.h"

@implementation BloodProsure

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             
             @"dataId":@"DataId",
             @"measureTime":@"Collectdate",
             @"diastolicpressure":@"Diastolicpressure",
             @"systolicpressure":@"Systolicpressure"
             };
}

@end
