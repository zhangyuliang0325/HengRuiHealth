//
//  ExpertSearchView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpertSearchDelegate <NSObject>

- (void)searchExpert:(NSString *)keyword;

@end

@interface ExpertSearchView : UIView

@property (assign, nonatomic) id<ExpertSearchDelegate> delegate;

@end
