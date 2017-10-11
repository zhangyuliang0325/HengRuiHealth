//
//  HDCoordinateManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDCoordinateManager.h"

@implementation HDCoordinateManager

- (void)transfromToForwardCoordinate:(NSArray *)points totalHeight:(CGFloat)totalHeight{
    CGPoint point1 = [points[1] CGPointValue];
    CGPoint point0 = [points[0] CGPointValue];
    CGFloat offset = point1.y - point0.y;
    for (int i = 0; i < points.count; i ++) {
        CGPoint point = [points[i] CGPointValue];
        point.y = totalHeight - offset * i;
    }
}

- (NSArray *)configCoordinateWithXPoints:(NSArray *)xPoints andYPoints:(NSArray *)yPoints {
    NSInteger length = xPoints.count > yPoints.count ? yPoints.count : xPoints.count;
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < length; i ++) {
        [points addObject:[NSValue valueWithCGPoint:CGPointMake([xPoints[i] floatValue], [yPoints[i] floatValue])]];
    }
    return points;
}

@end
