//
//  DatePickerView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)dateFrom:(NSDate *)from to:(NSDate *)to;

@end

@interface DatePickerView : UIView

@property (assign, nonatomic) NSCalendarUnit flag;
@property (strong, nonatomic) NSDate *dateFrom;
@property (strong, nonatomic) NSDate *dateTo;
@property (strong, nonatomic) NSDate *dateStart;
@property (assign, nonatomic) id<DatePickerViewDelegate> delegate;


- (void)changeDateFrom:(NSDate *)from to:(NSDate *)to;

@end
