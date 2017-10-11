//
//  AlertManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+ (UIAlertController *)infoDeficiencyAlert:(NSString *)message;
+ (UIAlertController *)autoDismissAlert:(NSString *)message;

@end
