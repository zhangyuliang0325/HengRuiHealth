//
//  AddMedicationsViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddMedication.h"

@interface AddMedicationsViewController : UIViewController

@property (copy, nonatomic) NSString *recordId;

@property (strong, nonatomic) NSDate *from;
@property (strong, nonatomic) NSDate *to;

@property (strong, nonatomic) NSMutableArray *medications;
@property (strong, nonatomic) NSMutableArray *addMedications;

@end
