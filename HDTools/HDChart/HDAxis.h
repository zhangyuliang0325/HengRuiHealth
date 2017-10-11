//
//  HDAxis.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AxisType) {
    xAxis,
    yAxis
};

@interface HDAxis : NSObject

@property (strong, nonatomic) NSArray *values;
@property (assign, nonatomic) float max;
@property (assign, nonatomic) float min;
@property (assign, nonatomic) int count;
@property (copy, nonatomic) NSString *(^formatValue)(int position);
@property (assign, nonatomic) AxisType type;

- (instancetype)initWithSize:(CGSize)viewSize;
- (NSArray *)configDatas;

@end
