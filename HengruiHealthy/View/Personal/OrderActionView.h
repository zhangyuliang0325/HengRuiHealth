//
//  OrderActionView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderActionView : UIView

@property (assign, nonatomic) CGRect frame;

@property (strong, nonatomic) NSArray *orderActions;

- (instancetype)initWithFrame:(CGRect)frame;

@end
