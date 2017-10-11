//
//  OpenMediaManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OpenMediaManagerDelegate <NSObject>

- (void)openFaild:(NSString *)message;
- (void)finishChoose:(UIImage *)image;

@end

@interface OpenMediaManager : NSObject

@property (strong, nonatomic) UIViewController *rootVC;

@property (assign, nonatomic) UIImagePickerControllerSourceType sourceType;

@property (assign, nonatomic) id<OpenMediaManagerDelegate> delegate;

- (instancetype)initWithRootViewController:(UIViewController *)rootVC;
- (void)openMediaController;

+ (OpenMediaManager *)checkAuthorizationWithSourceType:(UIImagePickerControllerSourceType)sourceType rootViewController:(UIViewController *)rootVC;

@end
