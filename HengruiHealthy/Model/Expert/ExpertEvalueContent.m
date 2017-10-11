//
//  ExpertEvalueContent.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertEvalueContent.h"

@implementation ExpertEvalueContent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"archives":@"HealthRecord",
             @"name":@"PatientUser.FullName",
             @"content":@"EvaluateContent",
             @"time":@"EvaluateTime",
             @"starCount":@"EvaluateValue"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"archives":@"HealthyArchive"
             };
}

@end
