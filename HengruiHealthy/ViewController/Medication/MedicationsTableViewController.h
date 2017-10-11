//
//  MedicationsTableViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MedicationsDelegate <NSObject>

- (void)saveMeidcations:(NSArray *)medications;

@end

@interface MedicationsTableViewController : UITableViewController

@property (assign, nonatomic) id<MedicationsDelegate> delegate;

@end
