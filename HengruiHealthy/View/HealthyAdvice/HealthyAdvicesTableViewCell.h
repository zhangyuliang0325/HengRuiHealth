//
//  HealthyAdvicesTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HealthyAdvice.h"

@protocol HealthyAdviceCellDelegate <NSObject>

- (void)reviewAdvice:(HealthyAdvice *)advice;

@end

@interface HealthyAdvicesTableViewCell : UITableViewCell

@property (strong, nonatomic) HealthyAdvice *advice;
@property (assign, nonatomic) id<HealthyAdviceCellDelegate> delegate;

- (void)loadCell;

@end
