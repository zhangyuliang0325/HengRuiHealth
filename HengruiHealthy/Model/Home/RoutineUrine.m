//
//  RoutineUrine.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "RoutineUrine.h"

@implementation RoutineUrine

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"Id":@"Id",
             @"measureTime":@"Collectdate",
             @"baixibao":@"LEU",
             @"yaxiaosuanyan":@"NIT",
             @"niaodanyuan":@"UBG",
             @"danbaizhi":@"PRO",
             @"ph":@"PH"
             };
}

@end
