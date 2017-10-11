//
//  EvalueLabel.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EvalueLabel.h"

@implementation EvalueLabel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"category":@"Category",
             @"labelId":@"Id",
             @"labelName":@"Tag"
             };
}

@end
