//
//  EvalueTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentTableViewCell.h"

@interface EvalueTableViewCell : AppointmentTableViewCell


@property (strong, nonatomic) NSIndexPath *indexPath;
@property (copy, nonatomic) void(^reloadEvalueCell)(CGFloat cellHeight, NSIndexPath *indexPath);

@end
