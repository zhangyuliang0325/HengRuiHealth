//
//  ElectrocardioInfo.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Electrocardio.h"

@interface ElectrocardioInfo : UIView

@property (strong, nonatomic) Electrocardio *electrocardio;

- (void)configView;

@end
