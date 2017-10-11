//
//  FileManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (NSString *)openNativePlistFile:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return path;
}

@end
