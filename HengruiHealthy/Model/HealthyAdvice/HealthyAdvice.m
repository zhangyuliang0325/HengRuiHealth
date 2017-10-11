//
//  HealthyAdvice.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyAdvice.h"

#import "Expert.h"

@implementation HealthyAdvice

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"expert":@"Expert",
             @"time":@"CreateTime",
             @"content":@"SuggestionContent",
             @"adviceId":@"Id",
             @"archives":@"HealthRecord",
             @"isRead":@"IsRead"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"archives":@"HealthyArchive"
             };
}

@end
