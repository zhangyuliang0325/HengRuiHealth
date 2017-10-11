//
//  MedicaitonClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicaitonClient : NSObject

+ (instancetype)shareInstance;

- (void)getMedication:(NSString *)keywords page:(NSString *)page limit:(NSString *)limit handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)getMedicationRecords:(NSString *)userId page:(NSString *)page limit:(NSString *)limit min:(NSString *)min max:(NSString *)max handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)addMedicationRecord:(NSString *)recordId user:(NSString *)userId from:(NSString *)from to:(NSString *)to remark:(NSString *)remark medications:(NSArray *)medications handler:(void(^)(id response, BOOL isSuccess))handler;

@end
