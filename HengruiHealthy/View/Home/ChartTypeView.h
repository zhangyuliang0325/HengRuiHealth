//
//  ChartTypeView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChartType) {
    ChartTypeDay,
    ChartTypeWeek,
    ChartTypeMonth
};

@protocol ChartTypeDelegate <NSObject>

- (void)chooseButtonForType:(ChartType)type;

@end

@interface ChartTypeView : UIView

@property (assign, nonatomic) ChartType type;
@property (assign, nonatomic) id<ChartTypeDelegate> delegate;

@end
