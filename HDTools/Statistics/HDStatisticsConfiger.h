//
//  HDStatisticsConfiger.h
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, orientations) {
    top,
    down
};

@interface HDStatisticsConfiger : NSObject

@property (assign, nonatomic) NSInteger xSegment;
@property (assign, nonatomic) NSInteger ySegment;
@property (assign, nonatomic) orientations orientations;
@property (strong, nonatomic) UIColor * lineColor;

@property (strong, nonatomic) UIImage *xLine;
@property (strong, nonatomic) UIImage *yLine;


@end
