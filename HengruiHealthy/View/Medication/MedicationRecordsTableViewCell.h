//
//  MedicationRecordsTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MedicationRecord.h"

@protocol MedicationRecordCellDelegate <NSObject>

- (void)deleteRecord:(MedicationRecord *)record;
- (void)editRecord:(MedicationRecord *)record;

@end

@interface MedicationRecordsTableViewCell : UITableViewCell

@property (strong, nonatomic) MedicationRecord *record;
@property (assign, nonatomic) id<MedicationRecordCellDelegate> delegate;

- (void)loadCell;

@end
