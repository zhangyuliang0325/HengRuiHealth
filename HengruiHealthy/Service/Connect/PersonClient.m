//
//  PersonClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonClient.h"

#import "Connecter.h"

@implementation PersonClient

+ (instancetype)shareInstance {
    static PersonClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[PersonClient alloc] init];
    });
    return client;
}

- (void)obtainInfoWithHandler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/QueryUser";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"Id";
    parameters[@"IsGetOne"] = @"true";
    parameters[@"IsQueryResidenceAddress"] = @"true";
    parameters[@"SpecifyProperty"] = @"Id;FullName;Sex;Birthday;IdcardNumber;MobileNumber;PhoneNumber;UserJob;AcademicQualification;WorkUnit;UserDuties;Addresses.Province;Addresses.City;Addresses.District;Addresses.Detail;Addresses.UserId;Addresses.Id";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];

}

- (void)savePersonInfoWithParameters:(NSMutableDictionary *)parameters handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/SaveUser";
    parameters[@"IdentityUserIdAssign"] = @"Id";
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)changeOldPassword:(NSString *)old toNewPassword:(NSString *)newPassword handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/SaveUser";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"OldPassword"] = old;
    parameters[@"Password"] = newPassword;
    parameters[@"IdentityUserIdAssign"] = @"Id";
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)evalueContent:(NSString *)content handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Account/SaveOpinion";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"OpinionContent"] = content;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)getFamilys:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryCustody";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"Id";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)addFamilyName:(NSString *)name mobile:(NSString *)mobile vertity:(NSString *)vertity handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveCustody";
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"Appellation"] = name;
    paramters[@"PatientMobileNumber"] = mobile;
    paramters[@"PatientMobileVerifyCode"] = vertity;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:paramters result:handler];
}

- (void)deleteFamily:(NSString *)familyId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/DeleteCustody";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = familyId;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)getAppointmentRecords:(NSMutableDictionary *)param handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpert";
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
////    parameters[@"UserId"] = userId;
//    parameters[@"IdentityUserIdAssign"] = @"Id";
//    parameters[@"PageIndex"] = page;
//    parameters[@"QueryLimit"] = limit;
//    parameters[@"IsEnd"] = isEnd;
//    parameters[@"IsPayment"] = isPay;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:param result:handler];
}

- (void)getAppointmentRecordDetail:(NSString *)recordId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = recordId;
    parameters[@"IsGetOne"] = @"true";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)saveAppointmentRecord:(NSString *)recordId userId:(NSString *)userId expertId:(NSString *)expertId archiveIds:(NSString *)archiveIds birthday:(NSString *)birthday appointmentTime:(NSString *)appointmentTime sex:(NSString *)sex remark:(NSString *)remark star:(NSString *)star evalueContent:(NSString *)evalueContent evalueLabel:(NSString *)evalueLabel isEnd:(NSString *)isEnd evalueCategory:(NSString *)category handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = recordId;
    parameters[@"UserId"] = userId;
    parameters[@"ExpertId"] = expertId;
    parameters[@"HealthRecordFriendlyId"] = archiveIds;
    parameters[@"Birthday"] = birthday;
    parameters[@"ReservationTime"] = appointmentTime;
    parameters[@"Sex"] = sex;
    parameters[@"Remark"] = remark;
    parameters[@"EvaluateValue"] = star;
    parameters[@"EvaluateContent"] = evalueContent;
    parameters[@"EvaluateTag"] = evalueLabel;
    parameters[@"IsEnd"] = isEnd;
    parameters[@"EvaluateTagCategory"] = category;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)remindRecord:(NSString *)recordId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveReservationExpertRemind";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ReservationId"] = recordId;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)queryPaymentState:(NSString *)orderId alipayResult:(NSString *)alipayResut handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpert";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = orderId;
    parameters[@"IsAskPaymentState"] = @"true";
    parameters[@"SpecifyProperty"] = @"IsPayment";
    parameters[@"AlipaySyncResult"] = alipayResut;
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)getExpertReview:(NSString *)expertId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryReservationExpertReply";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"ReservationId"] = expertId;
    parameters[@"sort"] = @"CreateTime";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)saveExpertReview:(NSString *)reviewId appointmentId:(NSString *)appointmentId content:(NSString *)content handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveReservationExpertReply";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"Id";
    parameters[@"Id"] = reviewId;
    parameters[@"ReservationId"] = appointmentId;
    parameters[@"ReplyContent"] = content;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)savePrompt:(NSString *)promptId title:(NSString *)title time:(NSString *)time weekdays:(NSString *)weekdays ring:(NSString *)ring isVibrating:(NSString *)isVibrating remark:(NSString *)remark enable:(NSString *)enable handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveHealthRemind";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = promptId;
    parameters[@"IdentityUserIdAssign"] = @"Id";
    parameters[@"Title"] = title;
    parameters[@"RemindTime"] = time;
    parameters[@"RemindWeek"] = weekdays;
    parameters[@"Ring"] = ring;
    parameters[@"IsVibrating"] = isVibrating;
    parameters[@"Remark"] = remark;
    parameters[@"IsEnabled"] = enable;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)queryPrompts:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryHealthRemind";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"IdentityUserIdAssign"] = @"UserId";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)removePrompt:(NSString *)promptId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/DeleteHealthRemind";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = promptId;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)queryEvalueLabel:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryTagOfReservationExpertEvaluate";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
    
}

@end
