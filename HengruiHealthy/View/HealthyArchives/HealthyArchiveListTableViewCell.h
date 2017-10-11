//
//  HealthyArchiveListTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HealthyArchive.h"

@protocol HealthyArchiveListCellDelegate <NSObject>

- (void)reviewArchive:(HealthyArchive *)archive;

@end

@interface HealthyArchiveListTableViewCell : UITableViewCell

@property (strong, nonatomic) HealthyArchive *archive;
@property (assign, nonatomic) CGFloat dateLead;
@property (assign, nonatomic) CGFloat codeLead;

@property (assign, nonatomic) id<HealthyArchiveListCellDelegate> delegate;

- (void)loadCell;

@end
