//
//  AppointmentBook.h
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppointmentBookExpert;
@class AppointmentBookLastReply;
@class AppointmentBookPatientUser;

@interface AppointmentBook : NSObject

@property (nonatomic,assign) int answerReplyCount;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *evalueContent;
@property (nonatomic,copy) NSString *evaluateTag;
@property (nonatomic,copy) NSString *evaluateTagCategory;
@property (nonatomic,copy) NSString *evaluateTime;
@property (nonatomic,assign) int evaluateValue;
@property (nonatomic,retain) AppointmentBookExpert *expert;
@property (nonatomic,copy) NSString *expertId;
@property (nonatomic,copy) NSString *friendlyId;
@property (nonatomic,retain) NSArray *healthRecord;
@property (nonatomic,copy) NSString *healthRecordFriendlyId;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,assign) BOOL isEvaluate;
@property (nonatomic,copy) NSString *isHideEvaluate;
@property (nonatomic,assign) BOOL isPayment;
@property (nonatomic,assign) BOOL isReservationOverdue;
@property (nonatomic,retain) AppointmentBookLastReply *lastReply;
@property (nonatomic,retain) AppointmentBookPatientUser *patientUser;
@property (nonatomic,copy) NSString *paymentAmount;
@property (nonatomic,copy) NSString *paymentRemark;
@property (nonatomic,copy) NSString *paymentType;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *reservationTime;
@property (nonatomic,assign) int sequence;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,assign) int unreadReplyCount;
@property (nonatomic,copy) NSString *userId;



@end


@interface AppointmentBookExpert:NSObject

@property (nonatomic,copy) NSString *consultPrice;
@property (nonatomic,copy) NSString *duties;
@property (nonatomic,assign) int evaluate;
@property (nonatomic,copy) NSString *expertise;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile;
@property (nonatomic,copy) NSString *smallImageUrl;

@end


@class AppointmentBookHealthRecordUser;

@interface AppointmentBookHealthRecord:NSObject

@property (nonatomic,copy) NSString *Dalx_Bl;
@property (nonatomic,copy) NSString *Dalx_Yyfa;
@property (nonatomic,copy) NSString *Dalx_Yyjc;
@property (nonatomic,copy) NSString *friendlyId;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,assign) BOOL Jczz_SfDydssjdn;
@property (nonatomic,assign) BOOL Jczz_SfFlkg;
@property (nonatomic,assign) BOOL Jczz_SfFzxh;
@property (nonatomic,assign) BOOL Jczz_SfXs;
@property (nonatomic,assign) BOOL Jczz_SfZhdh;
@property (nonatomic,copy) NSString *recordTime;
@property (nonatomic,retain) AppointmentBookHealthRecordUser *recordUser;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,assign) int sequence;
@property (nonatomic,assign) BOOL Sjbb_SfBmfx;
@property (nonatomic,assign) BOOL Sjbb_SfPfsr;
@property (nonatomic,assign) BOOL Sjbb_SfSzmm;
@property (nonatomic,assign) BOOL Wxh_SfSlmhxj;
@property (nonatomic,assign) BOOL Wxh_SfSzflr;
@property (nonatomic,assign) BOOL Wxh_SfTnbsb;
@property (nonatomic,assign) BOOL Wxh_SfTnbz;
@property (nonatomic,copy) NSString *userId;

@end

@interface AppointmentBookHealthRecordUser:NSObject

@property (nonatomic,copy) NSString *fullName;
@property (nonatomic,copy) NSString *headPortraitUrl;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *mobileNumber;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *userJob;
@property (nonatomic,copy) NSString *userName;

@end


@interface AppointmentBookLastReply:NSObject

@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *replyContent;
@property (nonatomic,copy) NSString *replyUserId;
@property (nonatomic,copy) NSString *replyUserType;

@end

@interface AppointmentBookPatientUser:NSObject

@property (nonatomic,copy) NSString *fullName;
@property (nonatomic,copy) NSString *mobileNumber;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *userDuties;

@end




