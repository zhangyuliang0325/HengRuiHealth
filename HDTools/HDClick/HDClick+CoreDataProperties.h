//
//  HDClick+CoreDataProperties.h
//  
//
//  Created by Mac on 2017/9/20.
//
//

#import "HDClick+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HDClick (CoreDataProperties)

+ (NSFetchRequest<HDClick *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *click_id;
@property (nullable, nonatomic, copy) NSString *create_time;
@property (nonatomic) BOOL is_enable;
@property (nonatomic) BOOL is_vibrating;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *click_time;
@property (nullable, nonatomic, copy) NSString *ring;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *user_id;
@property (nullable, nonatomic, copy) NSString *weekdays_string;
@property (nullable, nonatomic, retain) NSObject *weekday_names;
@property (nullable, nonatomic, retain) NSObject *weekday_codes;
@property (nonatomic) int32_t hour;
@property (nonatomic) int32_t minute;
@property (nullable, nonatomic, retain) HDClickOwner *person;

@end

NS_ASSUME_NONNULL_END
