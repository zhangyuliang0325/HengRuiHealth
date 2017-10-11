//
//  MedicationRecord.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicationRecord.h"



@implementation MedicationRecord

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"recordId":@"Id",
             @"userId":@"UserId",
             @"from":@"FromDate",
             @"to":@"ToDate",
             @"remark":@"Remark",
             @"addMedications":@"Detail"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"addMedications":@"AddMedication"
             };
}

@end
