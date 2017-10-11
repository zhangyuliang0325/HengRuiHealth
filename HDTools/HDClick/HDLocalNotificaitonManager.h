//
//  HDLocalNotificaitonManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HDNotificationManagerDelegate <NSObject>

- (void)receiveLocalNotification:(UILocalNotification *)localNotificaiton;

@end

@interface HDLocalNotificaitonManager : NSObject

+ (instancetype)shareInstance;

@property (copy, nonatomic) NSString *soundName;
@property (assign, nonatomic) NSInteger badge;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *fireDates;
//@property (assign, nonatomic) NSInteger hour;
//@property (assign, nonatomic) NSInteger minute;
//@property (strong, nonatomic) NSArray *weekdays;
@property (strong, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSDictionary *userInfo;
@property (copy, nonatomic) NSString *imageName;
@property (assign, nonatomic) NSCalendarUnit repeatInterval;
@property (assign, nonatomic) id<HDNotificationManagerDelegate> delegate;
@property (assign, nonatomic) BOOL isRepeat;

- (void)registNotificaiton;
- (void)addNotificaitons;
- (void)cancelNotification:(NSString *)notificationIdentifier;
- (void)modifyNotificaiton:(NSString *)notificationIdentifier;
- (void)cancelAllNotificaitons;


@end
