//
//  PromptManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/20.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PromptManager.h"

#import "HDLocalNotificaitonManager.h"
#import <MJExtension.h>
@interface PromptManager () {
    HDLocalNotificaitonManager *_notificationManager;
}

@end

@implementation PromptManager

- (instancetype)init {
    if (self = [super init]) {
        _notificationManager = [HDLocalNotificaitonManager shareInstance];
    }
    return self;
}

- (void)addNotification:(HealthyPrompt *)prompt {
    _notificationManager.soundName = prompt.ring;
    _notificationManager.content = prompt.remark;
    _notificationManager.title = @"健康提醒";
    NSMutableArray *componentses = [NSMutableArray array];
    for (int i = 0; i < prompt.weekdayCodes.count; i ++) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.weekday = [prompt.weekdayCodes[i] integerValue];
        components.hour = prompt.hour;
        components.minute = prompt.minute;
        [componentses addObject:components];
    }
    _notificationManager.fireDates = componentses;
    _notificationManager.identifier = prompt.promptId;
    _notificationManager.subTitle = prompt.promptTime;
    _notificationManager.userInfo = prompt.mj_keyValues;
    _notificationManager.imageName = @"share_icon";
    _notificationManager.repeatInterval = NSCalendarUnitWeekday;
    _notificationManager.isRepeat = YES;
    [_notificationManager addNotificaitons];
}

- (void)mergeNotificaitons:(NSArray *)prompts {
    [_notificationManager cancelAllNotificaitons];
    for (int i = 0; i < prompts.count; i ++) {
        HealthyPrompt *prompt = prompts[i];
        if (prompt.isEnable) {
            [self addNotification:prompt];
        }
    }
}

- (void)cancelNotificaiton:(HealthyPrompt *)prompt {
    [_notificationManager cancelNotification:prompt.promptId];
}

@end
