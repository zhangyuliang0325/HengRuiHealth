//
//  Expert.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "Expert.h"

#import "CheckStringManager.h"

@implementation Expert

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"expertId":@"Id",
             @"name":@"Name",
             @"avatar":@"SmallImageUrl",
             @"aptitude":@"Profile",
             @"speciality":@"Expertise",
             @"duties":@"Duties",
             @"util":@"Hospital",
             @"price":@"ConsultPrice",
             @"evalue":@"Evaluate",
             @"level":@"DutiesGrade",
             @"qualification":@"Qualification"
             };
}

- (void)setQualification:(NSString *)qualification {
    _qualification = qualification;
    if (![CheckStringManager checkBlankString:qualification]) {
        NSArray *urls = [qualification componentsSeparatedByString:@";"];
        if (urls.count != 0 && urls != nil) {
            [urls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (self.qualificationURLs == nil) {
                    self.qualificationURLs = [NSMutableArray array];
                }
                [self.qualificationURLs addObject:obj];
            }];
        }
    }
}




@end
