//
//  AddMedication.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Medication.h"

@class MedicationInterval;

@interface AddMedication : NSObject

@property (strong, nonatomic) Medication *medication;

@property (assign, nonatomic) BOOL isMorning;
@property (copy, nonatomic) NSString *morningCount;
@property (assign, nonatomic) BOOL isAfternoon;
@property (copy, nonatomic) NSString *afternoonCount;
@property (assign, nonatomic) BOOL isEvening;
@property (copy, nonatomic) NSString *eveningCount;

@property (copy, nonatomic) NSString *medicationId;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *imageURL;
@property (copy, nonatomic) NSString *specification;
@property (copy, nonatomic) NSString *countOfUse;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *profile;
@property (copy, nonatomic) NSString *approval;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *dosage;

@end


