//
//  HealthyPrompt.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

//#import <MJExtension/MJExtension.h>

@interface HealthyPrompt : NSObject

@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *promptId;
@property (assign, nonatomic) BOOL isEnable;
@property (assign, nonatomic) BOOL isVibrating;
@property (strong, nonatomic) Person *person;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *promptTime;
@property (copy, nonatomic) NSString *ring;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *weekdays;

@property (strong, nonatomic) NSArray *weekdayNames;
@property (strong, nonatomic) NSArray *weekdayCodes;
@property (assign, nonatomic) NSInteger hour;
@property (assign, nonatomic) NSInteger minute;

@end
