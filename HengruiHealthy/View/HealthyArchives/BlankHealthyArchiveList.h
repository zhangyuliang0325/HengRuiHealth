//
//  BlankHealthyArchiveList.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlankHealthyArchiveListDelegate <NSObject>

- (void)addArchiveBlank;

@end

@interface BlankHealthyArchiveList : UIView

@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isHideMessage;
@property (assign, nonatomic) BOOL isHideButton;
@property (assign, nonatomic) id<BlankHealthyArchiveListDelegate> delegate;

@end
