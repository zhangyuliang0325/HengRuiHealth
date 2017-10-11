//
//  PNChartManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PNChartManager.h"

@interface PNChartManager () {
//    PNLineChart *self.lineChart;
}

@end

@implementation PNChartManager

- (instancetype)initWithLineChart:(PNLineChart *)lineChart {
    if (self = [super init]) {
        self.lineChart = lineChart;
    }
    return self;
}

- (void)configLineChart {
    self.lineChart.displayAnimated = NO;
//    self.lineChart.chartMarginTop = 20;
//    self.lineChart.chartMarginRight = 100;
    self.lineChart.chartCavanWidth = HRHtyScreenWidth - 46;
    self.lineChart.chartCavanHeight = 139;
    self.lineChart.chartMarginBottom = 34;
    self.lineChart.yLabels = self.yAxis;
//    self.lineChart.xLabels = [self xLabels];
    self.lineChart.showYGridLines = YES;
//    self.lineChart.showCoordinateAxis = YES;
    self.lineChart.xArisCount = self.xAxis.count;
    
    self.lineChart.xLabelWidth = (self.lineChart.bounds.size.width - self.lineChart.chartMarginLeft) / self.xAxis.count;
    self.lineChart.yLabelHeight = (self.lineChart.bounds.size.height - self.lineChart.chartMarginBottom - 10) / self.yLabelCount;
    for (int i = 0; i < self.lineChart.yChartLabels.count; i ++) {
        UILabel *label = self.lineChart.yChartLabels[i];
        NSLog(@"%@:%@", label.text, NSStringFromCGPoint(label.center));
        CGFloat bottom = self.lineChart.chartMarginBottom + 10;
        CGFloat height = label.bounds.size.height;
        CGFloat count = self.yLabelCount / self.lineChart.yChartLabels.count;
        CGFloat totalHeight = self.lineChart.bounds.size.height;
        CGFloat centerY = totalHeight - bottom - (totalHeight - bottom) / (self.yAxis.count - 1) * i;
        
        CGPoint center = CGPointMake(label.center.x, centerY + 10);
        label.bounds = CGRectMake(0, 0, 22, 17);
        label.center = center;
    }
    [self fixAxisPosition];
    
}

- (void)fixAxisPosition {
    for (UILabel *xLabel in self.lineChart.xChartLabels) {
//        xLabel.numberOfLines = 1;
//        [xLabel sizeToFit];
        NSInteger index = [self.lineChart.xChartLabels indexOfObject:xLabel];
        NSInteger points = self.lineChart.xChartLabels.count - 1;
        CGFloat width = (self.lineChart.bounds.size.width - 50) / points;
        CGFloat centerX = index * width + self.lineChart.chartMarginLeft;
        CGPoint center = CGPointMake(centerX, xLabel.center.y);
        xLabel.center = center;
    }
}

- (UIView *)getLegend {
    self.lineChart.legendStyle = PNLegendItemStyleSerial;
    self.lineChart.legendFont = [UIFont systemFontOfSize:13.0];
    UIView *legeng = [self.lineChart getLegendWithMaxWidth:HRHtyScreenWidth];
//    legeng.frame = CGRectMake(0, 0, HRHtyScreenWidth, 44);
    legeng.center = CGPointMake(HRHtyScreenWidth / 2, 22);
    
    return legeng;
}

#pragma mark - Method

- (NSArray *)xLabels {
    NSMutableArray *xLabelsArr = [NSMutableArray arrayWithCapacity:self.xLebelCount];
    NSInteger lenth = self.xAxis.count / self.xLebelCount;
    for (int i = 0; i < self.xLebelCount; i ++) {
        [xLabelsArr insertObject:self.xAxis[lenth * i] atIndex:i];
    }
    if (lenth != 1) {
        [xLabelsArr addObject:[self.xAxis lastObject]];
    }
    return xLabelsArr;
}

- (void)updataXaris {
    [self.lineChart.xChartLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lineChart.xChartLabels removeAllObjects];
    self.lineChart.xLabels = [self xLabels];
    self.lineChart.xLabelWidth = (self.lineChart.bounds.size.width - self.lineChart.chartMarginLeft) / self.xAxis.count;
    [self fixAxisPosition];
}

- (void)updataDatas {
    NSArray *chartDatas = [self configDatas];
    if (self.lineChart.chartData != nil && self.lineChart.chartData.count != 0) {
        
        [self.lineChart updateChartData:chartDatas];
    } else {
    
        self.lineChart.chartData = chartDatas;
        [self.lineChart strokeChart];
    }
    self.lineChart.legendStyle = PNLegendPositionBottom;
    self.lineChart.legendFont = [UIFont systemFontOfSize:15.0];
    UIView *legeng = [self.lineChart getLegendWithMaxWidth:HRHtyScreenWidth];
    legeng.frame = CGRectMake(0, 0, HRHtyScreenWidth, 44);
}

- (NSArray *)configDatas {
    NSMutableArray *chartDatas = [NSMutableArray arrayWithCapacity:self.lineCounts];
    for (int i = 0; i < self.lineCounts; i ++) {
        PNLineChartData *lineData = [[PNLineChartData alloc] init];
        lineData.xDatas = self.xDatas[i];
        NSArray *currentYDatas = self.yDatas[i];
        lineData.color = self.lineColors[i];
        lineData.inflexionPointColor = self.lineColors[i];
        lineData.inflexionPointStyle = PNLineChartPointStyleCircle;
        lineData.itemCount = currentYDatas.count;
        lineData.getData = ^PNLineChartDataItem *(NSUInteger item) {
            CGFloat yValue = [currentYDatas[item] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue - _baseValue];
        };
        lineData.dataTitle = self.dataTitles[i];
        [chartDatas insertObject:lineData atIndex:i];
    }
    
    return chartDatas;
}

@end
