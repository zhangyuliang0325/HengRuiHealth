//
//  PNChartManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <PNChart/PNChart.h>

@interface PNChartManager : NSObject

@property (strong, nonatomic) NSArray *xAxis;
@property (strong, nonatomic) NSArray *yAxis;

@property (assign, nonatomic) NSInteger xLebelCount;
@property (assign, nonatomic) CGFloat yLabelCount;

@property (assign, nonatomic) CGFloat baseValue;

//下列数组长度等于 line Counts
@property (assign, nonatomic) NSInteger lineCounts;
@property (strong, nonatomic) NSArray<NSArray *> *xDatas;
@property (strong, nonatomic) NSArray<NSArray *> *yDatas;
@property (strong, nonatomic) NSArray<UIColor *> *lineColors;
@property (strong, nonatomic) NSArray<NSString *> *dataTitles;

@property (strong, nonatomic) PNLineChart *lineChart;

- (instancetype)initWithLineChart:(PNLineChart *)lineChart;
- (void)configLineChart;
- (void)updataXaris;
- (void)updataDatas;
- (UIView*) getLegend;

@end
