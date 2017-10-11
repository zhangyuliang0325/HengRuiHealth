//
//  DatePickerView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "DatePickerView.h"

#import "CheckStringManager.h"

@interface DatePickerView () <UITextFieldDelegate> {
    
    __weak IBOutlet UITextField *_tfTo;
    __weak IBOutlet UILabel *_lblTo;
    __weak IBOutlet UITextField *_tfFrom;
    __weak IBOutlet UILabel *_lblFrom;
    
    UIDatePicker *_datePicker;
    UIView *_accessory;
    NSDate *_dateMaxForStart;
    NSDate *_dateMinForEnd;
    NSInteger _timeType;
}

@end

NSInteger const startTime = 1;
NSInteger const endTime = 2;

@implementation DatePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    _tfTo.delegate = (id)self;
    _tfFrom.delegate = (id)self;
    [self initDatePicker];
    [self initAccessoryView];
}

- (void)initDatePicker{
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"Chinese"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.maximumDate = [NSDate date];
    self.flag = NSCalendarUnitWeekOfMonth;
    self.dateStart = [self calculateDate:[NSDate date] withInterval:-1];
    _datePicker.frame = CGRectMake(0, 0, HRHtyScreenWidth, 216);
}

- (void)initAccessoryView {
    _accessory = [[UIView alloc] init];
    _accessory.frame = CGRectMake(0, 0, HRHtyScreenWidth, 30);
    _accessory.backgroundColor = [UIColor whiteColor];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(8, 0, 50, 30);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [btnCancel addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [_accessory addSubview:btnCancel];
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSure.frame = CGRectMake(HRHtyScreenWidth - 58, 0, 50, 30);
    [btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [btnSure setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnSure.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [btnSure addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
    [_accessory addSubview:btnSure];
}

- (void)initDate {
    self.dateTo = [NSDate date];
    self.dateFrom = [self calculateDate:self.dateTo withInterval:-1];
    [self setDateLabelText];
}

#pragma mark - Public Method

- (void)changeDateFrom:(NSDate *)from to:(NSDate *)to {
    self.dateFrom = from;
    self.dateTo = to;
    [self setDateLabelText];
}

#pragma mark - Action

- (void)clickCancelButton {
    [self endEditing:YES];
}

- (void)clickSureButton {
    [self endEditing:YES];
    [self calculateDate];
    [self setDateLabelText];
    if ([self.delegate respondsToSelector:@selector(dateFrom:to:)]) {
        [self.delegate dateFrom:self.dateFrom to:self.dateTo];
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.inputView = _datePicker;
    textField.inputAccessoryView = _accessory;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strDate;
    if (textField == _tfFrom) {
        strDate = [_lblFrom.text substringFromIndex:1];
    } else {
        strDate = [_lblTo.text substringFromIndex:1];
    }
    NSDate *currentDate = [formatter dateFromString:strDate];
    _datePicker.date = currentDate;
    if (textField == _tfFrom) {
        NSDate *startMin = self.dateStart;
        if ([_dateMaxForStart compare:self.dateStart] == -1) {
            startMin = _dateMaxForStart;
        }
        _datePicker.maximumDate = _dateMaxForStart;
        _datePicker.minimumDate = startMin;
        
        _timeType = startTime;
    } else {
        NSDate *max = [NSDate date];
        if ([max compare:_dateMinForEnd] == -1) {
            _dateMinForEnd = max;
        }
        _datePicker.maximumDate = max;
        _datePicker.minimumDate = _dateMinForEnd;
        _timeType = endTime;
    }
    [self configDatePicker];
    return YES;
}

#pragma mark - setter 

- (void)setFlag:(NSCalendarUnit)flag {
    _flag = flag;
    [self initDate];
    _dateMaxForStart = self.dateFrom;
}

- (void)setDateStart:(NSDate *)dateStart {
    _dateStart = dateStart;
    _datePicker.minimumDate = dateStart;
    _dateMinForEnd = [self calculateDate:dateStart withInterval:1];
}

#pragma mark - Method

- (void)calculateDate {
    switch (_timeType) {
        case startTime:
        {
            self.dateFrom = _datePicker.date;
            self.dateTo = [self calculateDate:self.dateFrom withInterval:1];
        }
            break;
        case endTime:
        {
            NSDate *date = _datePicker.date;
            self.dateTo = _datePicker.date;
            self.dateFrom = [self calculateDate:self.dateTo withInterval:-1];
        }
            break;
        default:
            break;
    }
}

- (NSDate *)calculateDate:(NSDate *)date withInterval:(NSInteger)interval {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *anotherDate = [calendar dateByAddingUnit:self.flag value:interval toDate:date options:NSCalendarSearchBackwards];
    anotherDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-interval toDate:anotherDate options:NSCalendarSearchBackwards];
    return anotherDate;
}

- (void)setDateLabelText {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strFrom = [NSString stringWithFormat:@"自%@", [formatter stringFromDate:self.dateFrom]];
    NSString *strTo = [NSString stringWithFormat:@"至%@", [formatter stringFromDate:self.dateTo]];
    _lblFrom.text = strFrom;
    _lblTo.text = strTo;
}

- (void)configDatePicker {
    NSDate *current = _datePicker.date;
    NSDate *min = _datePicker.minimumDate;
    NSDate *max = _datePicker.maximumDate;
    _datePicker.date = current;
    if ([current compare:min] == -1) {
        _datePicker.date = min;
    } else if ([current compare:max] == 1) {
        _datePicker.date = max;
    }
}

@end
