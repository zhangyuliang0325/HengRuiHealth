//
//  ChartView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDChartViewDelegate;

@protocol ChartViewDelegate <NSObject>

- (void)obtainDatasRangeDateFrom:(NSString *)from to:(NSString *)to forCell:(UICollectionViewCell *)cell hanler:(void(^)(id datas, UICollectionViewCell *chartCell))handler;
- (void)dateDidChangeFrom:(NSDate *)from to:(NSDate *)to;

@end

@interface ChartView : UIView

FOUNDATION_EXTERN NSString *const kDataX;
FOUNDATION_EXTERN NSString *const kDataY;
FOUNDATION_EXTERN NSString *const KDataC;
FOUNDATION_EXTERN NSString *const kDataL;
FOUNDATION_EXTERN NSString *const kDataT;
FOUNDATION_EXTERN NSString *const kDataA;

@property (strong, nonatomic) NSMutableArray *xAxises;
@property (assign, nonatomic) float yAxisMax;
@property (assign, nonatomic) float yAxisMin;
@property (assign, nonatomic) int yLabelCount;
@property (copy, nonatomic) NSString *(^formatYAxis)(NSString *origin);

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@property (strong, nonatomic) NSDate *dateFrom;
@property (strong, nonatomic) NSDate *dateTo;

@property (assign, nonatomic) NSCalendarUnit flag;

@property (copy, nonatomic) NSString *(^formatSymbolInfo)(NSString *time, float value);

@property (strong, nonatomic) NSArray *legends;
@property (strong, nonatomic) UIView *legendView;

@property (assign, nonatomic) id<ChartViewDelegate> delegate;
@property (assign, nonatomic) id<HDChartViewDelegate> chartDelegate;

- (void)setChartDatas:(NSArray *)chartDatas;
- (void)configView;
- (void)setupXAxisesFrom:(NSDate *)from to:(NSDate *)to;
- (void)updateView;

@end
