//
//  AppointmentTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "AppointmentRecord.h"

@protocol AppointmentCellDelegate <NSObject>

- (void)pay:(AppointmentRecord *)record;
- (void)prompt:(AppointmentRecord *)record;
- (void)detail:(AppointmentRecord *)record;
- (void)complete:(AppointmentRecord *)record;
- (void)report:(AppointmentRecord *)record;
- (void)service:(AppointmentRecord *)record;
- (void)evalue:(AppointmentRecord *)record;

@end

@interface AppointmentTableViewCell : UITableViewCell

@property (strong, nonatomic) AppointmentRecord *record;
@property (assign, nonatomic) id<AppointmentCellDelegate> delegate;

- (void)loadCell;

@end
