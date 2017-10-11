//
//  Expert.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface Expert : NSObject

@property (copy, nonatomic) NSString *expertId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *aptitude;
@property (copy, nonatomic) NSString *speciality;
@property (copy, nonatomic) NSString *duties;
@property (copy, nonatomic) NSString *util;
@property (assign, nonatomic) CGFloat price;
@property (copy, nonatomic) NSString *evalue;
@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSString *qualification;

@property (strong, nonatomic) NSMutableArray *qualificationURLs;

@end
