//
//  PersonInfoTableViewController+PersonInfoManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonInfoTableViewController+PersonInfoManager.h"

#import "FileManager.h"

static NSDictionary *_allProviences;
static NSDictionary *_currentProvience;
static NSArray *_currentCity;

@implementation PersonInfoTableViewController (PersonInfoManager)

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
    return differ > 0 ? probAge + 1 : probAge;
}

- (BOOL)distinguishSex:(NSInteger)code {
    return code == 1;
}

- (NSArray *)obtainProvinces {
    NSString *path = [FileManager openNativePlistFile:@"areas"];
    _allProviences = [NSDictionary dictionaryWithContentsOfFile:path];
    return _allProviences.allKeys;
}

- (NSArray *)obtainCitysByProvince:(NSString *)province {
    _currentProvience = [_allProviences objectForKey:province];
    return _currentProvience.allKeys;
}

- (NSArray *)obtainDistributesByCity:(NSString *)city {
    _currentCity = [_currentProvience objectForKey:city];
    return _currentCity;
}


@end
