//
//  HDStatisticsView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDStatisticsView.h"

@interface HDStatisticsView () {
    UIView *_dataView;
}

@end

@implementation HDStatisticsView

- (instancetype)init {
    if (self = [super init]) {
        _dataView = [UIView new];
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:_dataView];
        _dataView.backgroundColor = [UIColor greenColor];
        [self configShapeLayer];
    }
    return self;
}

- (void)configShapeLayer {
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.lineWidth = 1 / [UIScreen mainScreen].scale;
    self.shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    [_dataView.layer addSublayer:self.shapeLayer];
}

- (void)configView {
    
    NSMutableArray *portraitLabelWidths = [NSMutableArray array];
    NSMutableArray *portraintLabels = [NSMutableArray array];
    for (int i = 0; i < self.portraitDatas.count; i ++) {
        UILabel *portraintLabel = [self coordinateLabelWithText:self.portraitDatas[i]];
//        [portraitLabelWidths addObject:[NSNumber numberWithFloat:portraintLabel.bounds.size.width]];
        [portraitLabelWidths addObject:[NSString stringWithFormat:@"%f",portraintLabel.bounds.size.width]];
        [portraintLabels addObject:portraintLabel];
    }
    CGFloat offsetY = (self.bounds.size.height - 15) / self.portraitDatas.count;
    CGFloat maxPortraitLabelWidth = [[portraitLabelWidths valueForKeyPath:@"@max.floatValue"] floatValue];
    NSMutableArray *portraintYs = [NSMutableArray array];
    for (int i = 0; i < portraintLabels.count; i ++) {
        UILabel *portraintLabel = portraintLabels[i];
        CGFloat y = (self.bounds.size.height - 15) - offsetY * i;
        [portraintYs addObject:[NSNumber numberWithFloat:y]];
        CGRect rect = {{5, y - 7}, {maxPortraitLabelWidth, 14}};
        portraintLabel.frame = rect;
        [self addSubview:portraintLabel];
    }
    CGFloat offsetX = (self.bounds.size.width - maxPortraitLabelWidth - 10) / self.transverseDatas.count;
    for (int i = 0; i < self.transverseDatas.count; i ++) {
        UILabel *transversLabel = [self coordinateLabelWithText:self.transverseDatas[i]];
        CGFloat centerX = (maxPortraitLabelWidth + 10) + offsetX * i;
        transversLabel.center = CGPointMake(centerX, self.bounds.size.height - 7.5);
        [transversLabel sizeToFit];
        [self addSubview:transversLabel];
    }
    _dataView.frame = CGRectMake(maxPortraitLabelWidth + 10, 0, self.bounds.size.width - maxPortraitLabelWidth - 10, self.bounds.size.height - 15);
    self.shapeLayer.frame = CGRectMake(0, 0, _dataView.bounds.size.width, _dataView.bounds.size.height);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        for (int i = 0; i < portraintYs.count; i ++) {
            [bezier moveToPoint:CGPointMake(0, [portraintYs[i] floatValue])];
            [bezier addLineToPoint:CGPointMake(_dataView.bounds.size.width, [portraintYs[i] floatValue])];
        }
        self.shapeLayer.path = bezier.CGPath;
    });
}

- (UILabel *)coordinateLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = [UIColor darkTextColor];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}



@end
