//
//  EAIntroViewManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EAIntroViewManager.h"

#import "CustomEAIntroPage.h"

@interface EAIntroViewManager () {
    
}

@end

@implementation EAIntroViewManager


+ (void)configEAIntroViewInView:(UIView *)view pages:(NSArray *)pageSources delegate:(id)delegate{
    EAIntroView *introView = [[EAIntroView alloc] init];
    introView.frame = view.bounds;
    
    introView.delegate = delegate;
    NSMutableArray *pages = [NSMutableArray array];
    if ([pageSources[0] isKindOfClass:[NSString class]]) {
        for (int i = 0; i < pageSources.count; i ++) {
            CustomEAIntroPage *pageView = [[[NSBundle mainBundle] loadNibNamed:@"CustomEAIntroPage" owner:self options:nil] firstObject];
            pageView.imageURL = pageSources[i];
            [pageView loadImage];
            EAIntroPage *page = [EAIntroPage pageWithCustomView:pageView];
            [pages addObject:page];
        }
    } else {
        for (int i = 0; i < pageSources.count; i ++) {
            EAIntroPage *page = [[EAIntroPage alloc] init];
            page.bgImage = pageSources[i];
            [pages addObject:page];
        }
    }
    introView.pages = pages;
//    introView.skipButton.hidden = YES;
    [introView.skipButton setTitle:@"立即体验" forState:UIControlStateNormal];
    introView.skipButton.layer.borderWidth = 1;
    introView.skipButton.layer.borderColor = [UIColor whiteColor].CGColor;
    introView.skipButton.layer.cornerRadius = 3;
    introView.showSkipButtonOnlyOnLastPage = YES;
    introView.skipButtonAlignment = EAViewAlignmentCenter;
    introView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    introView.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    introView.pageControl.hidden = YES;
    [introView showInView:view];
}



+ (void)CreateEAIntroViewWithEAIntroViewConfig:(EAIntroViewConfig *)config {
    EAIntroViewManager *manager = [[EAIntroViewManager alloc] init];
    [manager configEAIntroView:config];
}

- (instancetype)init {
    if (self = [super init]) {
        self.config = [[EAIntroViewConfig alloc] init];
    }
    return self;
}

- (void)createIntroViewInView:(UIView *)view {
    EAIntroView *introView = [[EAIntroView alloc] init];
    [introView showInView:view];
    self.introView = introView;
}

- (void)configEAIntroPagesWithSources:(NSArray *)source {
    NSMutableArray *pages = [NSMutableArray array];
    if ([source[0] isKindOfClass:[NSString class]]) {
        for (int i = 0; i < source.count; i ++) {
            CustomEAIntroPage *pageView = [[[NSBundle mainBundle] loadNibNamed:@"" owner:self options:nil] firstObject];
            pageView.imageURL = source[i];
            [pageView loadImage];
            EAIntroPage *page = [EAIntroPage pageWithCustomView:pageView];
            [pages addObject:page];
        }
    } else {
        for (int i = 0; i < source.count; i ++) {
            EAIntroPage *page = [[EAIntroPage alloc] init];
            page.bgImage = source[i];
            [pages addObject:page];
        }
    }
    self.introView.pages = pages;
}

- (void)resetSkipButton:(UIButton *)button {
    self.introView.skipButton.hidden = YES;
    [self.introView addSubview:button];
}

- (void)configSkipButtonWithBGColor:(UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius alignment:(EAViewAlignment)alignment {
    self.introView.skipButton.hidden = NO;
    self.introView.skipButton.backgroundColor = bgColor;
    self.introView.skipButton.clipsToBounds = YES;
    self.introView.skipButton.layer.cornerRadius = cornerRadius;
    self.introView.skipButtonAlignment = alignment;
}

- (void)configEAIntroviewPageControlWithCurrentColor:(UIColor *)currentColor otherColor:(UIColor *)otherColor {
    self.introView.pageControl.pageIndicatorTintColor = otherColor;
    self.introView.pageControl.currentPageIndicatorTintColor = currentColor;
}

- (void)configEAIntroView:(EAIntroViewConfig *)config {
    self.config = config;
    [self createIntroViewInView:config.EAIntroSuperView];
    [self configEAIntroPagesWithSources:config.pages];
    
    [self configEAIntroviewPageControlWithCurrentColor:config.pageControlCurrentColor otherColor:config.pageControlColor];
    if (config.skipButton) {
        [self resetSkipButton:config.skipButton];
    } else {
        [self configSkipButtonWithBGColor:config.skipButtonBGColor cornerRadius:config.skipButtonCornerRadius alignment:(EAViewAlignment)config.alignment];
    }
}

@end
