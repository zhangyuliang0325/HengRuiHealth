//
//  HDClick+CoreDataProperties.m
//  
//
//  Created by Mac on 2017/9/20.
//
//

#import "HDClick+CoreDataProperties.h"

@implementation HDClick (CoreDataProperties)

+ (NSFetchRequest<HDClick *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HDClick"];
}

@dynamic click_id;
@dynamic create_time;
@dynamic is_enable;
@dynamic is_vibrating;
@dynamic remark;
@dynamic click_time;
@dynamic ring;
@dynamic title;
@dynamic user_id;
@dynamic weekdays_string;
@dynamic weekday_names;
@dynamic weekday_codes;
@dynamic hour;
@dynamic minute;
@dynamic person;

@end
