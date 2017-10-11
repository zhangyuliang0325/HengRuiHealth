//
//  ArchiveClient.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchiveClient.h"

#import "Connecter.h"

#import "CheckStringManager.h"

@implementation ArchiveClient

+ (instancetype)shareInstance {
    static ArchiveClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[ArchiveClient alloc] init];
    });
    return client;
}

- (void)savePhotos:(NSArray *)photos handler:(id)handler {
    NSString *fileName = @"System/UploadFile";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"RestrictType"] = @"个人健康资料";
    NSMutableArray *photoDatas = [NSMutableArray array];
    for (UIImage *photo in photos) {
        NSData *photoData = UIImageJPEGRepresentation(photo, 0.5);
        [photoDatas addObject:photoData];
    }
    [[Connecter shareInstance] uploadFiles:photoDatas forPath:fileName parameters:parameters result:handler];
}

- (void)saveHealthyArchiveWithParameter:(NSDictionary *)parameters handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/SaveHealthRecord";
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

- (void)obtainArchiveListForUser:(NSString *)userId pageNumber:(NSString *)pageNumber limit:(NSString *)limit from:(NSString *)from to:(NSString *)to handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryHealthRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"UserId"] = userId;
    parameters[@"PageIndex"] = pageNumber;
    parameters[@"QueryLimit"] = limit;
    if (from != nil) {
        parameters[@"RecordTimeMin"] = from;
    }
    if (to != nil) {
        parameters[@"RecordTimeMax"] = to;
    }
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)obtainArchiveDetail:(NSString *)archiveId forUser:(NSString *)userId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/QueryHealthRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Id"] = archiveId;
    parameters[@"UserId"] = userId;
    parameters[@"IsGetOne"] = @"true";
    [[Connecter shareInstance] connectServerGetWithPath:file parameters:parameters result:handler];
}

- (void)removeArchive:(NSString *)archiveId handler:(void (^)(id, BOOL))handler {
    NSString *file = @"Health/DeleteHealthRecord";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@""] = archiveId;
    [[Connecter shareInstance] connectServerPostWithPath:file parameters:parameters result:handler];
}

@end
