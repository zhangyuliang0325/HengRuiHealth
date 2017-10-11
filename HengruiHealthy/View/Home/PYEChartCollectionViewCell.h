//
//  PYEChartCollectionViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Fat.h"

@interface PYEChartCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSArray *fat;

- (void)loadCell;

@end
