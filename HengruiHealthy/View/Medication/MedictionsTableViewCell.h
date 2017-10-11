//
//  MedictionsTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Medication.h"

@protocol MedicationCellDelegate <NSObject>

- (void)chooseMedication:(Medication *)medication withState:(BOOL)state;
- (void)reviewMedication:(Medication *)medication;

@end


@interface MedictionsTableViewCell : UITableViewCell

@property (strong, nonatomic) Medication *medication;
@property (assign, nonatomic) id<MedicationCellDelegate> delegete;

- (void)loadCell;

@end
