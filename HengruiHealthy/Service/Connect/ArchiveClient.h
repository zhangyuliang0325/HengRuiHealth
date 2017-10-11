//
//  ArchiveClient.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiveClient : NSObject

+ (instancetype)shareInstance;

- (void)savePhotos:(NSArray *)photos handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)saveHealthyArchiveWithParameter:(NSDictionary *)parameters handler:(void(^)(id response, BOOL isSuccess))handler;
-(void)obtainArchiveListForUser:(NSString *)userId pageNumber:(NSString *)pageNumber limit:(NSString *)limit from:(NSString *)from to:(NSString *)to handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)obtainArchiveDetail:(NSString *)archiveId forUser:(NSString *)userId handler:(void(^)(id response, BOOL isSuccess))handler;
- (void)removeArchive:(NSString *)archiveId handler:(void(^)(id response, BOOL isSuccess))handler;

@end
