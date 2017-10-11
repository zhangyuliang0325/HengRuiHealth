//
//  PersonClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonClient : NSObject

+ (instancetype)shareInstance;

- (void)obtainInfoWithHandler:(void(^)(id response,BOOL isSuccess))handler;
- (void)savePersonInfoWithParameters:(NSMutableDictionary *)parameters handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)changeOldPassword:(NSString *)old toNewPassword:(NSString *)newPassword handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)evalueContent:(NSString *)content handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getFamilys:(void(^)(id response, BOOL isSuccess))handler;
- (void)addFamilyName:(NSString *)name mobile:(NSString *)mobile vertity:(NSString *)vertity handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)deleteFamily:(NSString *)familyId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getAppointmentRecords:(NSMutableDictionary *)param handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getAppointmentRecordDetail:(NSString *)recordId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)saveAppointmentRecord:(NSString *)recordId userId:(NSString *)userId expertId:(NSString *)expertId archiveIds:(NSString *)archiveIds birthday:(NSString *)birthday appointmentTime:(NSString *)appointmentTime sex:(NSString *)sex remark:(NSString *)remark star:(NSString *)star evalueContent:(NSString *)evalueContent evalueLabel:(NSString *)evalueLabel isEnd:(NSString *)isEnd evalueCategory:(NSString *)category handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)remindRecord:(NSString *)recordId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getExpertReview:(NSString *)expertId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)saveExpertReview:(NSString *)reviewId appointmentId:(NSString *)appointmentId content:(NSString *)content handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)queryPaymentState:(NSString *)orderId alipayResult:(NSString *)alipayResut handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)savePrompt:(NSString *)promptId title:(NSString *)title time:(NSString *)time weekdays:(NSString *)weekdays ring:(NSString *)ring isVibrating:(NSString *)isVibrating remark:(NSString *)remark enable:(NSString *)enable handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)queryPrompts:(void(^)(id response, BOOL isSuccess))handler;
- (void)removePrompt:(NSString *)promptId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)queryEvalueLabel:(void(^)(id response, BOOL isSuccess))handler;

@end
