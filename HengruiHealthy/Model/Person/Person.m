//
//  Person.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"personId":@"Id",
             @"sex":@"Sex",
             @"nickname":@"Nickname", 
             @"realName":@"FullName",
             @"mobile":@"MobileNumber",
             @"identity":@"IdcardNumber",
             @"birth":@"Birthday",
             @"tel":@"PhoneNumber",
             @"occupation":@"UserJob",
             @"qualification":@"AcademicQualification",
             @"unit":@"WorkUnit",
             @"duties":@"UserDuties",
             @"provice":@"DefaultAddressProvince",
             @"city":@"DefaultAddressCity",
             @"distribute":@"DefaultAddressDistrict",
             @"address":@"DefaultAddressDetail",
             @"lititude":@"DefaultAddressLatitude",
             @"longitude":@"DefaultAddressLongitude",
             @"district":@"Addresses[0].District",
             @"town":@"Addresses[0].City",
             @"province":@"Addresses[0].Province",
             @"detail":@"Addresses[0].Detail",
             @"addressId":@"Addresses[0].Id"
             };
}

- (instancetype)init {
    if (self = [super init]) {
        self.personId = @"";
        self.sex = @"";
        self.realName = @"";
        self.mobile = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAccount];
        self.identity = @"";
        self.birth = @"";
        self.tel = @"";
        self.occupation = @"";
        self.qualification = @"";
        self.unit = @"";
        self.duties = @"";
        self.lititude = @"";
        self.longitude = @"";
        self.province = @"省选择";
        self.town = @"市选择";
        self.district = @"区/县选择";
        self.detail = @"";
        self.addressId = @"";
    }
    return self;
}

@end

