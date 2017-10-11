//
//  OrderAction.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface OrderAction : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *actionName;
@property (assign, nonatomic) id target;

@end
