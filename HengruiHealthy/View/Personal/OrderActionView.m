//
//  OrderActionView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "OrderActionView.h"

#import "OrderAction.h"

@implementation OrderActionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    _frame = frame;
    [self configSubViews];
}

- (void)setOrderActions:(NSArray *)orderActions {
    _orderActions = orderActions;
    [self configSubViews];
}

- (void)configSubViews {
    if (CGRectIsNull(_frame) || CGRectIsEmpty(_frame)) {
        return;
    }
    if (_orderActions == nil || _orderActions.count == 0) {
        return;
    }
    CGFloat w = (_frame.size.width - 30) / 4;
    CGFloat x = w + 10;
    for (int i = 0; i < _orderActions.count; i ++) {
        OrderAction *action = _orderActions[i];
        UIButton *actionButton = [[[NSBundle mainBundle] loadNibNamed:@"OrderActionButton" owner:self options:nil] lastObject];
        actionButton.layer.borderColor = [UIColor orangeColor].CGColor;
        [actionButton setTitle:action.title forState:UIControlStateNormal];
        [actionButton addTarget:action.target action:NSSelectorFromString(action.actionName) forControlEvents:UIControlEventTouchUpInside];
        actionButton.frame = CGRectMake(i * x, 5, w, _frame.size.height - 10);
        [self addSubview:actionButton];
    }

    
}

@end
