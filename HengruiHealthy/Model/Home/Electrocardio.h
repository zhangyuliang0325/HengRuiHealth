//
//  Electrocardio.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface Electrocardio : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *measureTime;
@property (copy, nonatomic) NSString *T;
@property (copy, nonatomic) NSString *R;
@property (copy, nonatomic) NSString *P;
@property (copy, nonatomic) NSString *QTC2;
@property (copy, nonatomic) NSString *QTC1;
@property (copy, nonatomic) NSString *QT;
@property (copy, nonatomic) NSString *PR;
@property (copy, nonatomic) NSString *Equal;
@property (copy, nonatomic) NSString *Duration;
@property (copy, nonatomic) NSString *heartrate;



@end
