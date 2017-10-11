//
//  CoreDataManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

//创建单例
+(instancetype)shareManager;
//定义三个必要的属性，这里使用懒加载
//mo上下文
@property(nonatomic,strong,readonly)NSManagedObjectContext *managedObjectContext;
//mo模型
@property(nonatomic,strong,readonly)NSManagedObjectModel *managedObjectModel;
//协调器
@property(nonatomic,strong,readonly)NSPersistentStoreCoordinator *persistentStoreCoordinator;
//保存上下文方法
-(void)saveContext;


@end
