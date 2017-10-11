//
//  HDDateView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDDateView.h"

@interface HDDateView () {
    
    __weak IBOutlet UIImageView *_imgEnd;
    __weak IBOutlet UIImageView *_imgStart;
    __weak IBOutlet UILabel *_lblDate;
    
}

@end

@implementation HDDateView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self instanceComponts];
}

- (instancetype)init {
    if (self = [super init]) {
        [self instanceComponts];
    }
    return self;
}

- (void)instanceComponts {
    
//    self.inputDate = [NSDate date];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDateView:)];
    [self addGestureRecognizer:tap];
    
    self.inputView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, HRHtyScreenWidth, 216)];
    self.inputView.locale = [NSLocale localeWithLocaleIdentifier:@"Chinese"];
    self.inputView.datePickerMode = UIDatePickerModeDate;
    self.inputView.maximumDate = [NSDate date];
    
    self.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HRHtyScreenWidth, 30)];
    self.inputAccessoryView.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancel sizeToFit];
    cancel.frame = CGRectMake(8, 0, cancel.bounds.size.width, 30);
    [cancel addTarget:self action:@selector(actionForCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputAccessoryView addSubview: cancel];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sure sizeToFit];
    sure.frame = CGRectMake(HRHtyScreenWidth - 8 - sure.bounds.size.width, 0, sure.bounds.size.width, 30);
    [sure addTarget:self action:@selector(actionForSureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputAccessoryView addSubview:sure];
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canBecomeFocused {
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

#pragma mark - Action

- (void)actionForCancel:(UIButton *)sender {
    [self resignFirstResponder];
}

- (void)actionForSureButton:(UIButton *)sender {
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy年MM月dd日"];
//    NSString *dateString = [format stringFromDate:self.inputView.date];
//    _lblDate.text = self.formatDateString(dateString);
//    [_lblDate sizeToFit];
//    self.textWidth = _lblDate.bounds.size.width;
    [self resignFirstResponder];
    self.inputDate = self.inputView.date;
    if ([self.delegate respondsToSelector:@selector(chooseDate:type:)]) {
        [self.delegate chooseDate:self.inputView.date type:self.type];
    }
}

- (void)touchDateView:(UITapGestureRecognizer *)sender {
    if (_inputDate == nil) {
        _inputDate = [NSDate date];
    }
    self.inputView.date = self.inputDate;
    [self becomeFirstResponder];
}

#pragma mark - Setter

- (void)setInputDate:(NSDate *)inputDate {
    _inputDate = inputDate;
    if (inputDate == nil) {
        _inputDate = [NSDate date];
        _lblDate.text = self.formatDateString(@"----年--月--日");
    } else {
        [self configDateText];
    }
}

#pragma mark - Method

- (void)configDateText {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [format stringFromDate:self.inputDate];
    _lblDate.text = self.formatDateString(dateString);
    [_lblDate sizeToFit];
    self.textWidth = _lblDate.bounds.size.width;
}

- (void)repleaceView {
    self.inputDate = [NSDate date];
    _lblDate.text = self.formatDateString(@"----年--月--日");
}

@end
