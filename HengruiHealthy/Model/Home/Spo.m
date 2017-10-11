//
//  Spo.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Spo.h"

@implementation Spo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             
             @"dataId":@"DataId",
             @"measureTime":@"Collectdate",
             @"oxygen":@"Oxygen"
             };
}

@end
