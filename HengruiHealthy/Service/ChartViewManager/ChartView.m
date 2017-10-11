//
//  ChartView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ChartView.h"

#import "ChartViewCell.h"

@interface ChartView () <UIScrollViewDelegate, UICollectionViewDataSource, HDScrollChartViewDelegate, HDChartViewDelegate> {
    
    __weak IBOutlet UICollectionViewFlowLayout *_layoutChart;
    __weak IBOutlet UICollectionView *_cvChart;
    
    NSInteger _timeInterval;
    NSInteger _position;
    NSInteger _labelCount;
    NSInteger _totalCount;
    
}

@end

NSString *const kDataX = @"key_data_x";
NSString *const kDataY = @"key_data_y";
NSString *const KDataC = @"key_data_color";
NSString *const kDataL = @"key_data_line_count";
NSString *const kDataT = @"key_data_title";
NSString *const kDataA = @"key_data_coorditions";

static NSString *chartViewCellIdentifier = @"ChartViewCellIdentifier";

@implementation ChartView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.endDate = [NSDate date];
    self.dateTo = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.startDate = [formatter dateFromString:@"1970-01-01"];
}

- (void)configView {
    _layoutChart.itemSize = CGSizeMake(_cvChart.bounds.size.width, _cvChart.bounds.size.height);
    _layoutChart.minimumLineSpacing = 0 ;
    _layoutChart.minimumInteritemSpacing = 0;
    _cvChart.dataSource = (id)self;
    _cvChart.delegate = (id)self;
    [_cvChart registerNib:[UINib nibWithNibName:@"ChartViewCell" bundle:nil] forCellWithReuseIdentifier:chartViewCellIdentifier];
    self.dateFrom = [self calculateAnotherDate:self.dateTo interval:-1];
    [self updateView];
}

- (void)updateView {
    
    
    _position = [self calculateTimeOffsetFrom:self.startDate to:self.dateTo];
//    _totalCount = _timeInterval - 1;
    NSInteger intervalToEnd = [self calculateTimeOffsetFrom:self.dateTo to:self.endDate];
    if (intervalToEnd != 0) {
        NSDate *end = [self calculateDate:self.dateTo flag:self.flag interval:intervalToEnd];
        if ([end compare:self.endDate] == -1) {
            self.endDate = [self calculateDate:end flag:self.flag interval:1];
        } else {
            self.endDate = end;
        }
    }
    [self calculateCellCount];
    [_cvChart reloadData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_cvChart scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_position inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
//    });
}

- (NSInteger)calculateTimeOffsetFrom:(NSDate *)from to:(NSDate *)to {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:self.flag fromDate:from toDate:to options:0];
    NSInteger interval = 0;
    switch (self.flag) {
        case NSCalendarUnitDay:
            interval = components.day;
            break;
        case NSCalendarUnitWeekOfMonth:
            interval = components.weekOfMonth;
            break;
        case NSCalendarUnitMonth:
            interval = components.month;
            break;
        default:
            break;
    }
    return interval;
}

- (void)calculateCellCount {
    _totalCount = [self calculateTimeOffsetFrom:self.startDate to:self.endDate];
    _timeInterval = _totalCount + 1;
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0) {
        
    } else if (scrollView.contentOffset.x > (_timeInterval - 1) * HRHtyScreenWidth) {
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (targetContentOffset->x != _position * HRHtyScreenWidth) {
        _cvChart.scrollEnabled = NO;
        _position = (NSInteger)targetContentOffset->x / HRHtyScreenWidth;
        if ([self.delegate respondsToSelector:@selector(dateDidChangeFrom:to:)]) {
            NSMutableDictionary *xDates = [self calculateTimeWithOffset:_position - _totalCount];
            NSArray *dates = xDates[@"dates"];
            [self.delegate dateDidChangeFrom:[dates firstObject] to:[dates lastObject]];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _cvChart.scrollEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _timeInterval;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChartViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:chartViewCellIdentifier forIndexPath:indexPath];
    NSMutableDictionary *xDates = [self calculateTimeWithOffset:indexPath.row - _totalCount];
    NSArray *xAxises = xDates[@"xAxises"];
    NSArray *dates = xDates[@"dates"];
    cell.xAxises = xAxises;
    cell.xLabelCount = (int)_labelCount;
    [cell.indicator startAnimating];
    if (cell.configed) {
        [cell updateCell];
    } else {
        cell.chartDelegate = (id)self;
        cell.scrollDelegate = (id)self;
        cell.yAxisMax = self.yAxisMax;
        cell.yAxisMin = self.yAxisMin;
        cell.yLabelCount = self.yLabelCount;
        cell.formatYAxis = self.formatYAxis;
        [cell configCell];
    }
    if ([self.delegate respondsToSelector:@selector(obtainDatasRangeDateFrom:to:forCell:hanler:)]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *fromString = [[[formatter stringFromDate:[dates firstObject]] substringToIndex:10] stringByAppendingString:@" 00:00:00"];
        NSString *toString = [[[formatter stringFromDate:[dates lastObject]] substringToIndex:10] stringByAppendingString:@" 23:59:59"];
        [self.delegate obtainDatasRangeDateFrom:fromString to:toString forCell:cell hanler:^(id datas, UICollectionViewCell *chartCell) {
            ChartViewCell *theCell = (ChartViewCell *)chartCell;
            [theCell.indicator stopAnimating];
            HDChartData *chartData = [theCell.chartView.chartView obtainCharData];
            if (chartData == nil) {
                chartData = [[HDChartData alloc] init];
            }
            
            if ([datas isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = (NSArray *)datas;
                NSMutableArray *colors = [NSMutableArray array];
                NSMutableArray *titles = [NSMutableArray array];
                NSMutableArray *coorditions = [NSMutableArray array];
                [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dataMap = (NSDictionary *)obj;
                    [colors addObject:dataMap[KDataC]];
                    [titles addObject:dataMap[kDataT]];
                    [coorditions addObject: [self configDatasWithCoorditions:dataMap[kDataA]]];
                }];
                chartData.colors = colors;
                chartData.titles = titles;
                chartData.datas = coorditions;
                chartData.lineCount = (int)coorditions.count;
            } else {
                NSDictionary *dataMap = (NSDictionary *)datas;
                chartData.lineCount = 1;
                chartData.colors = dataMap[KDataC];
                chartData.titles = dataMap[kDataT];
                chartData.datas = [self configDatasWithCoorditions:dataMap[kDataA]];
            }
            [theCell.chartView.chartView updateDatas:chartData];
            if (self.legends == nil && chartData.lineCount > 1) {
                self.legends = [theCell.chartView.chartView getLegends];
            }
        }];
    }

    return cell;
}

#pragma mark - Scroll chart view delegate

- (void)viewDidScale:(BOOL)scaled {
    if (scaled) {
        _cvChart.scrollEnabled = NO;
    } else {
        _cvChart.scrollEnabled = YES;
    }
}

#pragma mark - Chart view delegate

- (NSString *)touchSymbol:(NSArray *)symbolInfo {
    NSMutableString *mStr = [NSMutableString string];
    [symbolInfo enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *time = obj[kHDChartX];
        float value = [obj[kHDChartY] floatValue];
        if (self.formatSymbolInfo) {
            NSString *info = self.formatSymbolInfo(time, value);
            [mStr appendString:info];
        }
    }];
    [mStr deleteCharactersInRange:NSMakeRange(mStr.length - 1, 1)];
    return mStr;
}

#pragma mark - setter 

- (void)setFlag:(NSCalendarUnit)flag {
    _flag = flag;
    switch (flag) {
        case NSCalendarUnitDay:
            _labelCount = 6;
            break;
        case NSCalendarUnitWeekOfMonth:
            _labelCount = 7;
            break;
        case NSCalendarUnitMonth:
            _labelCount = 4;
            break;
        default:
            break;
    }
}

- (void)setLegends:(NSArray *)legends {
    _legends = legends;
    __block float legendsWidth = 0;
    [legends enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        legendsWidth += obj.bounds.size.width + 8;
    }];
    if (legendsWidth > self.legendView.bounds.size.width) {
        __block float x = 8;
        __block float y = 0;
        [legends enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            y = idx * obj.bounds.size.height;
            obj.frame = CGRectMake(x, y, obj.bounds.size.width, obj.bounds.size.height);
        }];
    } else if (legends.count == 2) {
        float centerY = self.legendView.bounds.size.height / 2;
        float width = self.legendView.bounds.size.width;
        UIView *legend1 = legends[0];
        legend1.center = CGPointMake(8 + legend1.bounds.size.width / 2, centerY);
        [self.legendView addSubview:legend1];
        UIView *legend2 = legends[1];
        float x = width - legend2.bounds.size.width / 2 - 8;
        legend2.center = CGPointMake(x, centerY);
        [self.legendView addSubview:legend2];
    } else {
        __block float x = 8;
        __block float centerY = self.legendView.bounds.size.height / 2;
        [legends enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            x += obj.bounds.size.width * idx + 8;
            obj.center = CGPointMake(x, centerY);
            [self.legendView addSubview:obj];
        }];
    }
}

#pragma mark - Method 

- (NSMutableDictionary *)calculateTimeWithOffset:(NSInteger)offset {
    NSDate *to = [self calculateDate:self.endDate flag:self.flag interval:offset];
    NSDate *from = [self calculateAnotherDate:to interval:-1];
    return [self createXAxisesFrom:from to:to];
}

- (NSDate *)calculateAnotherDate:(NSDate *)date interval:(NSInteger)intervarl {
    NSDate *anotherDate = [self calculateDate:date flag:self.flag interval:intervarl];
    return [self calculateDate:anotherDate flag:NSCalendarUnitDay interval:-intervarl];
}

- (NSDate *)calculateDate:(NSDate *)date flag:(NSCalendarUnit)flag interval:(NSInteger)interval {
    return [[NSCalendar currentCalendar] dateByAddingUnit:flag value:interval toDate:date options:NSCalendarSearchBackwards];
}

- (NSMutableDictionary *)createXAxisesFrom:(NSDate *)from to:(NSDate *)to {
    NSMutableArray *xAxises = [NSMutableArray array];
    NSMutableArray *dates = [NSMutableArray array];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    NSTimeInterval timeInterval = 0;
    switch (self.flag) {
        case NSCalendarUnitDay:
        {
            timeInterval = 60;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            from = [calendar dateBySettingHour:00 minute:00 second:00 ofDate:from options:NSCalendarWrapComponents];
            to = [calendar dateBySettingHour:23 minute:59 second:59 ofDate:to options:NSCalendarWrapComponents];
            [formater setDateFormat:@"HH:ss"];
        }
            break;
        case NSCalendarUnitWeekOfMonth:
        case NSCalendarUnitMonth:
        {
            timeInterval = 86400;
            [formater setDateFormat:@"MM月dd日"];
        }
            break;
        default:
            break;
    }
    
    while ([from compare:to] != 1) {
        [dates addObject:from];
        [xAxises addObject:[formater stringFromDate:from]];
        from = [from dateByAddingTimeInterval:timeInterval];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"xAxises"] = xAxises;
    dic[@"dates"] = dates;
    return dic;
}

- (NSArray *)configDatasWithCoorditions:(NSArray *)coorditions {
    NSMutableArray *formatCoorditions = [NSMutableArray array];
    [coorditions enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *x = obj[kDataX];
        float y = [obj[kDataY] floatValue];
        HDChartLineCoordition *coordition = [[HDChartLineCoordition alloc] initWithX:x y:y];
        [formatCoorditions addObject:coordition];
    }];
    return formatCoorditions;
}

@end
