//
//  HRPNLineChart.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#define HRPNVWWidth self.bounds.size.width

#import "HRPNLineChart.h"

#import "PNChartManager.h"

@interface HRPNLineChart () <UIScrollViewDelegate, PNChartDelegate> {
    PNChartManager *_currentManager;
    PNLineChart *_currentChart;
    PNLineChart *_provinceChart;
    PNLineChart *_lastChart;
    
    NSMutableArray *_charts;
    
    UIScrollView *_scroll;
    UIActivityIndicatorView *_currentIndicator;
    NSInteger _currentIndex;
}

@end

@implementation HRPNLineChart

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeUI];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initializeUI];
    }
    return self;
}

#pragma mark - UI

- (void)initializeUI {
    self.bounds = CGRectMake(0, 0, HRHtyScreenWidth - 16, 182.5);
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.contentSize = CGSizeMake(HRPNVWWidth * 5, self.bounds.size.height);
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.delegate = (id)self;
    _scroll.pagingEnabled = YES;
    [self addSubview:_scroll];
}

- (void)configManager {
    _charts = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        PNLineChart *lineChartView = [[PNLineChart alloc] init];
        lineChartView.frame = CGRectMake(HRPNVWWidth * i, 0, HRPNVWWidth, self.bounds.size.height);
        [_scroll addSubview:lineChartView];
        PNChartManager *manager = [[PNChartManager alloc] initWithLineChart:lineChartView];
        manager.yAxis = self.yAris;
        manager.yLabelCount = self.yLabelCount;
        manager.lineCounts = self.lineCount;
        manager.lineColors = self.lineColors;
        manager.dataTitles = self.dataTitles;
        manager.baseValue = self.baseValue;
        [manager configLineChart];
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        indicator.color = [UIColor orangeColor];
//        indicator.hidesWhenStopped = YES;
//        indicator.center = CGPointMake(HRPNVWWidth / 2, self.bounds.size.height / 2);
//        indicator.bounds = CGRectMake(0, 0, 67, 67);
//        [lineChartView addSubview:indicator];
//        [indicator startAnimating];
        if (i == 2) {
            _currentChart = lineChartView;
            _currentManager = manager;
            _currentChart.delegate =self;
//            _currentIndicator = indicator;
        } else {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicator.color = [UIColor orangeColor];
            indicator.hidesWhenStopped = YES;
            indicator.center = CGPointMake(HRPNVWWidth / 2, self.bounds.size.height / 2);
            indicator.bounds = CGRectMake(0, 0, 67, 67);
            [lineChartView addSubview:indicator];
            [indicator startAnimating];
        }
        
        [_charts addObject:manager];
    }
}

- (void)updataXAris:(NSArray *)xAris count:(CGFloat)count {
    self.xAris = xAris;
    self.xLabelCount = count;
    for (PNChartManager *manager in _charts) {
        manager.xAxis = xAris;
        manager.xLebelCount = count;
        [manager updataXaris];
    }
}

- (void)updataXDatas:(NSArray *)xDatas yDatas:(NSArray *)yDatas {
    
    _scroll.userInteractionEnabled = YES;
//    [_currentIndicator stopAnimating];
    PNChartManager *manager = _charts[2];
    manager.xDatas = xDatas;
    manager.yDatas = yDatas;
    if (xDatas.count != 0 && xDatas != nil) {
        
        [manager updataDatas];
    }
    _scroll.contentOffset = CGPointMake(HRPNVWWidth * 2, 0);
}

#pragma mark - Scroll view delegate

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    scrollView.userInteractionEnabled = NO;
//    if (targetContentOffset->x != HRPNVWWidth * 2) {
//        [self updataXDatas:@[@[]] yDatas:@[@[]]];
////        [_currentIndicator startAnimating];
//    }
//}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    scrollView.contentOffset = CGPointMake(HRPNVWWidth, 0);
//    scrollView.userInteractionEnabled = YES;
    
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == HRPNVWWidth) {
        _currentIndex = -1;
        scrollView.contentOffset = CGPointMake(HRPNVWWidth, 0);
        [self updataDatas];
    } else if (scrollView.contentOffset.x == HRPNVWWidth * 3 || scrollView.contentOffset.x == HRPNVWWidth * 4) {
        _currentIndex = 1;
        scrollView.contentOffset = CGPointMake(HRPNVWWidth * 3, 0);
        [self updataDatas];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSMutableArray *xDatas = [NSMutableArray arrayWithCapacity:self.lineCount];
    NSMutableArray *yDatas = [NSMutableArray arrayWithCapacity:self.lineCount];
    for (int i = 0; i < self.lineCount; i ++) {
        [xDatas insertObject:@[] atIndex:i];
        [yDatas insertObject:@[] atIndex:i];
    }
    _currentManager.xDatas = xDatas;
    _currentManager.yDatas = yDatas;
    [_currentManager updataDatas];
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)updataDatas {
    if ([self.delegate respondsToSelector:@selector(obtainDatasWithOffset:)]) {
        [self.delegate obtainDatasWithOffset:_currentIndex];
    }
}

- (void)setLegendOnView:(UIView *)vw {
    [vw addSubview:[_currentManager getLegend]];
}

#pragma mark - PNChart delegate

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex {
    NSLog(@"%d", lineIndex);
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex {
    NSInteger x = [_currentManager.xDatas[0][pointIndex] integerValue];
    NSString *xa = self.xAris[x];
    NSString *y = _currentManager.yDatas[0][pointIndex];
    NSLog(@"%d, %d", lineIndex, pointIndex);
}

@end
