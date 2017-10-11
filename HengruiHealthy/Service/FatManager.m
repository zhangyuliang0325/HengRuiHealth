//
//  FatManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "FatManager.h"

@interface FatManager () {
    NSCalendar *_currentCalendar;
    NSCalendarUnit _flags;
    
}

@end

@implementation FatManager

- (instancetype)init {
    if (self = [super init]) {
        _currentCalendar = [NSCalendar currentCalendar];
        _flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitDay;
    }
    return self;
}

- (NSDate *)calculateTime:(NSDate *)date {
    NSDateComponents *component = [_currentCalendar components:_flags fromDate:date];
    NSDate *anotherDate = nil;
    switch (self.chartType) {
        case FatChartDay:
            return date;
            break;
        case FatChartWeek:
        {
            NSInteger week = self.timeType == FatTimeStart ? component.day + 6 : component.day - 6;
            [component setDay:week];
            anotherDate = [_currentCalendar dateFromComponents:component];
        }
            break;
        case FatChartMonth:
        {
            NSInteger month = self.timeType == FatTimeStart ? component.day + 30 : component.day - 30;
            [component setDay:month];
            anotherDate = [_currentCalendar dateFromComponents:component];
        }
            break;
        default:
            break;
    }
    return anotherDate;
}

- (NSArray *)calculateXArisWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSMutableArray *xAris = [NSMutableArray array];
    switch (self.chartType) {
        case FatChartDay:
        {
            return @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15",@"16",@"17", @"18", @"19", @"20", @"21", @"22",@"23"];
        }
            break;
        case FatChartWeek:
        case FatChartMonth:
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM月dd日"];
            for (NSDate *d = startDate; [d compare:endDate] != 1; d = [d dateByAddingTimeInterval:86400]) {
                NSString *dateString = [formatter stringFromDate:d];
                [xAris addObject:dateString];
            }
        }
            break;
        default:
            break;
    }
    return xAris;
}
    
- (NSArray *)obtainYArixs {
    return @[@"0", @"10%", @"20%", @"30%", @"40%", @"50%", @"60%", @"70%", @"80%", @"90%", @"100%",];
}

- (NSArray *)configXDatas:(NSArray *)datas WithXAris:(NSArray *)xAris {
    NSMutableArray *xDatas = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.chartType == FatChartDay) {
        [formatter setDateFormat:@"hh"];
    } else {
        
        [formatter setDateFormat:@"MM月dd日"];
    }
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    for (NSString *obj in datas) {
        NSDate *date = [formatter1 dateFromString:[obj substringToIndex:10]];
        NSString *ds = [formatter stringFromDate:date];
        if ([xAris containsObject:ds]) {
            NSInteger index = [xAris indexOfObject:ds];
            [xDatas addObject:@(index)];
        }
    }
    return xDatas;
}

//- (NSArray *)configYDatas:(NSArray *)datas WithYAris:(NSArray *)yAris {
//    
//}

@end
