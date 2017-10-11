//
//  HDChartData.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDChartLineCoordition;

@interface HDChartData : NSObject

FOUNDATION_EXTERN NSString const *kHDChartLineColor;
FOUNDATION_EXTERN NSString const *kHDChartLineTitle;
FOUNDATION_EXTERN NSString const *kHDChartLineCoorditions;

//@property (strong, nonatomic) NSArray<UIColor *> *colors;
//@property (strong, nonatomic) NSArray<NSString *> *titles;
//@property (strong, nonatomic) NSArray<NSArray<HDChartLineCoordition *> *> *datas;

@property (strong, nonatomic) id colors;
@property (strong, nonatomic) id titles;
@property (strong, nonatomic) id datas;

@property (assign, nonatomic) int lineCount;


- (NSArray *)obtainLineDatas;

@end

@interface HDChartLineCoordition : NSObject

@property (strong, nonatomic) id x;
@property (assign, nonatomic) float y;

- (instancetype)initWithX:(id)x y:(float)y;

@end
