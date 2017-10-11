//
//  AppointmentRecord.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Expert.h"
#import "Person.h"

@interface AppointmentRecord : NSObject

@property (copy, nonatomic) NSString *recordId;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *evalueContent;
@property (assign, nonatomic) BOOL isEvalue;
@property (assign, nonatomic) BOOL isPay;
@property (assign, nonatomic) BOOL isEnd;
@property (assign, nonatomic) NSString *realPay;
@property (assign, nonatomic) int starCount;
@property (copy, nonatomic) NSString *evalueLabel;
@property (copy, nonatomic) NSString *evalueCategory;
@property (strong, nonatomic) Expert *expert;
@property (copy, nonatomic) NSString *expertId;
@property (copy, nonatomic) NSString *friendlyId;
@property (strong, nonatomic) NSArray *reports;
@property (copy, nonatomic) NSString *healthRecordFriendlyId;
@property (copy, nonatomic) NSString *lastReplyId;
@property (copy, nonatomic) NSString *lastReplyTime;
@property (copy, nonatomic) NSString *lastReplyUserId;
@property (copy, nonatomic) NSString *lastReplyUserType;
@property (strong, nonatomic) Person *patient;
@property (copy, nonatomic) NSString *payType;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *lastEvlueTime;
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) int unreadCount;
@property (copy, nonatomic) NSString *userId;

@end

