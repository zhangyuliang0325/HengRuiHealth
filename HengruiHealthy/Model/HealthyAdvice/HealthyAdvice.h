//
//  HealthyAdvice.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Expert.h"

//#import <MJExtension/MJExtension.h>

@interface HealthyAdvice : NSObject

@property (strong, nonatomic) Expert *expert;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *adviceId;
@property (strong, nonatomic) NSArray *archives;
@property (assign, nonatomic) BOOL isRead;

@end
