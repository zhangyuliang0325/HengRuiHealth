
//
//  HomeClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HomeClient.h"

#import "Connecter.h"

#import "CheckStringManager.h"

NSString *const FATFILE = @"QueryFatDataV1";
NSString *const BLOODSUGERFILE = @"QueryBGDataV1";
NSString *const SPOFILE = @"QuerySpo2DataV1";
NSString *const WEIGHTFILE = @"QueryWeightDataV1";
NSString *const BLOODPRESSUREFILE = @"QueryBloodPressureV1";
NSString *const ELECTROCARDIOFILE = @"QueryEcgStructV1";
NSString *const ROUTINEURINEFILE = @"QueryURDataV1";
NSString *const BLOODFATFILE = @"QueryBD_FATDataV1";

NSString *const MEASURETIME = @"Collectdate";
NSString *const BMI = @"Bmi";
NSString *const DIASTOLICPRESSURE = @"Diastolicpressure";
NSString *const SYSTOLICPRESSURE = @"Systolicpressure";
NSString *const OXYGEN = @"Oxygen";
NSString *const BLOODSUGER = @"Bloodsugar";
NSString *const WEIGHT = @"weight";

NSString *const ASC = @"asc";
NSString *const DESC = @"desc";

@implementation HomeClient

+ (instancetype)shareInstance {
    static HomeClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[HomeClient alloc] init];
    });
    return client;
}

- (void)obtainChartFile:(NSString *)file fromDate:(NSString *)fromDate toDate:(NSString *)toDate sort:(NSString *)sort handler:(void (^)(id, BOOL))handler {
    NSString *fileName = [NSString stringWithFormat:@"DeviceData/%@", file];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    parameters[@"CollectdateMin"] = fromDate;
    parameters[@"CollectdateMax"] = toDate;
    parameters[@"Sort"] = [NSString stringWithFormat:@"Collectdate %@", sort];
    [[Connecter shareInstance] connectServerGetWithPath:fileName parameters:parameters result:handler];
}

- (void)obtainChartInfoForFile:(NSString *)file item:(NSString *)item sort:(NSString *)sort handler:(void (^)(id, BOOL))handler {
    NSString *fileName = [NSString stringWithFormat:@"DeviceData/%@", file];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    parameters[@"IsGetOne"] = @"true";
    parameters[@"Sort"] = [NSString stringWithFormat:@"%@ %@", item, sort];
    parameters[@"QueryLimit"] = @"1";
    [[Connecter shareInstance] connectServerGetWithPath:fileName parameters:parameters result:handler];
}

- (void)obtainArchivesForFile:(NSString *)file fromDate:(NSString *)fromDate toDate:(NSString *)toDate sort:(NSString *)sort pageIndex:(NSInteger)page handler:(void (^)(id, BOOL))handler {
    NSString *fileName = [NSString stringWithFormat:@"DeviceData/%@", file];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    parameters[@"PageIndex"] = [NSString stringWithFormat:@"%d", (int)page];
    parameters[@"QueryLimit"] = @"15";
    parameters[@"Sort"] = [NSString stringWithFormat:@"Collectdate %@", sort];
    if (![CheckStringManager checkBlankString:fromDate]) {
        parameters[@"CollectdateMin"] = fromDate;
    }
    if (![CheckStringManager checkBlankString:toDate]) {
        parameters[@"CollectdateMax"] = toDate;
    }
    [[Connecter shareInstance] connectServerGetWithPath:fileName parameters:parameters result:handler];
}

- (void)downloadImageForElectrocardioId:(NSString *)ElectrocardioId handler:(void (^)(id, BOOL))handler {
    
}


- (void)obtanExpertListAtPage:(NSString *)pageNumber limit:(NSString *)limit sort:(NSString *)sort handler:(void (^)(id, BOOL))handler {
    NSString *fileName = @"Health/QueryExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"PageIndex"] = pageNumber;
    parameters[@"QueryLimit"] = limit;
    parameters[@"Sort"] = sort;
    [[Connecter shareInstance] connectServerGetWithPath:fileName parameters:parameters result:handler];
}

@end
