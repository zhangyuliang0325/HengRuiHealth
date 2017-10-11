//
//  HRPNLineChart.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HRPNChartDelegate <NSObject>

- (void)obtainDatasWithOffset:(NSInteger)offset;

@end

@interface HRPNLineChart : UIView

@property (strong, nonatomic) NSArray *yAris;
@property (strong, nonatomic) NSArray *xAris;
@property (assign, nonatomic) CGFloat xLabelCount;
@property (assign, nonatomic) CGFloat yLabelCount;
@property (assign, nonatomic) NSInteger lineCount;
@property (strong, nonatomic) NSArray *lineColors;
@property (strong, nonatomic) NSArray *dataTitles;
@property (assign, nonatomic) CGFloat baseValue;

@property (assign, nonatomic) id<HRPNChartDelegate> delegate;

- (void)updataXAris:(NSArray *)xAris count:(CGFloat)count;
- (void)updataXDatas:(NSArray *)xDatas yDatas:(NSArray *)yDatas;
- (void)configManager;
- (void)setLegendOnView:(UIView *)vw;

@end
