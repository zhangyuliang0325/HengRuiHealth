//
//  ChartViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ChartViewCell.h"



@interface ChartViewCell () {
    
}

@end

@implementation ChartViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.configed = NO;
}

- (void)configCell {
    self.chartView.frame = CGRectMake(0, 0, HRHtyScreenWidth, self.bounds.size.height);
    [self.chartView configView];
    self.chartView.delegate = self.scrollDelegate;
    self.chartView.chartView.xAxisValues = self.xAxises;
    self.chartView.chartView.xLabelCount = self.xLabelCount;
    self.chartView.chartView.yAxisMax = self.yAxisMax;
    self.chartView.chartView.yAxisMin = self.yAxisMin;
    self.chartView.chartView.yLabelCount = self.yLabelCount;
    self.chartView.chartView.formatYAxis = self.formatYAxis;
    [self.chartView.chartView initChartBG];
    self.chartView.chartView.delegate = self.chartDelegate;
    self.configed = YES;
}

- (void)updateCell {
    [self.chartView.chartView updateXLabels:self.xAxises count:self.xLabelCount];
}

- (void)setupChartData {
    [self.chartView.chartView updateDatas:self.chartData];
}

@end
