//
//  Family.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

//#import <MJExtension/MJExtension.h>

@interface Family : NSObject

@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *familyId;
@property (strong, nonatomic) Person *person;
@property (assign, nonatomic) BOOL isLogin;

@end
