//
//  HealthyPrompt.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyPrompt.h"

@implementation HealthyPrompt

@synthesize weekdays = _weekdays;

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"createTime":@"CreateTime",
             @"promptId":@"Id",
             @"isEnable":@"IsEnabled",
             @"isVibrating":@"IsVibrating",
             @"person":@"PatientUser",
             @"remark":@"Remark",
             @"promptTime":@"RemindTime",
             @"ring":@"Ring",
             @"title":@"Title",
             @"userId":@"UserId",
             @"weekdays":@"RemindWeek"
             };
}

#pragma mark - Setter

- (void)setWeekdays:(NSString *)weekdays {
    _weekdays = weekdays;
    self.weekdayNames = [weekdays componentsSeparatedByString:@";"];
}

- (void)setWeekdayNames:(NSArray *)weekdayNames {
    _weekdayNames = weekdayNames;
    if (weekdayNames.count != 0) {
        NSMutableArray *codes = [NSMutableArray array];
        for (int i = 0; i < weekdayNames.count; i ++) {
            NSString *name = weekdayNames[i];
            if ([name isEqualToString:@"周日"]) {
                [codes addObject:@1];
            } else if ([name isEqualToString:@"周一"]) {
                [codes addObject:@2];
            } else if ([name isEqualToString:@"周二"]) {
                [codes addObject:@3];
            } else if ([name isEqualToString:@"周三"]) {
                [codes addObject:@4];
            } else if ([name isEqualToString:@"周四"]) {
                [codes addObject:@5];
            } else if ([name isEqualToString:@"周五"]) {
                [codes addObject:@6];
            } else if ([name isEqualToString:@"周六"]) {
                [codes addObject:@7];
            }
        }
        self.weekdayCodes = codes;
    }
}

- (void)setPromptTime:(NSString *)promptTime {
    _promptTime = promptTime;
    self.hour = [[promptTime substringToIndex:2] integerValue];
    self.minute = [[promptTime substringFromIndex:3] integerValue];
}

#pragma mark - Getter 

- (NSString *)weekdays {
    NSString *days = [_weekdays stringByReplacingOccurrencesOfString:@";" withString:@"、"];
    if (_weekdayNames.count == 7) {
        days = @"每天";
    }
    return days;
}


@end
