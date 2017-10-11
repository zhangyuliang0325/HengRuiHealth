//
//  MBPrograssManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MBPrograssManager.h"

@implementation MBPrograssManager

+ (MBProgressHUD *)showPrograssOnView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = @"请稍等...";
    hud.contentColor = [UIColor orangeColor];
    [hud showAnimated:YES];
    return hud;
}
+ (MBProgressHUD *)showPrograssOnMainView {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self showPrograssOnView:vc.view];
}
+ (void)hidePrograssFromView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}
+ (void)hidePrograssFromMainView{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self hidePrograssFromView:vc.view];
}
+ (void)showMessage:(NSString *)message OnView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.minShowTime = 1;
    hud.contentColor = [UIColor orangeColor];
    [hud hideAnimated:YES afterDelay:1];
}
+ (void)showMessageOnMainView:(NSString *)message {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self showMessage:message OnView:vc.view];
}

@end
