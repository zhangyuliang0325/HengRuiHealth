//
//  AppointmentRemark.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface AppointmentRemark : NSObject

@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *remarkId;
@property (copy, nonatomic) NSString *remarkContent;
@property (copy, nonatomic) NSString *remarkerName;
@property (copy, nonatomic) NSString *remarkerMobile;
@property (copy, nonatomic) NSString *remarkerId;
@property (copy, nonatomic) NSString *remarkerType;
@property (copy, nonatomic) NSString *appointmentId;

@end
