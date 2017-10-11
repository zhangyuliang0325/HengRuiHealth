//
//  PromptManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/20.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HealthyPrompt.h"

@interface PromptManager : NSObject

@property (strong, nonatomic) HealthyPrompt *prompt;

- (void)addNotification:(HealthyPrompt *)prompt;
- (void)cancelNotificaiton:(HealthyPrompt *)prompt;
- (void)mergeNotificaitons:(NSArray *)prompts;

@end
