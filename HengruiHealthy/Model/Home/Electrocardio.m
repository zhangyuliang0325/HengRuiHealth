//
//  Electrocardio.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Electrocardio.h"

@implementation Electrocardio

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"Id":@"Id",
             @"measureTime":@"Collectdate",
             @"T":@"avr_tvolt",
             @"R":@"avr_rvolt",
             @"P":@"avr_pvolt",
             @"QTC2":@"",
             @"QTC1":@"avr_qtc",
             @"QT":@"avr_qt",
             @"PR":@"avr_pr",
//             @"Equal":@"",
             @"Duration":@"",
             @"heartrate":@"avr_heartrate"
             };
}

@end
