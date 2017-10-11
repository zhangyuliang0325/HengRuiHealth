//
//  MedicationRecord.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

#import "AddMedication.h"

@interface MedicationRecord : NSObject

@property (copy, nonatomic) NSString *recordId;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *from;
@property (copy, nonatomic) NSString *to;
@property (copy, nonatomic) NSString *remark;
@property (strong, nonatomic) NSArray *addMedications;

@end
