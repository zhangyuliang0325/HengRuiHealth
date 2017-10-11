//
//  PersonInfoManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoManager : NSObject

+ (instancetype)shareInstance;

- (NSInteger)calculateAge:(NSString *)birthYear;
- (BOOL)distinguishSex:(NSInteger)code;
- (NSDate *)obtainBirthday:(NSString *)birth;

@end
