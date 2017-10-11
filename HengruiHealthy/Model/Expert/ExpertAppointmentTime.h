//
//  ExpertAppointmentTime.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface ExpertAppointmentTime : NSObject

@property (copy, nonatomic) NSString *expertId;
@property (assign, nonatomic) BOOL isFull;
@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSString *time;

@end
