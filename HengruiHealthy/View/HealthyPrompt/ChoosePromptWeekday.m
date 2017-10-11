//
//  ChoosePromptWeekday.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ChoosePromptWeekday.h"

@interface ChoosePromptWeekday () {
    NSMutableArray *_weekdayCodes;
    NSMutableArray *_weekdayNames;
    NSArray *_btnDays;
    __weak IBOutlet UIButton *_btnMonday;
    __weak IBOutlet UIButton *_btnTuresday;
    __weak IBOutlet UIButton *_btnWensday;
    __weak IBOutlet UIButton *_btnThursday;
    __weak IBOutlet UIButton *_btnFriday;
    __weak IBOutlet UIButton *_btnSeturday;
    __weak IBOutlet UIButton *_btnSunday;
}

@end

@implementation ChoosePromptWeekday

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnDays = [NSArray arrayWithObjects:_btnSunday, _btnMonday, _btnTuresday, _btnWensday, _btnThursday, _btnFriday, _btnSeturday, nil];
//    _weekdayCodes = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5, @6, @7]];
//    _weekdayNames = [NSMutableArray arrayWithArray:@[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]];
    self.frame = CGRectMake(0, HRHtyScreenHeight, HRHtyScreenWidth, HRHtyScreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
}

- (IBAction)monday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@2];
        [_weekdayNames addObject:@"周一"];
    } else {
        [_weekdayCodes removeObject:@2];
        [_weekdayNames removeObject:@"周一"];
    }
}

- (IBAction)turesday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@3];
        [_weekdayNames addObject:@"周二"];
    } else {
        [_weekdayCodes removeObject:@3];
        [_weekdayNames removeObject:@"周二"];
    }
}

- (IBAction)wensday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@4];
        [_weekdayNames addObject:@"周三"];
    } else {
        [_weekdayCodes removeObject:@4];
        [_weekdayNames removeObject:@"周三"];
    }
}

- (IBAction)thursday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@5];
        [_weekdayNames addObject:@"周四"];
    } else {
        [_weekdayCodes removeObject:@5];
        [_weekdayNames removeObject:@"周四"];
    }
}

- (IBAction)friday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@6];
        [_weekdayNames addObject:@"周五"];
    } else {
        [_weekdayCodes removeObject:@6];
        [_weekdayNames removeObject:@"周五"];
    }
}

- (IBAction)seturday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@7];
        [_weekdayNames addObject:@"周六"];
    } else {
        [_weekdayCodes removeObject:@7];
        [_weekdayNames removeObject:@"周六"];
    }
}

- (IBAction)sunday:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_weekdayCodes addObject:@1];
        [_weekdayNames addObject:@"周日"];
    } else {
        [_weekdayCodes removeObject:@1];
        [_weekdayNames removeObject:@"周日"];
    }
}

- (IBAction)cancel:(UIButton *)sender {
    [self hide];
}

- (IBAction)sure:(UIButton *)sender {
    [self hide];
//    if ([self.delegate respondsToSelector:@selector(choosedWeekdayNames:codes:)]) {
//        [self.delegate choosedWeekdayNames:_weekdayNames codes:_weekdayCodes];
//    }
    if ([self.delegate respondsToSelector:@selector(choosedWeekdaysName:)]) {
        NSMutableString *nameString = [NSMutableString string];
        for (int i = 0; i < _weekdayNames.count; i ++) {
            [nameString appendFormat:@"%@;", _weekdayNames[i]];
        }
        [nameString deleteCharactersInRange:NSMakeRange(nameString.length - 1, 1)];
        [self.delegate choosedWeekdaysName:nameString];
    }
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(HRHtyScreenHeight));
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
    }];
}

- (void)changeWeekdays:(BOOL)isAdd code:(NSNumber *)code name:(NSString *)name {
    if (isAdd) {
        [_weekdayCodes addObject:code];
        [_weekdayNames addObject:name];
    } else {
        [_weekdayNames removeObject:name];
        [_weekdayNames removeObject:code];
    }
}

- (void)setSelectDays:(NSArray *)days names:(NSArray *)names {
    if (_weekdayNames == nil) {
        _weekdayNames = [NSMutableArray array];
    }
    [_weekdayNames removeAllObjects];
    [_weekdayNames addObjectsFromArray:names];
    if (_weekdayCodes == nil) {
        _weekdayCodes = [ NSMutableArray array];
    }
    [_weekdayCodes removeAllObjects];
    [_weekdayCodes addObjectsFromArray:days];
    for (NSNumber *code in days) {
        NSInteger index = code.integerValue - 1;
        UIButton *btn = _btnDays[index];
        btn.selected = YES;
    }
}
@end
