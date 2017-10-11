//
//  ExpertListTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Expert.h"

@interface ExpertListTableViewCell : UITableViewCell

@property (strong, nonatomic) Expert *expert;

- (void)loadCell;

@end
