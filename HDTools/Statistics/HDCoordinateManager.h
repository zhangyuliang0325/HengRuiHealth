//
//  HDCoordinateManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HDCoordinateManager : NSObject

- (void)transfromToForwardCoordinate:(NSArray *)points totalHeight:(CGFloat)totalHeight;
- (NSArray *)configCoordinateWithXPoints:(NSArray *)xPoints andYPoints:(NSArray *)yPoints;


@end
