//
//  EChartManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EChartManager.h"

#import <iOS-Echarts/iOS-Echarts.h>

@interface EChartManager () {
    PYEchartsView *_charts;
    PYOption *_option;
    PYAxis *_xAxis;
    PYAxis *_yAxis;
    PYSeries *_series;
}

@end

@implementation EChartManager

- (void)initWithFrame:(CGRect)frame {
    _charts = [[PYEchartsView alloc] initWithFrame:frame];
    _option = [[PYOption alloc] init];
    
    _xAxis = [[PYAxis alloc] init];
    _xAxis.type = PYAxisTypeValue;
    _xAxis.position = @"bottom";
    [_option setXAxis:[NSMutableArray arrayWithObject:_xAxis]];
    
    _yAxis = [[PYAxis alloc] init];
    _yAxis.type = PYAxisTypeValue;
    _yAxis.position = @"left";
    _yAxis.splitLine.lineStyle.type = PYLineStyleTypeDashed;
    _yAxis.splitLine.show = YES;
    [_option setYAxis:[NSMutableArray arrayWithObject:_yAxis]];
    
}

#pragma mark - Setter

- (void)setXAxisValues:(NSArray *)xAxisValues {
    _xAxisValues = xAxisValues;
    _xAxis.max = @(xAxisValues.count);
    _xAxis.min = @0;
}

- (void)setXPoints:(NSInteger)xPoints {
    _xPoints = xPoints;
    _xAxis.splitNumber = @(xPoints);
}

- (void)setYAxisValues:(NSArray *)yAxisValues {
    _yAxisValues = yAxisValues;
    _yAxis.max = @(yAxisValues.count);
    _yAxis.min = @0;
}

- (void)setYPoints:(NSInteger)yPoints {
    _yPoints = yPoints;
    _yAxis.splitNumber = @(yPoints);
}

- (void)setYFormatter:(NSString *)yFormatter {
    _yFormatter = yFormatter;
    _yAxis.axisLabel.formatter = [NSString stringWithFormat:@"{value}%@", yFormatter];
}


@end
