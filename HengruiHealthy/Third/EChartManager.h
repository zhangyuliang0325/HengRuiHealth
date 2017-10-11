//
//  EChartManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EChartManager : NSObject

@property (strong, nonatomic) NSArray *xAxisValues;
@property (strong, nonatomic) NSArray *yAxisValues;
@property (strong, nonatomic) NSArray *xDataValues;
@property (strong, nonatomic) NSArray *yDataValues;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *colors;
@property (assign, nonatomic) NSInteger xPoints;
@property (assign, nonatomic) NSInteger yPoints;
@property (copy, nonatomic) NSString *yFormatter;

- (void)initWithFrame:(CGRect)frame;

@end
