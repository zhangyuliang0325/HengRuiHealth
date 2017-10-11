//
//  EvalueExpert.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentRecord.h"

@protocol EvalueExpertDelegate <NSObject>

- (void)submitEvalue:(NSDictionary *)evalue forRecord:(AppointmentRecord *)record;

@end

@interface EvalueExpert : UIView

FOUNDATION_EXTERN NSString *const EVALUESTARCOUNT;
FOUNDATION_EXTERN NSString *const EVALUECONTENT;
FOUNDATION_EXTERN NSString *const EVALUELABELS;
FOUNDATION_EXTERN NSString *const EVALUECATEGORY;

@property (strong, nonatomic) AppointmentRecord *record;

@property (strong, nonatomic) NSArray *goodEvalueLabels;
@property (strong, nonatomic) NSArray *badEvalueLabels;

@property (assign, nonatomic) id<EvalueExpertDelegate> delegate;

- (void)configUI;

@end
