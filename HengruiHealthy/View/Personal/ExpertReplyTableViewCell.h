//
//  ExpertReplyTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentRemark.h"
#import "Expert.h"

@interface ExpertReplyTableViewCell : UITableViewCell

@property (strong, nonatomic) AppointmentRemark *reply;
@property (strong, nonatomic) Expert *expert;

- (void)loadCell;

@end
