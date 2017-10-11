//
//  HDChartData.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDChartData.h"

NSString const *kHDChartLineColor = @"color";
NSString const *kHDChartLineTitle = @"title";
NSString const *kHDChartLineCoorditions= @"coorditions";

@implementation HDChartData

- (instancetype)init {
    if (self = [super init]) {
        self.colors = [UIColor orangeColor];
        self.titles = @"";
        self.lineCount = 1;
        self.datas = [NSArray array];
    }
    return self;
}

- (id)obtainLineDatas {
    if (self.lineCount > 1) {
        NSMutableArray *datas = [NSMutableArray array];
        for (int i = 0; i < self.lineCount; i ++) {
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            UIColor *color = self.colors[i];
            NSString *title = self.titles[i];
            NSArray *coorditions = self.datas[i];
            data[kHDChartLineColor] = color;
            data[kHDChartLineTitle] = title;
            data[kHDChartLineCoorditions] = coorditions;
            [datas addObject:data];
        }
        return datas;
    } else {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        data[kHDChartLineColor] = self.colors;
        data[kHDChartLineTitle] = self.titles;
        data[kHDChartLineCoorditions] = self.datas;
        return data;
    }
}

@end

@implementation HDChartLineCoordition

- (instancetype)initWithX:(id)x y:(float)y {
    if (self = [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

@end
