//
//  AppointmentDetailTableViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentRecord.h"

@interface AppointmentDetailTableViewController : UITableViewController

@property (strong, nonatomic) AppointmentRecord *record;
@property (copy, nonatomic) NSString *recordId;

@end
