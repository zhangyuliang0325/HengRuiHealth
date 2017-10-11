//
//  BloodFat.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BloodFat.h"

@implementation BloodFat

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"Id":@"Id",
             @"measureTime":@"Collectdate",
             @"dangucun":@"CHOL",
             @"gaomidu":@"HDLCHOL",
             @"ganyou":@"TRIG",
             @"dimidu":@"CALCLDL",
             @"bizhi":@"TC_HDL"
             };
}

@end
