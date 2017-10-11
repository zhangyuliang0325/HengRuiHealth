//
//  ArchivesService.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesService.h"

#import "Electrocardio.h"
#import "RoutineUrine.h"
#import "BloodFat.h"
#import <MJExtension.h>
@implementation ArchivesService


+ (NSArray *)repleaceDicArray:(NSArray *)dicArray toModelArray:(NSString *)modelType {
    if ([modelType isEqualToString:@"QueryURDataV1"]) {
        dicArray = [RoutineUrine mj_objectArrayWithKeyValuesArray:dicArray];
    } else if ([modelType isEqualToString:@"QueryBD_FATDataV1"]) {
        dicArray = [BloodFat mj_objectArrayWithKeyValuesArray:dicArray];
    } else {
        dicArray = [Electrocardio mj_objectArrayWithKeyValuesArray:dicArray];
    }
    return dicArray;
}

@end
