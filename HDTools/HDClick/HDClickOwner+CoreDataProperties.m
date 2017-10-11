//
//  HDClickOwner+CoreDataProperties.m
//  
//
//  Created by Mac on 2017/9/20.
//
//

#import "HDClickOwner+CoreDataProperties.h"

@implementation HDClickOwner (CoreDataProperties)

+ (NSFetchRequest<HDClickOwner *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HDClickOwner"];
}

@dynamic person_id;
@dynamic sex;
@dynamic nickname;
@dynamic real_name;
@dynamic mobile;
@dynamic identity;
@dynamic birth;
@dynamic tel;
@dynamic occupation;
@dynamic qualification;
@dynamic unit;
@dynamic duties;
@dynamic lititude;
@dynamic longitude;
@dynamic province;
@dynamic town;
@dynamic district;
@dynamic detail;
@dynamic address_id;

@end
