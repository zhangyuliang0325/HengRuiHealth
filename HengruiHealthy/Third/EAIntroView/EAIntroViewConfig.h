//
//  EAIntroViewConfig.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConfigEAViewAlignment) {
    ConfigEAViewAlignmentLeft,
    ConfigEAViewAlignmentCenter,
    ConfigEAViewAlignmentRight,
};

@interface EAIntroViewConfig : NSObject

@property (strong, nonatomic) UIColor *pageControlCurrentColor;
@property (strong, nonatomic) UIColor *pageControlColor;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIView *EAIntroSuperView;

@property (assign, nonatomic) BOOL useDefaultSkipButton;
@property (assign, nonatomic) ConfigEAViewAlignment alignment;
@property (strong, nonatomic) UIColor *skipButtonBGColor;
@property (assign, nonatomic) BOOL ifCornerSkipButton;
@property (assign, nonatomic) CGFloat skipButtonCornerRadius;

@property (strong, nonatomic) NSArray *pages;

@end
