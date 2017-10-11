//
//  ChartTypeView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ChartTypeView.h"



@interface ChartTypeView () {
    UIButton *_btnDay;
    UIButton *_btnWeek;
    UIButton *_btnMonth;
    UIView *_slider;
    NSLayoutConstraint *_constraint;
}

@end

NSString *const CONTAINSIDENTIFIER = @"SliderCenter";
NSInteger const TAGDAY = 9001;
NSInteger const TAGWEEK = 9002;
NSInteger const TAGMONTH = 9003;
NSInteger const TAGSLIDER = 9004;

@implementation ChartTypeView

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnDay = (UIButton *)[self viewWithTag:TAGDAY];
    _btnWeek = (UIButton *)[self viewWithTag:TAGWEEK];
    _btnMonth = (UIButton *)[self viewWithTag:TAGMONTH];
    _slider = (UIView *)[self viewWithTag:TAGSLIDER];
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.identifier isEqualToString:CONTAINSIDENTIFIER]) {
            _constraint = constraint;
            break;
        }
    }
}

#pragma mark - Method

- (void)actionForDay:(UIButton *)sender {
    self.type = ChartTypeDay;
    sender.selected = YES;
    _btnWeek.selected = NO;
    _btnMonth.selected = NO;
    _constraint.constant = -(HRHtyScreenWidth / 3);
    if ([self.delegate respondsToSelector:@selector(chooseButtonForType:)]) {
        [self.delegate chooseButtonForType:ChartTypeDay];
    }
}

- (void)actionForWeek:(UIButton *)sender {
    self.type = ChartTypeWeek;
    sender.selected = YES;
    sender.selected = YES;
    _btnMonth.selected = NO;
    _btnDay.selected = NO;
    _constraint.constant = 0;
    if ([self.delegate respondsToSelector:@selector(chooseButtonForType:)]) {
        [self.delegate chooseButtonForType:ChartTypeWeek];
    }
}

- (void)actionForMonth:(UIButton *)sender {
    self.type = ChartTypeMonth;
    sender.selected = YES;
    _btnWeek.selected = NO;
    _btnDay.selected = NO;
    _constraint.constant = (HRHtyScreenWidth / 3);
    if ([self.delegate respondsToSelector:@selector(chooseButtonForType:)]) {
        [self.delegate chooseButtonForType:ChartTypeMonth];
    }
}

@end
