//
//  HDCoreDataManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDCoreDataManager.h"

@interface HDCoreDataManager () {
    NSManagedObjectContext *_context;
}

@end

@implementation HDCoreDataManager

- (instancetype)init {
    if (self = [super init]) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    }
    return self;
}

- (void)persistanceContentWithName:(NSString *)name {
//    NSError *erro = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"momd"];
//    [[NSFileManager defaultManager] removeItemAtURL:modelURL error:&erro];
    NSString *storePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/%@.sqlite", name];
//    [[NSFileManager defaultManager] removeItemAtPath:storePath error:&erro];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
     NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
        [[NSFileManager defaultManager] createFileAtPath:storePath contents:nil attributes:nil];
    }
    NSError *error = nil;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:storePath] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    } else {
        _context.persistentStoreCoordinator = coordinator;
    }
}

- (BOOL)insertEntity:(NSString *)name configObject:(void(^)(NSManagedObject *newEntity))config {
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:_context];
    config(obj);
    return [self saveContext];
}

- (BOOL)modifyEntity {
    return [self saveContext];
}

- (BOOL)saveContext {
    NSError *error = nil;
    BOOL result = [_context save:&error];
    if (error) {
        [NSException raise:@"访问数据库错误" format:@"%@", error.localizedDescription];
    }
    return result;
}

- (BOOL)removeEntity:(NSManagedObject *)entity {
    [_context deleteObject:entity];
    return [self saveContext];
}

- (NSArray *)queryEntities:(NSString *)entityName sort:(NSString *)key{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSError *error = nil;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:NO];
    request.sortDescriptors = @[sort];
    NSArray *entities = [_context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", error.localizedDescription];
    }
    return entities; 
}

@end
