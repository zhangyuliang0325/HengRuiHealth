//
//  ExpertEvalueContent.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HealthyArchive.h"

//#import <MJExtension/MJExtension.h>

@interface ExpertEvalueContent : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger starCount;
@property (copy, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray *archives;

@end
