//
//  CheckStringManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckStringManager : NSObject

FOUNDATION_EXTERN NSString *const passwordRegular;
FOUNDATION_EXPORT NSString *const mobileRegular;
FOUNDATION_EXPORT NSString *const vertityRegular;

+ (instancetype)shareInstance;
+ (BOOL)checkBlankString:(NSString *)string;
+ (BOOL)checkString:(NSString *)string inputExpressions:(NSString *)exp;
+ (BOOL)checkPassword:(NSString *)password;
+ (BOOL)checkMobile:(NSString *)mobile;
+ (BOOL)checkVertity:(NSString *)vertity;
+ (BOOL)verifyIDCardNumber:(NSString *)IDCardNumber;

@end
