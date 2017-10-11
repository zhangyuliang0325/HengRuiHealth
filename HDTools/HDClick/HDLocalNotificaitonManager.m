//
//  HDLocalNotificaitonManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDLocalNotificaitonManager.h"

#import <UserNotifications/UserNotifications.h>

@interface HDLocalNotificaitonManager () <UNUserNotificationCenterDelegate> {
    UNUserNotificationCenter *_center;
}

@end

@implementation HDLocalNotificaitonManager

+ (instancetype)shareInstance {
    static HDLocalNotificaitonManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDLocalNotificaitonManager alloc] init];
    });
    return manager;
}




#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)registNotificaiton {
    _center = [UNUserNotificationCenter currentNotificationCenter];
    [_center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            [NSException raise:@"regist notification error" format:@"%@", error.localizedDescription];
        }
//        NSAssert(granted, @"没有通知权限");
    }];
}

- (void)addNotificaitons {
    for (int i = 0; i < self.fireDates.count; i ++) {
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:self.fireDates[i] repeats:self.isRepeat];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = _title;
        content.badge = @(_badge);
        content.body = _content;
        content.subtitle = _subTitle;
        content.userInfo = _userInfo;
        content.categoryIdentifier = _identifier;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:_soundName];
        content.sound = sound;
        content.launchImageName = _imageName;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:_identifier content:content trigger:trigger];
        [_center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                [NSException raise:@"add notification error" format:@"%@", error.localizedDescription];
            }
        }];
    }
}

- (void)cancelNotification:(NSString *)notificaionIdentifier {
    [_center removePendingNotificationRequestsWithIdentifiers:@[notificaionIdentifier]];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"%@", notification);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"%@", response.notification);
}

- (void)modifyNotificaiton:(NSString *)notificationIdentifier {
    [_center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        for (UNNotificationRequest *request in requests) {
            if ([request.identifier isEqualToString:notificationIdentifier]) {
                [self cancelNotification:notificationIdentifier];
                [self addNotificaitons];
            }
        }
    }];
}

- (void)cancelAllNotificaitons {
    [_center removeAllPendingNotificationRequests];
}

#else

- (void)registNotificaiton {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

//- (void)addNotificaitons {
//    NSMutableArray *localNotifications = [NSMutableArray array];
//    for (int i = 0; i < self.fireDates.count; i ++) {
//        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//        [self configLocalNotification:localNotification];
//        [localNotifications  addObject:localNotification];
//        
//    }
//    [UIApplication sharedApplication].scheduledLocalNotifications = localNotifications;
//}

- (void)addNotificaitons {
    NSMutableArray *localNotifications = [NSMutableArray array];
    for (int i = 0; i < self.fireDates.count; i ++) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        [self configLocalNotification:localNotification fireComponents:self.fireDates[i]];
        [localNotifications  addObject:localNotification];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void)cancelNotification:(NSString *)notificationIdentifier {
    NSMutableArray *localNotifications = [NSMutableArray arrayWithArray:[UIApplication sharedApplication].scheduledLocalNotifications];
    for (UILocalNotification *localNotification in localNotifications) {
        if ([localNotification.category isEqualToString:notificationIdentifier]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
    }
}

- (void)configLocalNotification:(NSLocalNotification *)localNotification fireComponents:(NSDateComponents *)components{
    localNotification.alertTitle = _title;
    localNotification.alertBody = _content;
    localNotification.soundName = _soundName;
    localNotification.alertLaunchImage = _imageName;
    localNotification.userInfo = _userInfo;
    localNotification.applicationIconBadgeNumber = _badge;
    NSDate *fireDate = [[NSCalendar current] dateFromComponents:components];
    localNotification.fireDate = fireDate;
    if (self.isRepeate) {
        localNotification.repeatInterval = _repeatInterval;
    }
    localNotification.category = _identifier;
}

- (void)modifyNotificaiton:(NSString *)notificationIdentifier {
    NSMutableArray *localNotifications = [NSMutableArray arrayWithArray:[UIApplication sharedApplication].scheduledLocalNotifications];
    for (UILocalNotification *localNotification in localNotifications) {
        if ([localNotification.category isEqualToString:notificationIdentifier]) {
            [self configLocalNotification:localNotification];
        }
    }
}

- (void)cancelAllNotificaitons {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#endif

@end
