//
//  PersonInfoManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonInfoManager.h"

@implementation PersonInfoManager

- (NSInteger)calculateAge:(NSString *)birth {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:flags fromDate:now];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *constrastDate = [format dateFromString:[NSString stringWithFormat:@"%@-%d-%d", [birth substringToIndex:3], (int)components.month, (int)components.day]];
    NSString *formatBirth = [NSString stringWithFormat:@"%@-%@-%@", [birth substringToIndex:4], [birth substringWithRange:NSMakeRange(4, 2)], [birth substringWithRange:NSMakeRange(6, 2)]];
    NSDate *birthday = [format dateFromString:formatBirth];
    NSTimeInterval differ = [constrastDate timeIntervalSinceDate:birthday] + 84600;
    NSInteger probAge = components.year - [[birth substringToIndex:3] integerValue];
    return differ > 0 ? probAge : probAge - 1;
}

- (BOOL)distinguishSex:(NSInteger)code {
    if (code) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)obtainBirthday:(NSString *)birth {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *formatBirth = [NSString stringWithFormat:@"%@-%@-%@", [birth substringToIndex:4], [birth substringWithRange:NSMakeRange(4, 2)], [birth substringWithRange:NSMakeRange(6, 2)]];
    return [format dateFromString:formatBirth];
}

@end
