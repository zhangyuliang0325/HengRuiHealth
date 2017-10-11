//
//  HDBezierLine.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDBezierLine.h"

@implementation HDBezierLine

- (void)drawLineWithPoints:(NSArray *)points inShapLayer:(CAShapeLayer *)layer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        CGPoint start = [points[0] CGPointValue];
        [bezier moveToPoint:start];
        for (int i = 1; i < points.count - 2; i ++) {
            [bezier addLineToPoint:[points[i] CGPointValue]];
        }
        layer.path = bezier.CGPath;
    });
}

@end
