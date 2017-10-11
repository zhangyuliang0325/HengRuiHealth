//
//  HDStatisticsView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDStatisticsView : UIView

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property (strong, nonatomic) NSArray *portraitDatas;
@property (strong, nonatomic) NSArray *transverseDatas;

- (void)configView;

@end
