//
//  EvalueArchiveContentView.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvalueArchiveContentView : UIView

@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) CGFloat height;

- (void)loadView;

@end
