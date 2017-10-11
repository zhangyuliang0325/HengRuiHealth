//
//  HDScrollChartView.m
//  HengruiHealthy
//
//  Created by ArvinHD on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDScrollChartView.h"

@interface HDScrollChartView () <UIScrollViewDelegate> {
    UIScrollView *_scroll; //用于缩放的滚动视图
}

@end

@implementation HDScrollChartView

//配置页面
- (void)configView {
    self.chartView = [[HDChartView alloc] init];
    self.chartView.frame = self.bounds;
    _scroll = [[UIScrollView alloc] init];
    _scroll.frame = self.bounds;
    _scroll.maximumZoomScale = 2;
    _scroll.minimumZoomScale = 1;
    _scroll.delegate = (id)self;
    [self addSubview:_scroll];
    [_scroll addSubview:self.chartView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.chartView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scale == 1) {
        scrollView.scrollEnabled = NO;
    } else {
        scrollView.scrollEnabled = YES;
    }
    if ([self.delegate respondsToSelector:@selector(viewDidScale:)]) {
        [self.delegate viewDidScale:scale != 1];
    }
}

@end
