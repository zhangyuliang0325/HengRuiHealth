//
//  ArchivesTableViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/28.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivesTableViewController : UITableViewController

FOUNDATION_EXTERN NSString *const ROUTINEURINEURL;
FOUNDATION_EXTERN NSString *const BLOODFATURL;
FOUNDATION_EXTERN NSString *const ELECTROCARDIOURL;

@property (copy, nonatomic) NSString *fileName;

@end
