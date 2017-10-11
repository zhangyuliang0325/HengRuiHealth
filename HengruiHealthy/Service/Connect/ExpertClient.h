//
//  ExpertClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertClient : NSObject

+ (instancetype)shartInstance;

- (void)searchExpertByKeyword:(NSString *)keyword sort:(NSString *)sort pageNumer:(NSString *)number limit:(NSString *)limit handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getExpertEvalueLabel:(NSString *)expertId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getExpertEvalueContent:(NSString *)expertId pageNumber:(NSString *)pageNumber limit:(NSString *)limit handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getReviewDatesForExpert:(NSString *)expertId minDate:(NSString *)min handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)appointmentExpert:(NSString *)expertId forUser:(NSString *)userId archives:(NSString *)archiveIds birth:(NSString *)birth replyTime:(NSString *)reply sex:(NSString *)sex remark:(NSString *)remark pay:(NSString *)pay handler:(void(^)(id response, BOOL isSuccess))handler;

@end
