//
//  PYEChartCollectionViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PYEChartCollectionViewCell.h"

#import <PNChart/PNChart.h>

#import "PNChartManager.h"

@interface PYEChartCollectionViewCell () {
    __weak IBOutlet PNLineChart *_lineChart;
    
}

@end

@implementation PYEChartCollectionViewCell

- (void)loadCell {
    if (self.fat != nil) {
        PNChartManager *manager = [[PNChartManager alloc] initWithLineChart:_lineChart];
        NSMutableArray *xDatas = [NSMutableArray array];
        NSMutableArray *yDatas = [NSMutableArray array];
        NSArray *xLabels = [self obtainXLabels];
        for (Fat *fat in self.fat) {
            NSString *time = [fat.measureTime substringToIndex:10];
            if ([xLabels containsObject:time]) {
                NSInteger index = [xLabels indexOfObject:time];
                [xDatas addObject:@(index)];
                [yDatas addObject:@(fat.fatcontent)];
            }
        }
        NSArray *yLabels = @[@"0%", @"10%", @"20%", @"30%", @"40%", @"50%", @"60%", @"70%", @"80%", @"90%", @"100%",];
        manager.xLebelCount = 4;
        manager.yAxis = yLabels;
        manager.xAxis = xLabels;
        manager.xDatas = @[xDatas];
        manager.yDatas = @[yDatas];
        manager.lineCounts = 1;
        manager.lineColors = @[[UIColor orangeColor]];
        [manager configLineChart];
    }
}

- (NSArray *)obtainXLabels {
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *components = [calendar components:flags fromDate:now];
//    NSInteger month = components.month - 1;
//    NSString *previous = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)components.year, (long)month, (long)components.day];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *previousDate = [formatter dateFromString:previous];
////    NSInteger dayInterval = [previousDate timeIntervalSinceNow] / 3600;
//    NSMutableArray *xLabels = [NSMutableArray array];
//    for (NSDate *d = previousDate; [d compare:now] != 1; d = [NSDate dateWithTimeInterval:3600 * 24 sinceDate:d]) {
//        NSString *dateString = [formatter stringFromDate:d];
//        [xLabels addObject:dateString];
//    }
//    return xLabels;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *start = [formatter dateFromString:@"2017-05-01"];
    NSDate *end = [formatter dateFromString:@"2017-05-31"];
    NSMutableArray *xLabels = [NSMutableArray array];
    for (NSDate *d = start; [d compare:end] != 1; d = [d dateByAddingTimeInterval:3600 * 24]) {
        NSString *date = [formatter stringFromDate:d];
        [xLabels addObject:date];
    }
    return xLabels;
}

@end
