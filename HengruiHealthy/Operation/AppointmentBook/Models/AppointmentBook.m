//
//  AppointmentBook.m
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentBook.h"
#import <MJExtension.h>

@implementation AppointmentBook

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"answerReplyCount":@"AnswerReplyCount",
             @"birthday":@"Birthday",
             @"createTime":@"CreateTime",
             @"evaluateContent":@"EvaluateContent",
             @"evaluateTag":@"EvaluateTag",
             @"evaluateTagCategory":@"EvaluateTagCategory",
             @"evaluateTime":@"EvaluateTime",
             @"evaluateValue":@"EvaluateValue",
             @"expert":@"Expert",
             @"expertId":@"ExpertId",
             @"friendlyId":@"FriendlyId",
             @"healthRecord":@"HealthRecord",
             @"healthRecordFriendlyId":@"HealthRecordFriendlyId",
             @"isEnd":@"IsEnd",
             @"isEvaluate":@"IsEvaluate",
             @"isHideEvaluate":@"IsHideEvaluate",
             @"isPayment":@"IsPayment",
             @"isReservationOverdue":@"IsReservationOverdue",
             @"lastReply":@"LastReply",
             @"patientUser":@"PatientUser",
             @"paymentAmount":@"PaymentAmount",
             @"paymentRemark":@"PaymentRemark",
             @"paymentType":@"PaymentType",
             @"remark":@"Remark",
             @"reservationTime":@"ReservationTime",
             @"sequence":@"Sequence",
             @"sex":@"Sex",
             @"unreadReplyCount":@"UnreadReplyCount",
             @"userId":@"UserId",
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"healthRecord":@"AppointmentBookHealthRecord"
             };
}

@end


@implementation AppointmentBookExpert

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"consultPrice":@"ConsultPrice",
             @"duties":@"Duties",
             @"evaluate":@"Evaluate",
             @"expertise":@"Expertise",
             @"name":@"Name",
             @"profile":@"Profile",
             @"smallImageUrl":@"SmallImageUrl",
             };
}

@end

@implementation AppointmentBookHealthRecord

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Dalx_Bl":@"Dalx_Bl",
             @"Dalx_Yyfa":@"Dalx_Yyfa",
             @"Dalx_Yyjc":@"Dalx_Yyjc",
             @"friendlyId":@"FriendlyId",
             @"Jczz_SfDydssjdn":@"Jczz_SfDydssjdn",
             @"Jczz_SfFlkg":@"Jczz_SfFlkg",
             @"Jczz_SfFzxh":@"Jczz_SfFzxh",
             @"Jczz_SfXs":@"Jczz_SfXs",
             @"Jczz_SfZhdh":@"Jczz_SfZhdh",
             @"recordTime":@"RecordTime",
             @"recordUser":@"RecordUser",
             @"remark":@"Remark",
             @"sequence":@"Sequence",
             @"Sjbb_SfBmfx":@"Sjbb_SfBmfx",
             @"Sjbb_SfPfsr":@"Sjbb_SfPfsr",
             @"Sjbb_SfSzmm":@"Sjbb_SfSzmm",
             @"userId":@"UserId",
             @"Wxh_SfSlmhxj":@"Wxh_SfSlmhxj",
             @"Wxh_SfSzflr":@"Wxh_SfSzflr",
             @"Wxh_SfTnbsb":@"Wxh_SfTnbsb",
             @"Wxh_SfTnbz":@"Wxh_SfTnbz",
             };
}

@end


@implementation AppointmentBookHealthRecordUser

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"fullName":@"FullName",
             @"headPortraitUrl":@"HeadPortraitUrl",
             @"mobileNumber":@"MobileNumber",
             @"nickname":@"Nickname",
             @"sex":@"Sex",
             @"userJob":@"UserJob",
             @"userName":@"UserName",
             };
}

@end

@implementation AppointmentBookLastReply

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"createTime":@"CreateTime",
             @"replyContent":@"ReplyContent",
             @"replyUserId":@"ReplyUserId",
             @"replyUserType":@"ReplyUserType",
             };
}

@end

@implementation AppointmentBookPatientUser

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"fullName":@"FullName",
             @"mobileNumber":@"MobileNumber",
             @"nickname":@"Nickname",
             @"userDuties":@"UserDuties",
             };
}

@end



