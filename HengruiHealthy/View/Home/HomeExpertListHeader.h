//
//  HomeExpertListHeader.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ExpertType) {
    reviewExpert,
    priceExpert,
    aptitudeExpert
};

@protocol HomeExpertListHeaderDelegate <NSObject>

- (void)findExpertByType:(ExpertType)type;

@end

@interface HomeExpertListHeader : UIView

@property (assign, nonatomic) ExpertType type;
@property (assign, nonatomic) id<HomeExpertListHeaderDelegate> delegate;

@end
