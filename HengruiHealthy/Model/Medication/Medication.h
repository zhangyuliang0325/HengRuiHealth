//
//  Medication.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface Medication : NSObject

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

@property(assign, nonatomic) BOOL isChoosed;

@end
