//
//  BlankPage.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlankPageDelegate <NSObject>

- (void)retry;

@end

@interface BlankPage : UIView

@property (assign, nonatomic) id<BlankPageDelegate> delegate;

@end
