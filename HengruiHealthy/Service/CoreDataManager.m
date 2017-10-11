//
//  CoreDataManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

static CoreDataManager *instance = nil;

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataManager alloc] init];
    });
    return instance;
}
//等效属性--因为只有get方法
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//1.模型文件对象
-(NSManagedObjectModel *)managedObjectModel{
    //懒加载
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //获取到自己创建的coredatamodel文件的路径
    NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:@"Address" withExtension:@"momd"];//后缀名
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    return _managedObjectModel;
}

//2.创建协调器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator !=nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];//PS:这里需要点语法
    
    //数据库的存储路径
    NSURL *storeUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/address.sqlite"]];
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    //给协调器添加一个可持久化的对象
    NSPersistentStore *persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                                   configuration:nil
                                                                                             URL:storeUrl
                                                                                         options:nil
                                                                                           error:&error];
    
    if (!persistentStore) {
        //有错误
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort()会是app退出,然后生成一个崩溃日志
        //在开发阶段使用ok,但是发布的时候要注释掉.
        abort();
    }
    return _persistentStoreCoordinator;
}
//3.上下文
-(NSManagedObjectContext *) managedObjectContext{
    if (_managedObjectContext !=nil) {
        return _managedObjectContext;
    }
    //拷贝一份协调器
    NSPersistentStoreCoordinator *psc = [self persistentStoreCoordinator];
    //判断是否为空
    if (!psc) {
        return nil;
    }
    //创建对象，并设置操作类型，在主队列
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //协调器
    _managedObjectContext.persistentStoreCoordinator = psc;
    
    return _managedObjectContext;
}

//方法实现，当存储数据需要改变时调用  --增加，删除，更新操作
-(void)saveContext{
    NSManagedObjectContext *context = self.managedObjectContext;
    if (context != nil) {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            //如果context发生变化，会发生crash
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        //如果context没有发生变化,不会进入...
    }
}

@end
