//
//  HealthyArchiveListFooter.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthyArchiveListFootDelegate <NSObject>

- (void)addArchiveFooter;

@end

@interface HealthyArchiveListFooter : UIView

@property (assign, nonatomic) id<HealthyArchiveListFootDelegate> delegate;

@end
