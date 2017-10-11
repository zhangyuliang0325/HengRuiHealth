//
//  ExpertEvalueLabel.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertEvalueLabel.h"

@implementation ExpertEvalueLabel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"labelId":@"Id",
             @"labelContent":@"Tag",
             @"labelCount":@"TagCount"
             };
}

- (NSString *)labelText {
    return [NSString stringWithFormat:@"%@ (%@)", _labelContent, _labelCount];
}

@end
