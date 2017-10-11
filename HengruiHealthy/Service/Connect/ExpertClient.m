//
//  ExpertClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertClient.h"

#import "Connecter.h"

@implementation ExpertClient

+ (instancetype)shartInstance {
    static ExpertClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[ExpertClient alloc] init];
    });
    return client;
}

- (void)searchExpertByKeyword:(NSString *)keyword sort:(NSString *)sort pageNumer:(NSString *)number limit:(NSString *)limit handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryExpert";
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"SearchKey"] = keyword;
    paramters[@"Sort"] = sort;
    paramters[@"PageIndex"] = number;
    paramters[@"QueryLimit"] = limit;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:paramters result:handler];
}

- (void)getExpertEvalueLabel:(NSString *)expertId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryExpertEvaluateTag";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ExpertId"] = expertId;
    parameters[@"PageIndex"] = @"1";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)getExpertEvalueContent:(NSString *)expertId pageNumber:(NSString *)pageNumber limit:(NSString *)limit handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ExpertId"] = expertId;
    parameters[@"PageIndex"] = pageNumber;
    parameters[@"QueryLimit"] = limit;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)getReviewDatesForExpert:(NSString *)expertId minDate:(NSString *)min handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryScheduleByReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ExpertId"] = expertId;
//    parameters[@"ReservationTimeMin"] = min;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)appointmentExpert:(NSString *)expertId forUser:(NSString *)userId archives:(NSString *)archiveIds birth:(NSString *)birth replyTime:(NSString *)reply sex:(NSString *)sex remark:(NSString *)remark pay:(NSString *)pay handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ExpertId"] = expertId;
    parameters[@"UserId"] = userId;
    parameters[@"HealthRecordFriendlyId"] = archiveIds;
    parameters[@"Birthday"] = birth;
    parameters[@"ReservationTime"] = reply;
    parameters[@"Sex"] = sex;
    parameters[@"Remark"] = remark;
    parameters[@"PaymentType"] = pay;
    parameters[@"IsPayment"] = @"true";
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

@end
