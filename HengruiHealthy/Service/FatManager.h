//
//  FatManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FatTimeType) {
    FatTimeStart,
    FatTimeEnd
};

typedef NS_ENUM(NSInteger, FatChartType) {
    FatChartDay,
    FatChartWeek,
    FatChartMonth
};

@interface FatManager : NSObject

@property (assign, nonatomic) FatTimeType timeType;
@property (assign, nonatomic) FatChartType chartType;

- (NSDate *)calculateTime:(NSDate *)date;
- (NSArray *)calculateXArisWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (NSArray *)obtainYArixs;
- (NSArray *)configXDatas:(NSArray *)data WithXAris:(NSArray *)xAris;
//- (NSArray *)configYDatas:(NSArray *)datas WithYAris:(NSArray *)yAris;


@end
