//
//  AppointmentArchiveTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/25.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HealthyArchive.h"

@protocol AppoinmentArchiveCellDelegate <NSObject>

@optional

- (BOOL)chooseArchive:(HealthyArchive *)archive select:(BOOL)select;
- (void)reviewArchive:(HealthyArchive *)archive;

@end

@interface AppointmentArchiveTableViewCell : UITableViewCell

@property (strong, nonatomic) HealthyArchive *archive;
@property (assign, nonatomic) id<AppoinmentArchiveCellDelegate> delegate;

- (void)loadCell;

@end
