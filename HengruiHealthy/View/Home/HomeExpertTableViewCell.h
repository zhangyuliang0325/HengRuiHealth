//
//  HomeExpertTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Expert.h"

@protocol HomeExpertCellDelegate <NSObject>

- (void)apointmentExpert:(Expert *)expert;

@end

@interface HomeExpertTableViewCell : UITableViewCell

@property (strong, nonatomic) Expert *expert;
@property (assign, nonatomic) id<HomeExpertCellDelegate> delegate;

- (void)loadCell;

@end
