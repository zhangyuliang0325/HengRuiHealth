//
//  HDBezierLine.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HDBezierLine : NSObject

- (void)drawLineWithPoints:(NSArray *)points inShapLayer:(CAShapeLayer *)layer;

@end
