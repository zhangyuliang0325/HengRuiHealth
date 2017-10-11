//
//  HDAxis.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDAxis.h"

@interface HDAxis () {
    CGSize _viewSize;
}

@end

@implementation HDAxis

- (instancetype)initWithSize:(CGSize)viewSize {
    if (self == [super init]) {
        _viewSize = viewSize;
    }
    return self;
}

- (NSArray *)configDatas {
    
    switch (self.type) {
        case xAxis:
        {
            return [self getXAxisLabels];
        }
            break;
        case yAxis:
        {
            return [self getYAxisLabels];
        }
            break;
        default:
            break;
    }
    return nil;
}

- (NSArray *)getXAxisLabels {
    NSMutableArray *labels = [NSMutableArray array];
    int totalCount =  (int)self.values.count - 1;
    int remainder = totalCount % (self.count - 1);
    int offset = totalCount / self.count;
    float y = _viewSize.height - 20;
    float distance = (_viewSize.width - 25) / totalCount;
    for (int i = 0;  i < self.count; i ++) {
        int realOff = offset;
        if (i >= totalCount - remainder) {
            realOff = offset + 1;
        }
        int index = realOff * i;
        float x = index * distance + 4;
        UILabel *label = [self getLabel];
        label.frame = CGRectMake(x, y, 40, 14);
        label.text = self.values[index];
        [labels addObject:label];
    }
    return labels;
}

- (NSArray *)getYAxisLabels {
    NSMutableArray *labels = [NSMutableArray array];
    int valueOff = self.max - self.min;
    float offset = valueOff / self.count;
    float distance = (_viewSize.height - 40) / self.count;
    for (int i = self.count; i >= 0; i --) {
        float y = offset * i * distance + 20;
        UILabel *label = [self getLabel];
        label.frame = CGRectMake(0, y, 22, 20);
        label.text = [NSString stringWithFormat:@"%f", valueOff + self.min];
        [labels addObject:label];
    }
    return labels;
}

- (UILabel *)getLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.numberOfLines = 0;
    return label;
}

@end
