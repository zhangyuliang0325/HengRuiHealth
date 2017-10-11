//
//  MedicaitonClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicaitonClient.h"

#import "Connecter.h"

@implementation MedicaitonClient

+ (instancetype)shareInstance {
    static MedicaitonClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[MedicaitonClient alloc] init];
    });
    return client;
}

- (void)getMedication:(NSString *)keywords page:(NSString *)page limit:(NSString *)limit handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryDrug";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"SearchKey"] = keywords;
    parameters[@"PageIndex"] = page;
    parameters[@"QueryLimit"] = limit;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)getMedicationRecords:(NSString *)userId page:(NSString *)page limit:(NSString *)limit min:(NSString *)min max:(NSString *)max handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryTakeMedicationRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserId"] = userId;
    parameters[@"PageIndex"] = page;
    parameters[@"QueryLimit"] = limit;
    parameters[@"CreateTimeMin"] = min;
    parameters[@"CreateTimeMax"] = max;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)addMedicationRecord:(NSString *)recordId user:(NSString *)userId from:(NSString *)from to:(NSString *)to remark:(NSString *)remark medications:(NSArray *)medications handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveTakeMedicationRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = recordId;
    parameters[@"UserId"] = userId;
    parameters[@"FromDate"] = from;
    parameters[@"ToDate"] = to;
    parameters[@"Remark"] = remark;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:medications options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    parameters[@"Detail"] = jsonString;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

@end
