//
//  Fat.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Fat.h"



@implementation Fat

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             
             @"dataId":@"DataId",
             @"measureTime":@"Collectdate",
             @"fatcontent":@"Bmi"
             };
}

@end
