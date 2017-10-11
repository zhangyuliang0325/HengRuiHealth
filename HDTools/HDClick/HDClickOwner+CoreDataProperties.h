//
//  HDClickOwner+CoreDataProperties.h
//  
//
//  Created by Mac on 2017/9/20.
//
//

#import "HDClickOwner+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HDClickOwner (CoreDataProperties)

+ (NSFetchRequest<HDClickOwner *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *person_id;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *nickname;
@property (nullable, nonatomic, copy) NSString *real_name;
@property (nullable, nonatomic, copy) NSString *mobile;
@property (nullable, nonatomic, copy) NSString *identity;
@property (nullable, nonatomic, copy) NSString *birth;
@property (nullable, nonatomic, copy) NSString *tel;
@property (nullable, nonatomic, copy) NSString *occupation;
@property (nullable, nonatomic, copy) NSString *qualification;
@property (nullable, nonatomic, copy) NSString *unit;
@property (nullable, nonatomic, copy) NSString *duties;
@property (nullable, nonatomic, copy) NSString *lititude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *province;
@property (nullable, nonatomic, copy) NSString *town;
@property (nullable, nonatomic, copy) NSString *district;
@property (nullable, nonatomic, copy) NSString *detail;
@property (nullable, nonatomic, copy) NSString *address_id;

@end

NS_ASSUME_NONNULL_END
