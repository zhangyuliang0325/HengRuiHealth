//
//  CutFamily.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/12.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Family.h"

@protocol CutFamilyDelegate <NSObject>

- (void)cutAccount:(Family *)family;
- (void)deleteFamily:(Family *)family;

@end

@interface CutFamily : UIView

@property (strong, nonatomic) Family *family;
@property (assign, nonatomic) id<CutFamilyDelegate> delegate;

- (void)show;
- (void)hide;

- (void)hideDelegate:(BOOL)isHide;

@end
