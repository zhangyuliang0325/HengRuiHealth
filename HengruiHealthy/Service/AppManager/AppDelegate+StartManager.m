//
//  AppDelegate+StartManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppDelegate+StartManager.h"

#import "FileManager.h"

@implementation AppDelegate (StartManager)

- (NSString *)checkAppVersion {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

- (NSInteger)fetchStartCount {
    NSString *currentVersion = [self checkAppVersion];
//    NSString *appInfoPath = [FileManager openNativePlistFile:@"AppInfo"];
//    NSMutableDictionary *appInfo = [NSMutableDictionary dictionaryWithContentsOfFile:appInfoPath];
    NSString *originVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"key_hr_health_version"];
    if ([originVersion isEqualToString:currentVersion]) {
//        NSInteger startCount = [appInfo[@"start_count"] integerValue];
        NSInteger startCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_hr_health_start_count"];
        startCount ++;
        [[NSUserDefaults standardUserDefaults] setInteger:startCount forKey:@"key_hr_health_start_count"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"key_hr_health_version"];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"key_hr_health_start_count"];
    }
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"key_hr_health_start_count"];
}

@end
