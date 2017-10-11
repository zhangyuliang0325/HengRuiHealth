//
//  BloodPressureTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BloodPressureTableViewController.h"

#import "DatePickerView.h"
#import "DateTypeView.h"
#import "ChartView.h"
#import "ArchivesRightItem.h"

#import "BloodProsure.h"

#import "HomeClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>

typedef void(^UpdateStartDate)(NSDate *dateStart);
typedef void(^ObtainBloodProsureFromServer)(NSArray *bloodProsures, UICollectionViewCell *cell);

@interface BloodPressureTableViewController () <ChartViewDelegate, DateTypeViewDelegate, DatePickerViewDelegate> {
    
    __weak IBOutlet UIView *_legend;
    __weak IBOutlet ChartView *_vwChart;
    __weak IBOutlet DateTypeView *_vwDateType;
    __weak IBOutlet DatePickerView *_vwDatePicker;
    __weak IBOutlet UILabel *_lblHeightDiastolic;
    __weak IBOutlet UILabel *_lblHeightSystolic;
    __weak IBOutlet UILabel *_lblLowDistolic;
    __weak IBOutlet UILabel *_lblLowSystolic;
    __weak IBOutlet UILabel *_lblLastDistolic;
    __weak IBOutlet UILabel *_lblLastSystolic;
    __weak IBOutlet UILabel *_lblLastTime;
    
    UpdateStartDate _updateStart;
    UpdateStartDate _updateMin;
    ObtainBloodProsureFromServer _obtainBloodProsuress;
}

@end

static NSInteger totalProgress = 0;

@implementation BloodPressureTableViewController

- (void)dealloc {
    self.navigationItem.rightBarButtonItems = nil;
    NSLog(@"pressure dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightItem];
    [self configChart];
    [self configDateType];
    [self configDatePicker];
    [self loadingProgress:0];
    [self obtainHighDistolic];
    [self obtainHighSystolic];
    [self obtainLowDistolic];
    [self obtainLowSystolic];
    [self obtainLast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (void)loadingProgress:(NSInteger)progress {
    totalProgress += progress;
    if (totalProgress == 0) {
        [MBPrograssManager showPrograssOnMainView];
    } else if (totalProgress == 5) {
        [MBPrograssManager hidePrograssFromMainView];
    }
}

#pragma mark - Http server

- (void)obtainBloodPressureFromDate:(NSString *)startDate toDate:(NSString *)endDate forCell:(UICollectionViewCell *)cell {
//    [MBPrograssManager showPrograssOnMainView];
    [[HomeClient shareInstance] obtainChartFile:BLOODPRESSUREFILE fromDate:startDate toDate:endDate sort:DESC handler:^(id response, BOOL isSuccess) {
//        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            
            NSArray *bloodProsures = [BloodProsure mj_objectArrayWithKeyValuesArray:response];
            _obtainBloodProsuress(bloodProsures, cell);
        } 
    }];
}

- (void)obtainHighDistolic {
    [[HomeClient shareInstance] obtainChartInfoForFile:BLOODPRESSUREFILE item:DIASTOLICPRESSURE sort:DESC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            BloodProsure *height = [BloodProsure mj_objectWithKeyValues:response];
            _lblHeightDiastolic.text = [NSString stringWithFormat:@"收缩压:%.2f", height.systolicpressure];
        }
    }];
}

- (void)obtainHighSystolic {
    [[HomeClient shareInstance] obtainChartInfoForFile:BLOODPRESSUREFILE item:SYSTOLICPRESSURE sort:DESC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            BloodProsure *height = [BloodProsure mj_objectWithKeyValues:response];
            _lblHeightSystolic.text = [NSString stringWithFormat:@"舒张压:%.2f", height.diastolicpressure];
        }
    }];
}

- (void)obtainLowDistolic {
    [[HomeClient shareInstance] obtainChartInfoForFile:FATFILE item:DIASTOLICPRESSURE sort:ASC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            BloodProsure *low = [BloodProsure mj_objectWithKeyValues:response];
            _lblLowDistolic.text = [NSString stringWithFormat:@"收缩压:%.2f", low.systolicpressure];
        }
    }];
}

- (void)obtainLowSystolic {
    [[HomeClient shareInstance] obtainChartInfoForFile:BLOODPRESSUREFILE item:SYSTOLICPRESSURE sort:ASC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        if (isSuccess) {
            
            BloodProsure *low = [BloodProsure mj_objectWithKeyValues:response];
            _lblLowSystolic.text = [NSString stringWithFormat:@"舒张压:%.2f", low.diastolicpressure];
        }
    }];
}


- (void)obtainLast {
    [[HomeClient shareInstance] obtainChartInfoForFile:BLOODPRESSUREFILE item:MEASURETIME sort:ASC handler:^(id response, BOOL isSuccess) {
        [self loadingProgress:1];
        BloodProsure *last = [BloodProsure mj_objectWithKeyValues:response];
        if (isSuccess) {
            
            NSString *time = [NSString stringWithFormat:@"%@年%@月%@日", [last.measureTime substringToIndex:4], [last.measureTime substringWithRange:NSMakeRange(5, 2)], [last.measureTime substringWithRange:NSMakeRange(8, 2)]];
            _lblLastDistolic.text = [NSString stringWithFormat:@"收缩压:%.2f", last.systolicpressure];
            _lblLastSystolic.text = [NSString stringWithFormat:@"舒张压:%.2f", last.diastolicpressure];
            _lblLastTime.text = [NSString stringWithFormat:@"检测时间:%@", time];
        }
    }];
}

- (void)obtainFirst {
    [[HomeClient shareInstance] obtainChartInfoForFile:BLOODPRESSUREFILE item:MEASURETIME sort:ASC handler:^(id response, BOOL isSuccess) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if (isSuccess) {
            BloodProsure *first = [BloodProsure mj_objectWithKeyValues:response];
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
    [self obtainBloodPressureFromDate:from toDate:to forCell:cell];
    _obtainBloodProsuress = ^(NSArray *bloodProsures, UICollectionViewCell *currentCell) {
        NSMutableArray *datas = [NSMutableArray array];
        for (int i = 0; i < 2; i ++) {
            NSMutableDictionary *dataInfo = [NSMutableDictionary dictionary];
            dataInfo[kDataL] = @2;
            dataInfo[kDataT] = i == 0 ? @"收缩压": @"舒张压";
            dataInfo[KDataC] = i == 0 ? [UIColor blueColor] : [UIColor orangeColor];
            NSMutableArray *coorditions = [NSMutableArray array];
            [bloodProsures enumerateObjectsUsingBlock:^(BloodProsure *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *coordition = [NSMutableDictionary dictionary];
                NSString *time = [NSString stringWithFormat:@"%@月%@日", [obj.measureTime substringWithRange:NSMakeRange(5, 2)], [obj.measureTime substringWithRange:NSMakeRange(8, 2)]];
                coordition[kDataX] = time;
                coordition[kDataY] = i == 0 ? @(obj.systolicpressure) : @(obj.diastolicpressure);
                [coorditions addObject:coordition];
            }];
            dataInfo[kDataA] = coorditions;
            [datas addObject:dataInfo];
        }
        handler(datas, currentCell);
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
    _vwChart.yAxisMax = 200;
    _vwChart.yAxisMin = 60;
    _vwChart.yLabelCount = 7;
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
        return [NSString stringWithFormat:@"测量时间：%@\n血压指数:%.2f%%\n", time, value];
    };
    _vwChart.legendView = _legend;
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
