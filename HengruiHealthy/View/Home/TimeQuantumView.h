//
//  TimeQuantumView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TimeType) {
    TimeStart,
    TimeEnd
};

@protocol TimeQuantunDelegate <NSObject>

- (NSDate *)calculateMaxDate;
- (NSDate *)calculateDateWithChooseDate:(NSDate *)date type:(TimeType)type;

@end

@interface TimeQuantumView : UIView

@property (assign, nonatomic) TimeType type;
@property (assign, nonatomic) id<TimeQuantunDelegate> delegate;

@end
