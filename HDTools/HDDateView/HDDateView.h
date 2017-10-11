//
//  HDDateView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDDateViewType) {
    dateViewForm,
    dateViewTo
};

@protocol HDDateViewDelegate <NSObject>

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type;

@end

@interface HDDateView : UIView

@property (strong, nonatomic, readwrite) UIDatePicker *inputView;
@property (strong, nonatomic, readwrite) UIView *inputAccessoryView;
@property (assign, nonatomic) CGFloat textWidth;

@property (strong, nonatomic) NSDate *inputDate;

@property (assign, nonatomic) HDDateViewType type;

@property (assign, nonatomic) id<HDDateViewDelegate> delegate;

@property (copy, nonatomic) NSString *(^formatDateString)(NSString *dateString);

- (void)repleaceView;

@end
