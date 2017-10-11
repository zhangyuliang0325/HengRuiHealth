//
//  BloodProsure.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface BloodProsure : NSObject

@property (copy, nonatomic) NSString *dataId;
@property (copy, nonatomic) NSString *measureTime;
@property (assign, nonatomic) CGFloat diastolicpressure;
@property (assign, nonatomic) CGFloat systolicpressure;

@end
