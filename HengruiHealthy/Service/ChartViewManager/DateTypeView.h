//
//  DateTypeView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateTypeViewDelegate <NSObject>

- (void)changeToDateFlag:(NSCalendarUnit)flag;

@end

@interface DateTypeView : UIView

@property (strong, nonatomic) NSArray *types;
@property (assign, nonatomic) NSInteger selectIndex;
@property (assign, nonatomic) NSCalendarUnit flag;
@property (assign, nonatomic) id<DateTypeViewDelegate> delegate;

- (void)configView;

@end
