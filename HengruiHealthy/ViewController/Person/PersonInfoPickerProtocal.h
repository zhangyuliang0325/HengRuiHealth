//
//  PersonInfoPickerProtocal.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PersonAreaLevel) {
    PersonAreaLevelProvince,
    PersonAreaLevelCity,
    PersonAreaLevelDistribute
};

@protocol PersonInfoPickerDelegate <NSObject>

- (void)selectRowForTitle:(NSString *)title;

@end

@interface PersonInfoPickerProtocal : NSObject

@property (strong, nonatomic) NSArray *sources;
@property (assign, nonatomic) PersonAreaLevel level;

@property (assign, nonatomic) id<PersonInfoPickerDelegate> delegate;

@end
