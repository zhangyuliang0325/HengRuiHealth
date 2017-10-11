//
//  Medication.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Medication.h"

@implementation Medication

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"medicationId":@"Id",
             @"goodsName":@"NameOfCommodity",
             @"name":@"Name",
             @"imageURL":@"SmallImageUrl",
             @"specification":@"Specification",
             @"countOfUse":@"NumberOfTakeMedication",
             @"company":@"ProductionEnterprise",
             @"profile":@"Profile",
             @"approval":@"ApprovalNumber",
             @"unit":@"TakeMedicationUnit",
             @"dosage":@"TakeMedicationAmount"
             };
}

@end
