//
//  HDCoreDataManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface HDCoreDataManager : NSObject

- (void)persistanceContentWithName:(NSString *)name;

- (BOOL)insertEntity:(NSString *)name configObject:(void(^)(NSManagedObject *newEntity))config;
- (BOOL)modifyEntity;
- (BOOL)removeEntity:(NSManagedObject *)entity;
- (NSArray *)queryEntities:(NSString *)entityName sort:(NSString *)key;


@end
