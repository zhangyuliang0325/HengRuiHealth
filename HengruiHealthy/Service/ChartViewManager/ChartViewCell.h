//
//  ChartViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HDScrollChartView.h"

@interface ChartViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (weak, nonatomic) IBOutlet HDScrollChartView *chartView;
@property (assign, nonatomic) BOOL configed;
@property (strong, nonatomic) NSArray *xAxises;
@property (assign, nonatomic) float yAxisMax;
@property (assign, nonatomic) float yAxisMin;
@property (assign, nonatomic) int yLabelCount;
@property (assign, nonatomic) int xLabelCount;
@property (assign, nonatomic) HDChartData *chartData;
@property (copy, nonatomic) NSString *(^formatYAxis)(NSString *origin);
@property (assign, nonatomic) id<HDChartViewDelegate> chartDelegate;
@property (assign, nonatomic) id<HDScrollChartViewDelegate> scrollDelegate;

- (void)configCell;
- (void)updateCell;
- (void)setupChartData;

@end
