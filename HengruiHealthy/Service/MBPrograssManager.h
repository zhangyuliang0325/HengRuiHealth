//
//  MBPrograssManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBPrograssManager : NSObject

+ (MBProgressHUD *)showPrograssOnView:(UIView *)view;
+ (MBProgressHUD *)showPrograssOnMainView;
+ (void)hidePrograssFromView:(UIView *)view;
+ (void)hidePrograssFromMainView;
+ (void)showMessage:(NSString *)message OnView:(UIView *)view;
+ (void)showMessageOnMainView:(NSString *)message;

@end
