//
//  PayTableViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Expert.h"

@interface PayTableViewController : UITableViewController

@property (strong, nonatomic) Expert *expert;
@property (copy, nonatomic) NSString *orderId;
@property (copy, nonatomic) NSString *birth;
@property (copy, nonatomic) NSString *reply;
@property (strong, nonatomic) NSArray *archives;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *archiveIds;
//@property (copy, nonatomic) NSString *remark;


@end
