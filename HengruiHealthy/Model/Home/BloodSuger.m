//
//  BloodSuger.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BloodSuger.h"

@implementation BloodSuger

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             
             @"dataId":@"DataId",
             @"measureTime":@"Collectdate",
             @"bloodsugare":@"Bloodsugar"
             };
}

@end
