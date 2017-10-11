//
//  WeightTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "WeightTableViewController.h"

#import "DatePickerView.h"
#import "DateTypeView.h"
#import "ChartView.h"
#import "ArchivesRightItem.h"

#import "Weight.h"

#import "HomeClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>
typedef void(^UpdateStartDate)(NSDate *dateStart);
typedef void(^ObtainWeightFromServer)(NSArray *weights, UICollectionViewCell *cell);

@interface WeightTableViewController () <ChartViewDelegate, DateTypeViewDelegate, DatePickerViewDelegate> {
    __weak IBOutlet UILabel *_lblLast;
    __weak IBOutlet UILabel *_lblLow;
    __weak IBOutlet UILabel *_lblHeight;
    __weak IBOutlet ChartView *_vwChart;
    __weak IBOutlet DateTypeView *_vwDateType;
    __weak IBOutlet DatePickerView *_vwDatePicker;
    
    UpdateStartDate _updateStart;
    UpdateStartDate _updateMin;
    ObtainWeightFromServer _obtainWeights;

}

@end

static NSInteger totalProgress = 0;

@implementation WeightTableViewController

- (void)dealloc {
    self.navigationItem.rightBarButtonItems = nil;
    NSLog(@"weight dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightItem];
    [self configChart];
    [self configDateType];
    [self configDatePicker];
    [self loadingProgress:0];
    [self obtainHigh];
    [self obtainLow];
    [self obtainLast];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadingProgress:(NSInteger)progress {
    totalProgress += progress;
    if (totalProgress == 0) {
        [MBPrograssManager showPrograssOnMainView];
    } else if (totalProgress == 3) {
        [MBPrograssManager hidePrograssFromMainView];
    }
}

#pragma mark - Http server

- (void)obtainWeightFromDate:(NSString *)startDate toDate:(NSString *)endDate forCell:(UICollectionViewCell *)cell {
//    [MBPrograssManager showPrograssOnMainView];
    [[HomeClient shareInstance] obtainChartFile:WEIGHTFILE fromDate:startDate toDate:endDate sort:ASC handler:^(id response, BOOL isSuccess) {
//        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            
            NSArray *weights = [Weight mj_objectArrayWithKeyValuesArray:response];
            _obtainWeights(weights, cell);
        }
    }];
}

- (void)obtainHigh {
    [[HomeClient shareInstance] obtainChartInfoForFile:WEIGHTFILE item:WEIGHT sort:DESC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            Weight *height = [Weight mj_objectWithKeyValues:response];
            _lblHeight.text = [NSString stringWithFormat:@"%.2fkg", height.weight];
        }
    }];
}

- (void)obtainLow {
    [[HomeClient shareInstance] obtainChartInfoForFile:WEIGHTFILE item:WEIGHT sort:ASC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            Weight *low = [Weight mj_objectWithKeyValues:response];
            _lblLow.text = [NSString stringWithFormat:@"%.2fkg", low.weight];
        }
    }];
}

- (void)obtainLast {
    [[HomeClient shareInstance] obtainChartInfoForFile:WEIGHTFILE item:MEASURETIME sort:DESC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            Weight *last = [Weight mj_objectWithKeyValues:response];
            NSString *time = [NSString stringWithFormat:@"%@年%@月%@日", [last.measureTime substringToIndex:4], [last.measureTime substringWithRange:NSMakeRange(5, 2)], [last.measureTime substringWithRange:NSMakeRange(8, 2)]];
            _lblLast.text = [NSString stringWithFormat:@"%.2fkg 检测时间:%@", last.weight, time];
        }
    }];
}

- (void)obtainFirst {
    [[HomeClient shareInstance] obtainChartInfoForFile:WEIGHTFILE item:MEASURETIME sort:DESC handler:^(id response, BOOL isSuccess) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if (isSuccess) {
            Weight *first = [Weight mj_objectWithKeyValues:response];
            NSDate *date = [formatter dateFromString:[first.measureTime substringToIndex:10]];
            [self initUpdateDate:date];
        } else {
            [self initUpdateDate:[formatter dateFromString:@"2000-01-01"]];
        }
    }];
}

#pragma mark - delegate

#pragma mark - Chart view delegate

- (void)obtainDatasRangeDateFrom:(NSString *)from to:(NSString *)to forCell:(UICollectionViewCell *)cell hanler:(void (^)(id, UICollectionViewCell *))handler {
    [self obtainWeightFromDate:from toDate:to forCell:cell];
    _obtainWeights = ^(NSArray *weights, UICollectionViewCell *currentCell) {
        NSMutableDictionary *dataInfo = [NSMutableDictionary dictionary];
        dataInfo[kDataL] = @1;
        dataInfo[kDataT] = @"体脂数据";
        dataInfo[KDataC] = [UIColor orangeColor];
        NSMutableArray *coorditions = [NSMutableArray array];
        [weights enumerateObjectsUsingBlock:^(Weight *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *coordition = [NSMutableDictionary dictionary];
            NSString *time = [NSString stringWithFormat:@"%@月%@日", [obj.measureTime substringWithRange:NSMakeRange(5, 2)], [obj.measureTime substringWithRange:NSMakeRange(8, 2)]];
            coordition[kDataX] = time;
            coordition[kDataY] = @(obj.weight);
            [coorditions addObject:coordition];
        }];
        dataInfo[kDataA] = coorditions;
        handler(dataInfo, currentCell);
    };
}

- (void)dateDidChangeFrom:(NSDate *)from to:(NSDate *)to {
    [self.view endEditing:YES];
    [_vwDatePicker changeDateFrom:from to:to];
}

#pragma mark - Date type delegate

- (void)changeToDateFlag:(NSCalendarUnit)flag {
    [self.view endEditing:YES];
    _vwDatePicker.flag = flag;
    _vwChart.flag = flag;
    _vwChart.endDate = [NSDate date];
    _vwChart.dateTo = [NSDate date];
    [_vwChart updateView];
}

#pragma mark - Date picker delegate

- (void)dateFrom:(NSDate *)from to:(NSDate *)to {
    [self.view endEditing:YES];
    _vwChart.dateFrom = from;
    _vwChart.dateTo = to;
    [_vwChart updateView];
}

#pragma mark - UI

/**
 重置布局
 */
- (void)configDatePicker {
    _vwDatePicker.frame = CGRectMake(0, 0, HRHtyScreenWidth, 50);
    _vwDatePicker.flag = NSCalendarUnitWeekOfMonth;
    _vwDatePicker.delegate = (id)self;
    __weak typeof(_vwDatePicker) weakPicker = _vwDatePicker;
    _updateMin = ^(NSDate *dataStart) {
        weakPicker.dateStart = dataStart;
    };
}

- (void)configDateType {
    NSArray *types = @[@"日视图", @"周视图", @"月视图"];
    _vwDateType.frame = CGRectMake(0, 0, HRHtyScreenWidth, 50);
    _vwDateType.types = types;
    _vwDateType.selectIndex = 1;
    _vwDateType.delegate = (id)self;
    [_vwDateType configView];
}

- (void)configChart {
    _vwChart.frame = CGRectMake(0, 0, HRHtyScreenWidth, 250);
    _vwChart.endDate = [NSDate date];
    _vwChart.dateTo = [NSDate date];
    _vwChart.yAxisMax = 130;
    _vwChart.yAxisMin = 30;
    _vwChart.yLabelCount = 5;
    _vwChart.formatYAxis = ^NSString *(NSString *origin) {
        return [NSString stringWithFormat:@"%@", origin];
    };
    _vwChart.delegate = (id)self;
    _vwChart.flag = NSCalendarUnitWeekOfMonth;
    __weak typeof(_vwChart) weakChart = _vwChart;
    [self obtainFirst];
    _updateStart = ^(NSDate *dataStart) {
        weakChart.startDate = dataStart;
        [weakChart configView];
    };
    _vwChart.formatSymbolInfo = ^NSString *(NSString *time, float value) {
        return [NSString stringWithFormat:@"测量时间：%@\n体重指数:%.2fkg\n", time, value];
    };
}

- (void)initUpdateDate:(NSDate *)date {
    if (_updateStart != nil) {
        _updateStart(date);
    }
    if (_updateMin != nil) {
        _updateMin(date);
    }
}

- (void)addRightItem {
    ArchivesRightItem *rightItemView = [[[NSBundle mainBundle] loadNibNamed:@"ArchivesRightItem" owner:self options:nil] lastObject];
    rightItemView.vc = self;
    rightItemView.title = self.title;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

@end
