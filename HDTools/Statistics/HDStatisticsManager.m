//
//  HDStatisticsManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDStatisticsManager.h"

@interface HDStatisticsManager () {
    HDStatisticsConfiger *_configer;
    HDStatisticsView *_view;
}

@property (strong, nonatomic) HDStatisticsView *view;
@property (strong, nonatomic) HDStatisticsConfiger *configer;

@end

@implementation HDStatisticsManager

+ (instancetype)initWithCoordinateView:(HDStatisticsView *)view andConfig:(HDStatisticsConfiger *)configer {
    HDStatisticsManager *manager = [[HDStatisticsManager alloc] init];
    manager.view = view;
    manager.configer = configer;
    return manager;
}

@end
