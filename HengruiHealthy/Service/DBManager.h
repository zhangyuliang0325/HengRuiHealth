//
//  DBManager.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface DBManager : NSObject

- (void)openDB:(NSString *)pathName;

@end
