//
//  AlertManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+ (UIAlertController *)infoDeficiencyAlert:(NSString *)message {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:message
                                                                message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancel];
    return ac;
}

+ (UIAlertController *)autoDismissAlert:(NSString *)message {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:message
                                                                message:nil preferredStyle:UIAlertControllerStyleAlert];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ac dismissViewControllerAnimated:YES completion:nil];
    });
    return ac;
}

@end
