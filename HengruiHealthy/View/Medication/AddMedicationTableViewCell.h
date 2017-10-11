//
//  AddMedicationTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddMedication.h"

typedef NS_ENUM(NSInteger, MedicationInteval) {
    medicaitonAtMorning,
    medicationAtAfternoon,
    medicationAtEvening
};

@protocol AddMedicationCellDelegate <NSObject>

- (void)medication:(AddMedication *)medication inInterval:(MedicationInteval)inteval dosage:(NSString *)dosage selecte:(BOOL)isSelect;
- (void)deleteMedication:(AddMedication *)medication;
- (void)reviewMedication:(AddMedication *)medication;

@end

@interface AddMedicationTableViewCell : UITableViewCell

@property (strong, nonatomic) AddMedication *medication;
@property (assign, nonatomic) id<AddMedicationCellDelegate> delegate;

- (void)loadCell;

@end
