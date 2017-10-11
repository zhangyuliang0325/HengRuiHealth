//
//  BloodFatInfo.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BloodFat.h"

@interface BloodFatInfo : UIView

@property (strong, nonatomic) BloodFat *fat;

- (void)configInfo;

@end
