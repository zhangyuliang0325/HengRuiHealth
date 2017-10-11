//
//  SDCycleScrollViewManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SDCycleScrollViewManager.h"

@implementation SDCycleScrollViewManager

+ (void)configCycleViewOnView:(UIView *)view {
    SDCycleScrollView *cycle;
    if ([view isKindOfClass:[SDCycleScrollView class]]) {
        cycle = (SDCycleScrollView *)view;
        cycle.localizationImageNamesGroup = @[@"banner1", @"banner2", @"banner3"];
    } else {
        cycle = [SDCycleScrollView cycleScrollViewWithFrame:view.bounds imageNamesGroup:@[@"banner1", @"banner2", @"banner3"]];
        [view addSubview:cycle];
    }
    cycle.showPageControl = YES;
    cycle.contentMode = UIViewContentModeScaleToFill;
    cycle.pageDotColor = [UIColor whiteColor];
    cycle.currentPageDotColor = [UIColor orangeColor];
}

@end
