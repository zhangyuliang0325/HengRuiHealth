//
//  AppointmentRecord.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentRecord.h"

@implementation AppointmentRecord

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"recordId":@"Id",
             @"birthday":@"Birthday",
             @"createTime":@"CreateTime",
             @"evalueContent":@"AnswerReplyCount",
             @"isEvalue":@"IsEvaluate",
             @"isPay":@"IsPayment",
             @"isEnd":@"IsEnd",
             @"realPay":@"PaymentAmount",
             @"starCount":@"EvaluateValue",
             @"evalueLabel":@"EvaluateTag",
             @"expert":@"Expert",
             @"expertId":@"ExpertId",
             @"friendlyId":@"FriendlyId",
             @"reports":@"HealthRecord",
             @"healthRecordFriendlyId":@"HealthRecordFriendlyId",
             @"lastReplyId":@"LastReply.Id",
             @"lastReplyTime":@"LastReply.CreateTime",
             @"lastReplyUserType":@"LastReply.ReplyUserType",
             @"lastReplyUserId":@"LastReply.ReplyUserId",
             @"patient":@"PatientUser",
             @"payType":@"PaymentType",
             @"remark":@"Remark",
             @"lastEvlueTime":@"ReservationTime",
             @"sex":@"Sex",
             @"unreadCount":@"UnreadReplyCount",
             @"userId":@"UserId"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"reports":@"HealthyArchive"
             };
}

@end
