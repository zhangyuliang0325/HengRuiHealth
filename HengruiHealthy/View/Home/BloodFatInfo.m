//
//  BloodFatInfo.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BloodFatInfo.h"

@interface BloodFatInfo () {
    
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblBizhi;
    __weak IBOutlet UILabel *_lblDimidu;
    __weak IBOutlet UILabel *_lblGanyou;
    __weak IBOutlet UILabel *_lblGaomidu;
    __weak IBOutlet UILabel *_lblDangucun;
}

@end

@implementation BloodFatInfo

- (void)configInfo {
    NSString *time = self.fat.measureTime;
    time = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@", [time substringToIndex:4], [time substringWithRange:NSMakeRange(5, 2)], [time substringWithRange:NSMakeRange(8, 2)], [time substringWithRange:NSMakeRange(11, 2)], [time substringWithRange:NSMakeRange(14, 2)]];
    _lblTime.text = time;
//    _lblTime.textColor = [UIColor  colorWithRed:255/255 green:/255 blue:0/255 alpha:1];
    _lblDangucun.text = self.fat.dangucun;
    [self configLabelColor:_lblDangucun value:self.fat.dangucun.floatValue max:5.66 min:5.20];
    _lblGanyou.text = self.fat.ganyou;
    if (self.fat.ganyou.floatValue > 0.91) {
        _lblGanyou.textColor = [UIColor colorWithRed:0.0/255 green:128.0/255 blue:0.0/255 alpha:1];
    } else {
        _lblGanyou.textColor = [UIColor colorWithRed:255.0/255 green:153.0/255 blue:0.0/255 alpha:1];
    }
    _lblGaomidu.text = self.fat.gaomidu;
    [self configLabelColor:_lblGaomidu value:self.fat.gaomidu.floatValue max:2.25 min:1.69];
    _lblDimidu.text = self.fat.dimidu;
    [self configLabelColor:_lblDimidu value:self.fat.dimidu.floatValue max:3.59 min:3.13];
    _lblBizhi.text = self.fat.bizhi;
    if (self.fat.bizhi.floatValue >= 5.0) {
        _lblBizhi.textColor = [UIColor colorWithRed:255.0/255 green:0.0/255 blue:0.0/255 alpha:1];
    } else {
        _lblBizhi.textColor = [UIColor colorWithRed:0.0/255 green:128.0/255 blue:0.0/255 alpha:1];
    }
    
}
- (IBAction)actionForCancel:(id)sender {
    [self removeFromSuperview];
}

- (void)configLabelColor:(UILabel *)label value:(CGFloat)value max:(CGFloat)max min:(CGFloat)min {
    if (value <= min) {
        label.textColor = [UIColor colorWithRed:0.0/255 green:128.0/255 blue:0.0/255 alpha:1];
    } else if (value >= max) {
        label.textColor = [UIColor colorWithRed:255.0/255 green:0.0/255 blue:0.0/255 alpha:1];
    } else {
        label.textColor = [UIColor colorWithRed:255.0/255 green:153.0/255 blue:0.0/255 alpha:1];
    }
}

@end
