//
//  ChoosePromptWeekday.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoosePromptWeekdayDelegate <NSObject>

//- (void)choosedWeekdayNames:(NSArray *)names codes:(NSArray *)codes;
- (void)choosedWeekdaysName:(NSString *)name;

@end

@interface ChoosePromptWeekday : UIView

@property (assign, nonatomic) id<ChoosePromptWeekdayDelegate> delegate;

- (void)show;
- (void)hide;

- (void)setSelectDays:(NSArray *)days names:(NSArray *)names;

@end
