//
//  TimeQuantumView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#define HRTQWidth self.bounds.size.width

#import "TimeQuantumView.h"

NSInteger const TAGVWSTART = 8001;
NSInteger const TAGLBLSTART = 8002;
NSInteger const TAGIMGSTART = 8003;
NSInteger const TAGTFSTART = 8004;

NSInteger const TAGVWEND = 9001;
NSInteger const TAGLBLEND = 9002;
NSInteger const TAGIMGEND = 9003;
NSInteger const TAGTFEND = 9004;

#import <Masonry/Masonry.h>

@interface TimeQuantumView () <UITextFieldDelegate> {
    UIView *_vwStart;
    UIView *_vwEnd;
    UILabel *_lblStart;
    UILabel *_lblEnd;
    UIImageView *_imgStart;
    UIImageView *_imgEnd;
    UITextField *_tfStart;
    UITextField *_tfEnd;
    
    UIDatePicker *_datePicker;
    UIView *_inputAccessory;
}

@end

@implementation TimeQuantumView

- (void)awakeFromNib {
    [super awakeFromNib];
    _vwStart = (UIView *)[self viewWithTag:TAGVWSTART];
    _lblStart = (UILabel *)[_vwStart viewWithTag:TAGLBLSTART];
    _imgStart = (UIImageView *)[_vwStart viewWithTag:TAGIMGSTART];
    _tfStart = (UITextField *)[_vwStart viewWithTag:TAGTFSTART];
    _tfStart.delegate = (id)self;
    
    _vwEnd = (UIView *)[self viewWithTag:TAGVWEND];
    _lblEnd = (UILabel *)[_vwStart viewWithTag:TAGLBLEND];
    _imgEnd = (UIImageView *)[_vwStart viewWithTag:TAGIMGEND];
    _tfEnd = (UITextField *)[_vwStart viewWithTag:TAGTFEND];
    _tfEnd.delegate = (id)self;
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.frame = CGRectMake(0, 0, HRTQWidth, 216);
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"cn"];
    _datePicker.maximumDate = [NSDate date];
    
    _inputAccessory = [[UIView alloc] init];
    _inputAccessory.frame = CGRectMake(0, 0, HRTQWidth, 30);
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(HRTQWidth - 50, 0, 30, 30);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(actionForSure:) forControlEvents:UIControlEventTouchUpInside];
    [_inputAccessory addSubview:sure];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    if (textField == _tfStart) {
        self.type = TimeStart;
        if ([self.delegate respondsToSelector:@selector(calculateMaxDate)]) {
            NSDate *max = [self.delegate calculateMaxDate];
            _datePicker.maximumDate = max;
            if (_lblStart.text != nil) {
                NSDate *date = [formatter dateFromString:[_lblEnd.text substringFromIndex:1]];
                date = [max compare:date] == -1 ? max : date;
                _datePicker.date = date;
            }
            
        }
    } else {
        self.type = TimeEnd;
        if (_lblEnd.text != nil) {
            NSDate *date = [formatter dateFromString:[_lblEnd.text substringFromIndex:1]];
            _datePicker.date = date;
        }
    }
    textField.inputView = _datePicker;
    textField.inputAccessoryView = _inputAccessory;
    return YES;
}

#pragma mark - Method

- (void)actionForSure:(UIButton *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    if ([self.delegate respondsToSelector:@selector(calculateDateWithChooseDate:type:)]) {
        NSDate *anotherDate = [self.delegate calculateDateWithChooseDate:_datePicker.date type:self.type];
        switch (self.type) {
            case TimeStart:
                _lblStart.text = [NSString stringWithFormat:@"自%@", [formatter stringFromDate:_datePicker.date]];
                _lblEnd.text = [NSString stringWithFormat:@"至%@", [formatter stringFromDate:anotherDate]];
                
                break;
            case TimeEnd:
                _lblStart.text = [NSString stringWithFormat:@"自%@", [formatter stringFromDate:anotherDate]];
                _lblEnd.text = [NSString stringWithFormat:@"至%@", [formatter stringFromDate:_datePicker.date]];
                break;
            default:
                break;
        }
    }
    
}

@end
