//
//  HomeClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeClient : NSObject

FOUNDATION_EXTERN NSString *const FATFILE;//体脂
FOUNDATION_EXTERN NSString *const BLOODSUGERFILE;//血糖
FOUNDATION_EXTERN NSString *const SPOFILE;//血氧
FOUNDATION_EXTERN NSString *const WEIGHTFILE;//体重
FOUNDATION_EXTERN NSString *const BLOODPRESSUREFILE;//血压
FOUNDATION_EXTERN NSString *const ELECTROCARDIOFILE;// 心电
FOUNDATION_EXTERN NSString *const ROUTINEURINEFILE;//尿常规
FOUNDATION_EXTERN NSString *const BLOODFATFILE;//血脂

FOUNDATION_EXTERN NSString *const MEASURETIME;//时间
FOUNDATION_EXTERN NSString *const BMI;//体脂
FOUNDATION_EXTERN NSString *const DIASTOLICPRESSURE;//高压
FOUNDATION_EXTERN NSString *const SYSTOLICPRESSURE;//低压
FOUNDATION_EXTERN NSString *const OXYGEN;//血氧
FOUNDATION_EXTERN NSString *const BLOODSUGER;//血糖
FOUNDATION_EXTERN NSString *const WEIGHT;//体重

FOUNDATION_EXTERN NSString *const ASC;//正序
FOUNDATION_EXTERN NSString *const DESC;//倒叙

+ (instancetype)shareInstance;

- (void)obtainChartFile:(NSString *)file fromDate:(NSString *)fromDate toDate:(NSString *)toDate sort:(NSString *)sort handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)obtainChartInfoForFile:(NSString *)file item:(NSString *)item sort:(NSString *)sort handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)obtainArchivesForFile:(NSString *)file fromDate:(NSString *)fromDate toDate:(NSString *)toDate sort:(NSString *)sort pageIndex:(NSInteger)page handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)downloadImageForElectrocardioId:(NSString *)ElectrocardioId handler:(void(^)(id response, BOOL isSuccess))handler;

- (void)obtanExpertListAtPage:(NSString *)pageNumber limit:(NSString *)limit sort:(NSString *)sort handler:(void(^)(id response, BOOL isSuccess))handler;

@end
