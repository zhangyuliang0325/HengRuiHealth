//
//  VertifyButton.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "VertifyButton.h"

@interface VertifyButton () {
    NSTimer *_timer;
}

@end

@implementation VertifyButton


- (void)triggerTime {
    if (_timer != nil) {
        [_timer invalidate];
    }
    self.enabled = NO;
    [self setConstraintWidth:110];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountDown) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timeCountDown {
    static NSInteger secont = 60;
    if (secont < 1) {
        [_timer invalidate];
        self.enabled = YES;
        [self setConstraintWidth:80];
        secont = 60;
        return;
    }
    [self setTitle:[NSString stringWithFormat:@"%d秒后重新获取", (int)secont] forState:UIControlStateDisabled];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    secont --;
}

- (NSLayoutConstraint *)obtainConstraintWithIdentifier:(NSString *)identifier {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.identifier isEqualToString:identifier]) {
            return constraint;
        }
    }
    return nil;
}

- (void)setConstraintWidth:(CGFloat)width {
    NSLayoutConstraint *constraint = [self obtainConstraintWithIdentifier:@"vertify_width"];
    constraint.constant = width;
}

@end
