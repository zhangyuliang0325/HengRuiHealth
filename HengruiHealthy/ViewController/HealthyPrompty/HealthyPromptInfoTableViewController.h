//
//  HealthyPromptInfoTableViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HDClick+CoreDataModel.h"

#import "HealthyPrompt.h"

@protocol HealthyPromptInfoDelegate <NSObject>

- (void)chooseWeekdays;

@end

@interface HealthyPromptInfoTableViewController : UITableViewController

@property (strong, nonatomic) HDClick *click;
@property (strong, nonatomic) HealthyPrompt *prompt;
@property (assign, nonatomic) id<HealthyPromptInfoDelegate> delegate;

- (void)setRecycle:(NSString *)recycle;
- (void)setRing:(NSString *)ring;
- (void)setVibrating:(BOOL)isVibrating;
- (NSString *)getRemark;

@end
