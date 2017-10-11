//
//  HDStatisticsManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HDStatisticsView.h"

#import "HDStatisticsConfiger.h"

@interface HDStatisticsManager : NSObject

+ (instancetype)initWithCoordinateView:(HDStatisticsView *)view andConfig:(HDStatisticsConfiger *)configer;

@end
