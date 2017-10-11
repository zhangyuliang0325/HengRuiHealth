//
//  AttachReplyTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentRemark.h"

@interface AttachReplyTableViewCell : UITableViewCell

@property (strong, nonatomic) AppointmentRemark *reply;

- (void)loadCell;

@end
