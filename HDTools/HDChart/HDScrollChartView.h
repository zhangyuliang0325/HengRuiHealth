//
//  HDScrollChartView.h
//  HengruiHealthy
//
//  Created by ArvinHD on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HDChartView.h"

@protocol HDScrollChartViewDelegate <NSObject>

- (void)viewDidScale:(BOOL)scaled;

@end

@interface HDScrollChartView : UIView

@property (strong, nonatomic) HDChartView *chartView;
@property (assign, nonatomic) float maxScaleZoom;

@property (assign, nonatomic) id<HDScrollChartViewDelegate> delegate;


- (void)configView;

@end
