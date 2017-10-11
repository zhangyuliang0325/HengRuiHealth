//
//  Weight.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Weight.h"

@implementation Weight

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             
             @"dataId":@"DataId",
             @"measureTime":@"Collectdate",
             @"weight":@"weight"
             };
}

@end
