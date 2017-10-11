//
//  ExpertReviewViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppointmentRecord.h"
#import "SystemMessage.h"

@interface ExpertReviewViewController : UIViewController

@property (strong, nonatomic) AppointmentRecord *record;
@property (nonatomic,retain) SystemMessage *message;       //通过系统信息页面进行跳转过来的model
@property (nonatomic,copy) NSString *fromWhere;            //1.正常   2.其他

@end
