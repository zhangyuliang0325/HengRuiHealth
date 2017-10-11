//
//  PersonInfoTableViewController+PersonInfoManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonInfoTableViewController.h"

@interface PersonInfoTableViewController (PersonInfoManager)

- (NSInteger)calculateAge:(NSString *)birthYear;
- (BOOL)distinguishSex:(NSInteger)code;
- (NSDate *)obtainBirthday:(NSString *)age;

- (NSArray *)obtainProvinces;
- (NSArray *)obtainCitysByProvince:(NSString *)province;
- (NSArray *)obtainDistributesByCity:(NSString *)city;

@end
