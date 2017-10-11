//
//  EAIntroViewManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EAIntroViewConfig.h"

#import <EAIntroView/EAIntroView.h>

@interface EAIntroViewManager : NSObject

+ (void)configEAIntroViewInView:(UIView *)view pages:(NSArray *)pageSources delegate:(id)delegate;

@property (strong, nonatomic) id EAIntroViewDelegate;
@property (strong, nonatomic) EAIntroViewConfig *config;

@property (strong, nonatomic) EAIntroView *introView;

+ (void)CreateEAIntroViewWithEAIntroViewConfig:(EAIntroViewConfig *)config;

- (void)createIntroViewInView:(UIView *)view;
- (void)resetSkipButton:(UIButton *)button;
- (void)configSkipButtonWithBGColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius alignment:(EAViewAlignment)alignment;
- (void)configEAIntroView:(EAIntroViewConfig *)config;
- (void)configEAIntroPagesWithSources:(NSArray *)source;
- (void)configEAIntroviewPageControlWithCurrentColor:(UIColor *)currentColor otherColor:(UIColor *)ortherColor;

@end
