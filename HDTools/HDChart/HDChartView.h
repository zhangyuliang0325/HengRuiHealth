//
//  HDChartView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NSString *(^ObtianFinalSymbolInfo)(NSString *symbolInfo);

@protocol HDChartViewDelegate <NSObject>

- (NSString *)touchSymbol:(NSArray *)symbolInfo;

@end

#import "HDChartData.h"

@interface HDChartView : UIView

FOUNDATION_EXPORT NSString *const kHDChartX;
FOUNDATION_EXPORT NSString *const kHDChartY;

@property (strong, nonatomic) NSArray *xAxisValues;
@property (assign, nonatomic) int xLabelCount;
@property (assign, nonatomic) float yAxisMax;
@property (assign, nonatomic) float yAxisMin;
@property (assign, nonatomic) int yLabelCount;
@property (assign, nonatomic) id<HDChartViewDelegate> delegate;

@property (copy, nonatomic) NSString *(^formatYAxis)(NSString *origin);

- (void)initChartBG;
- (void)setDatas:(HDChartData *)chartData;
- (void)strokePath;
- (void)updateDatas:(HDChartData *)datas;
- (void)updateXLabels:(NSArray *)xValues count:(int)count;
- (HDChartData *)obtainCharData;
- (NSArray *)getLegends;

@end
